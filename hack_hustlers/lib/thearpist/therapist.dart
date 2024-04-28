import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hack_hustlers/thearpist/allTherapists.dart';


class Therapist extends StatefulWidget {
  const Therapist({super.key});

  @override
  State<Therapist> createState() => _TherapistState();
}

class _TherapistState extends State<Therapist> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> allDocs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 50,
          ),
          Container(
            padding: const EdgeInsets.only(left: 20),
            alignment: Alignment.centerLeft,
            child: const Text(
              "Recommended Therapists",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255,79,60,127),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            height: 800,
            child: StreamBuilder(
              stream: _firestore.collection('Therapists').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    allDocs = snapshot.data!.docs.toList();
                    return ListView.builder(
                      //scrollDirection: Axis.vertical,
                      itemCount: allDocs.length,
                      itemBuilder: (context, index) {
                        final doc = allDocs[index].data();
                        return InkWell(
                          splashColor: Colors.blue,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TherapistsDetails(doct: doc),
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Card(
                              color: Color.fromARGB(255, 232, 228, 228),
                              child: Container(
                                margin: const EdgeInsets.only(top: 8),
                                //color: const Color.fromARGB(255, 108, 199, 242),
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 0),
                                // width: MediaQuery.of(context).size.width,
                                // height: MediaQuery.of(context).size.height / 9,
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                          NetworkImage('${doc['image upload']}'),
                                      backgroundColor: Color.fromARGB(255,79,60,127),
                                      radius: 30,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          doc['name'],
                                          style: const TextStyle(
                                              color:
                                                  Color.fromARGB(255,79,60,127),
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          doc['speciality'],
                                          style: const TextStyle(
                                              //color: Colors.white, fontSize: 14
                                              ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          "Experience: ${doc['exp']} years",
                                          style: const TextStyle(
                                              //color: Colors.white, fontSize: 14
                                              ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text( "Fees : Rs ${doc['fees']}",
                                          style: const TextStyle(
                                              //color: Colors.white, fontSize: 14
                                              ),      
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('$snapshot.hasError.toString()');
                  } else {
                    return const Center(
                      child: Text('No data found'),
                    );
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ]),
      ),
    );
  }
}
