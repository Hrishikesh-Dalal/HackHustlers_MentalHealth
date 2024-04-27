import 'package:flutter/material.dart';
import 'package:hack_hustlers/pages/Journal/JournalPages/DisplayList.dart';
import 'package:hack_hustlers/pages/Journal/JournalPages/FetchFromFirebase.dart';
import 'package:hack_hustlers/pages/Journal/JournalPages/NegativePage.dart';
import 'package:hack_hustlers/pages/Journal/JournalPages/PositivePage.dart';

class JournalPage extends StatefulWidget {
  final String id;
  JournalPage({required this.id});
  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  final String id;
  Journal({required this.id});
  @override
  _JournalState createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  List<Map<String, dynamic>> positiveEmotionsList = [];

  @override
  void initState() {
    super.initState();
    fetchPositiveEmotions(); // Fetch data on app launch
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

  Widget buildPositiveEmotionsList(List<Map<String, dynamic>> emotions) {
    return ListView.builder(
      itemCount: emotions.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title:
                Text(emotions[index]['emotion']), // Assuming emotion key exists
            subtitle: Text(emotions[index]
                ['description']), // Assuming description key exists
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
                      MaterialPageRoute(builder: (context) => PositivePage()),
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
                      MaterialPageRoute(builder: (context) => NegativePage()),
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
            'History',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: positiveEmotionsList.isNotEmpty
                ? buildPositiveEmotionsList(positiveEmotionsList)
                : Center(child: Text('No history yet')),
          ),
        ],
      ),
    );
  }
}
