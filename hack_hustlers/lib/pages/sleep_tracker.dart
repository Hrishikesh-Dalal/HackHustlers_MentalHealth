import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SleepTrackerPage extends StatefulWidget {
  @override
  _SleepTrackerPageState createState() => _SleepTrackerPageState();
}

class _SleepTrackerPageState extends State<SleepTrackerPage> {
  TextEditingController _sleepTimeController = TextEditingController();
  TextEditingController _wakeTimeController = TextEditingController();
  String _selectedSleepType="";
  String _selectedSleepEnvironment="";
  int _sleepScore=0;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<String> sleepTypes = ['Deep Sleep', 'Light Sleep', 'REM Sleep', 'Nap'];
  List<String> sleepEnvironments = [
    'Bedroom',
    'Living Room',
    'Outdoors',
    'Other'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sleep Tracker'),
        backgroundColor: Color.fromARGB(255, 108, 199, 242),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sleep Time:'),
            TextField(controller: _sleepTimeController),
            SizedBox(height: 16.0),
            Text('Wake Time:'),
            TextField(controller: _wakeTimeController),
            SizedBox(height: 16.0),
            Text('Sleep Type:'),
            DropdownButton(
              value: _selectedSleepType,
              onChanged: (newValue) {
                setState(() {
                  _selectedSleepType = newValue;
                });
              },
              items: sleepTypes.map,
                              ((sleepType) => DropdownMenuItem(
                      child: Text(sleepType),
                      value: sleepType,
                    ))).toList(),
            ),
            SizedBox(height: 16.0),
            Text('Sleep Environment:'),
            DropdownButton(
              value: _selectedSleepEnvironment,
              onChanged: (newValue) {
                setState(() {
                  _selectedSleepEnvironment = newValue;
                });
              },
              items: sleepEnvironments.map((environment) =>
                      DropdownMenuItem(
                        child: Text(environment),
                        value: environment,
                      )).toList(),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                generateSleepScore();
              },
              child: Text('Generate Sleep Score'),
            ),
            SizedBox(height: 16.0),
            if (_sleepScore != null)
              Text('Your Sleep Score: $_sleepScore'),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                saveSleepData();
              },
              child: Text('Save Sleep Data'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                showSleepStatistics();
              },
              child: Text('Show Sleep Statistics'),
            ),
          ],
        ),
    );
    
  }

  void saveSleepData() async {
    await firestore.collection('sleep_data').add({
      'sleep_time': _sleepTimeController.text,
      'wake_time': _wakeTimeController.text,
      'sleep_type': _selectedSleepType,
      'sleep_environment': _selectedSleepEnvironment,
      'sleep_score': _sleepScore,
      'timestamp': DateTime.now(),
    });
    // Clear text fields after saving
    _sleepTimeController.clear();
    _wakeTimeController.clear();
    _selectedSleepType = null;
    _selectedSleepEnvironment = null;
  }

  void showSleepStatistics() async {
    // Retrieve sleep data from Firestore and display statistics
  }

  void generateSleepScore() {
    // Calculate sleep score based on sleep data
    // Dummy logic for demonstration
    setState(() {
      _sleepScore = 80; // Example sleep score
    });
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: SleepTrackerPage(),
  ));
}

