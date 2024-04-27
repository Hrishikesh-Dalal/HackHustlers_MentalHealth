import 'package:flutter/material.dart';

class PositivePage extends StatefulWidget {
  @override
  _PositivePageState createState() => _PositivePageState();
}

class _PositivePageState extends State<PositivePage> {
  final _textController = TextEditingController();
  String _data = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Positive Note'),
      ),
      body: SingleChildScrollView(
        // Allow content to scroll if needed
        padding: EdgeInsets.all(20.0), // Pad entire body
        child: Card(
          elevation: 8.0,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 24.0,
                bottom: 50.0,
                left: 24.0,
                right: 24.0), // Increased card padding
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Express your positive thoughts:',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                Align(
                  alignment: Alignment.center,
                  child: TextField(
                    controller: _textController,
                    maxLines: null,
                    decoration: InputDecoration(
                        hintText: 'Write your positive note here...',
                        // border: OutlineInputBorder(),
                        fillColor: Colors.amber),
                  ),
                ),
                SizedBox(height: 100.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _data = _textController.text;

                      ///add for firebase
                    });
                    _textController.clear();
                  },
                  child: Text('Submit'),
                ),
                SizedBox(height: 10.0),
                if (_data.isNotEmpty)
                  Text(
                    //this will get removed
                    'Your Positive Note:\n$_data',
                    style: TextStyle(fontSize: 20.0),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
