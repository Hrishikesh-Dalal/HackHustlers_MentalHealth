import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:doc_appoint/pages/BottomNavBar.dart';
// import 'package:doc_appoint/patient/BookedAppointments.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hack_hustlers/components/bottomNavBar.dart';
import 'package:intl/intl.dart';

class patientDetails extends StatefulWidget {
  final DateTime? selectedDate;
  final String? selectedSlot;
  final String? doctUid;

  patientDetails(
      {Key? key,
      required this.selectedDate,
      required this.selectedSlot,
      required this.doctUid})
      : super(key: key);

  @override
  State<patientDetails> createState() => _patientDetailsState();
}

class _patientDetailsState extends State<patientDetails> {
  String? errorMessage = '';

  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerGender = TextEditingController();
  final TextEditingController controllerFirstName = TextEditingController();
  final TextEditingController controllerMobile = TextEditingController();
  final TextEditingController controllerAge = TextEditingController();
  final TextEditingController controllerLastName = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _currentUserId;

  Future<void> storeDetails(BuildContext context) async {
    try {
      await _firestore.collection('Patient').doc().set({
        'First Name': controllerFirstName.text,
        'Last Name': controllerLastName.text,
        'Mobile': controllerMobile.text,
        'Age': controllerAge.text,
        'Gender': controllerGender.text,
        'Selected Date': widget.selectedDate.toString(),
        'Selected Slot': widget.selectedSlot,
        'Patient Uid': _currentUserId,
        'Doctor UID': widget.doctUid
      }).then(
        (value) {
          // BookedAppointments();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BottomNavBar()),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget entryField(String title, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: title,
        labelStyle:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : '$errorMessage');
  }

  Widget submitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        storeDetails(context);
      },
      child: const Text(
        'Book Appointment',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getCurrentUserId();
  }

  void _getCurrentUserId() async {
    final user = _auth.currentUser;
    if (user != null) {
      _currentUserId = user.uid;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 108, 199, 242),
        title: const Text('Welcome'),
      ),
      body: Container(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  // padding: EdgeInsets.only(
                  //     top: 10,
                  //     bottom: MediaQuery.of(context).viewInsets.bottom + 140,
                  //     left: 10,
                  //     right: 10),
                  padding: const EdgeInsets.all(14),

                  decoration: const BoxDecoration(
                    // image: DecorationImage(
                    //     image: AssetImage('assets/doc-pat.jpg'),
                    //     fit: BoxFit.cover),
                    color: Color.fromARGB(255, 108, 199, 242),
                  ),

                  child: Form(
                    child: Column(
                      children: <Widget>[
                        entryField('First Name', controllerFirstName),
                        const SizedBox(height: 10),
                        entryField('Last Name', controllerLastName),
                        const SizedBox(height: 10),
                        entryField('Age', controllerAge),
                        const SizedBox(height: 10),
                        entryField('Gender', controllerGender),
                        const SizedBox(height: 10),
                        entryField('Mobile Number', controllerMobile),
                        const SizedBox(height: 25),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                'Selected Date:  ${widget.selectedDate != null ? DateFormat('EEE, MMM d').format(widget.selectedDate!) : 'No date selected'}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Color.fromRGBO(21, 101, 192, 1),
                                ))),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                'Selected Slot:  ${widget.selectedSlot ?? 'No slot selected'}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Color.fromRGBO(21, 101, 192, 1),
                                ))),
                        _errorMessage(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 10,
                        ),
                        submitButton(context),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
