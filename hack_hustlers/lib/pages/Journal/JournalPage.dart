import 'package:flutter/material.dart';
import 'package:hack_hustlers/pages/Journal/JournalPages/Display.dart';
import 'package:hack_hustlers/pages/Journal/JournalPages/DisplayList.dart';
import 'package:hack_hustlers/pages/Journal/JournalPages/FetchFromFirebase.dart';
import 'package:hack_hustlers/pages/Journal/JournalPages/NegativePage.dart';
import 'package:hack_hustlers/pages/Journal/JournalPages/PositivePage.dart';

class JournalPage extends StatefulWidget {
  final String? id;
  JournalPage({required this.id});
  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Journal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Journal(
        id: widget.id,
      ),
    );
  }
}

class Journal extends StatefulWidget {
  final String? id;
  Journal({required this.id});
  @override
  _JournalState createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  List<Map<String, dynamic>> positiveEmotionsList = [];
  List<Map<String, dynamic>> negativeEmotionsList = [];

  @override
  void initState() {
    super.initState();
    fetchPositiveEmotions(); // Fetch data on app launch
    fetchNegativeEmotions();
  }

  Future<void> fetchPositiveEmotions() async {
    try {
      positiveEmotionsList = await getPositiveEmotions(
          widget.id); // Assuming getPositiveEmotions function retrieves data
      setState(() {}); // Update state to rebuild with fetched data
    } catch (error) {
      // Handle error (e.g., display error message)
      print("Error fetching positive emotions: $error");
    }
  }

  Future<void> fetchNegativeEmotions() async {
    try {
      negativeEmotionsList = await getNegativeEmotions(
          widget.id); // Assuming getPositiveEmotions function retrieves data
      setState(() {}); // Update state to rebuild with fetched data
    } catch (error) {
      // Handle error (e.g., display error message)
      print("Error fetching negative emotions: $error");
    }
  }

  Widget buildEmotionsList(List<Map<String, dynamic>> emotions) {
    return ListView.builder(
      itemCount: emotions.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            child: ListTile(
              // Wrap ListTile in InkWell for onTap functionality
              onTap: () {
                // Handle card tap event here
                // You can navigate to another screen, show a dialog, etc.
                // onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(
                      date: emotions[index]['timestamp']
                          .toString()
                          .substring(0, 11),
                      content: emotions[index]['note'],
                    ),
                  ),
                );
// }

                print(
                    'Card tapped!'); // Example action (replace with your logic)
              },
              title: Text(
                emotions[index]['timestamp'].toString().substring(0, 11),
              ),
              subtitle: Text(
                emotions[index]['note'],
                style: const TextStyle(fontSize: 18.0),
                maxLines: 2,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Journal'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PositivePage(
                                id: widget.id,
                              )),
                    );
                  },
                  child: Card(
                    child: Container(
                      width: 170,
                      height: 200,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Something you are feeling estatic about...',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NegativePage(
                                id: widget.id,
                              )),
                    );
                  },
                  child: Card(
                    child: Container(
                      width: 170,
                      height: 200,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Something you are feeling down about...',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Your Positive Emotions',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: positiveEmotionsList.isNotEmpty
                ? buildEmotionsList(positiveEmotionsList)
                : Center(child: Text('No history yet')),
          ),
          SizedBox(height: 20),
          Text(
            'Your Negative Emotions here',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: negativeEmotionsList.isNotEmpty
                ? buildEmotionsList(negativeEmotionsList)
                : Center(child: Text('No history yet')),
          ),
        ],
      ),
    );
  }
}
