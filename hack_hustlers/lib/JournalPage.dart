import 'package:flutter/material.dart';
import 'package:hack_hustlers/JournalPages/NegativePage.dart';
import 'package:hack_hustlers/JournalPages/PositivePage.dart';

// void main() {
//   runApp(MyApp());
// }

class JournalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Journal(),
      routes: {
        // '/history': (context) => HistoryPage(),
        // '/firstCardPage': (context) => FirstCardPage(),
        // '/secondCardPage': (context) => SecondCardPage(),
      },
    );
  }
}

class Journal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
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
                          builder: (context) => PositivePage(),
                        ));
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
                          builder: (context) => NegativePage(),
                        ));
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
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Container(
              // Add your history content here
              alignment: Alignment.center,
              child: Text('History content goes here'),
            ),
          ),
        ],
      ),
    );
  }
}
