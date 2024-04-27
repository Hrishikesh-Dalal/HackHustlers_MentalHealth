import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail'; // Define route name

  final String date;
  final String content;

  const DetailPage({Key? key, required this.date, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SingleChildScrollView(
            // Allow content to scroll if it overflows
            child: Padding(
              padding: const EdgeInsets.all(20.0), // Add padding around content
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 24.0), // Inner padding for content
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date: $date',
                        style: const TextStyle(
                            fontSize: 18.0,
                            color: Colors.red), // Adjust font size
                      ),
                      const SizedBox(height: 16.0), // Spacing between elements
                      Text(
                        '$content',
                        style:
                            const TextStyle(fontSize: 16.0), // Adjust font size
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
