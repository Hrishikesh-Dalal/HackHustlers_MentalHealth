import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter_circular_slider/flutter_circular_slider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hack_hustlers/pages/home.dart';
//import 'package:hack_hustlers/arc_progress_bar_new/arc_progress_bar_new.dart';
import 'package:arc_progress_bar_new/arc_progress_bar_new.dart';


class SleepData {
  final String sleepTime;
  final String wakeTime;
  final String sleepType;
  final String sleepEnvironment;
  final double sleepScore;

  SleepData({
    required this.sleepTime,
    required this.wakeTime,
    required this.sleepType,
    required this.sleepEnvironment,
    required this.sleepScore,
  });

  factory SleepData.fromMap(Map<String, dynamic> map) {
    return SleepData(
      sleepTime: map['sleep_time'],
      wakeTime: map['wake_time'],
      sleepType: map['sleep_type'],
      sleepEnvironment: map['sleep_environment'],
      sleepScore: map['sleep_score'],
    );
  }
}

class SleepTrackerPage extends StatefulWidget {
  @override
  _SleepTrackerPageState createState() => _SleepTrackerPageState();
}

class _SleepTrackerPageState extends State<SleepTrackerPage> {
  TextEditingController _sleepTimeController = TextEditingController();
  TextEditingController _wakeTimeController = TextEditingController();
  String? _selectedSleepType;
  String? _selectedSleepEnvironment;
  double _sleepScore=0.0;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<SleepData> sleepDataList = [];

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
      
      body: SingleChildScrollView(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               const  Text('Sleep Time:',
               style: TextStyle(fontWeight: FontWeight.bold),
                ),
                
                InkWell(
                  onTap: () {
                    _selectTime(context, _sleepTimeController);
                  },
                  child: IgnorePointer(
                    child: TextField(
                      style: TextStyle(color: Color.fromARGB(200, 200, 300, 300)),
                      
                      controller: _sleepTimeController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.access_time),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Text('Wake Time:',
                style: TextStyle(fontWeight: FontWeight.bold),),
                InkWell(
                  onTap: () {
                    _selectTime(context, _wakeTimeController);
                  },
                  child: IgnorePointer(
                    child: TextField(
                      style: TextStyle(color: Color.fromARGB(200, 200, 300, 300)),
                      controller: _wakeTimeController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.access_time),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Text('Sleep Type:',
                style: TextStyle(fontWeight: FontWeight.bold)),
                DropdownButton(
                  value: _selectedSleepType,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedSleepType = newValue as String?;
                    });
                  },
                  items: sleepTypes.map((sleepType) => DropdownMenuItem(
                    child: Text(sleepType),
                    value: sleepType,
                  )).toList(),
                ),
                SizedBox(height: 10.0),
                Text('Sleep Environment:',
                style: TextStyle(fontWeight: FontWeight.bold)
                ),
                DropdownButton(
                  value: _selectedSleepEnvironment,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedSleepEnvironment = newValue as String?;
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
                  child: Text('Generate Sleep Score',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  
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
                ArcProgressBar(
                   percentage: _sleepScore,
                  bottomLeftWidget: const Text("0"),
                  bottomRightWidget: const Text("100"),
                  bottomCenterWidget: const Text("Sleep Tracker"),
                  centerWidget:Image.asset("assets/sleep.jpg",height: 100,width:200),
                ), 
        
                
              
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _selectTime(BuildContext context, TextEditingController controller) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      controller.text = selectedTime.format(context);
    }
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
    _selectedSleepType = '';
    _selectedSleepEnvironment = '';
    _sleepScore = 0.0; // Reset sleep score
  }

  void showSleepStatistics() async {
    QuerySnapshot querySnapshot = await firestore
        .collection('sleep_data')
        .orderBy('timestamp', descending: true)
        .limit(7)
        .get();

    sleepDataList.clear();

    querySnapshot.docs.forEach((doc) {
      SleepData sleepData = SleepData.fromMap(doc.data() as Map<String, dynamic>);
      sleepDataList.add(sleepData);
    });

    setState(() {
      // Update chart data based on sleepDataList
    });
  }

  void generateSleepScore() {
    double score = 0;
    if (_selectedSleepType == 'Deep Sleep') {
      score += 40; // Example points for deep sleep
    } 
     else if (_selectedSleepType == 'Light Sleep') {
      score += 30; // Example points for REM sleep
    } 
    else if (_selectedSleepType == 'REM Sleep') {
      score += 15; // Example points for REM sleep
    } // Add points for other sleep types
     else if (_selectedSleepType == 'Nap') {
      score += 10; // Example points for REM sleep
    } 

    if (_selectedSleepEnvironment == 'Bedroom') {
      score += 50; // Example points for bedroom sleep environment
    } else if (_selectedSleepEnvironment == 'Living Room') {
      score += 30; // Example points for living room sleep environment
    } // Add points for other sleep environments
    else if (_selectedSleepEnvironment == 'Outdoors') {
      score += 20; // Example points for living room sleep environment
    }
    else {
      score +=10;
    }
    setState(() {
      _sleepScore = score;
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




