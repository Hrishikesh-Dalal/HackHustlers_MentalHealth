import 'package:flutter/material.dart';

void showDataAlertWithImage(
    BuildContext context, String title, String content, String imagePath) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          // Allow scrolling for long content
          child: Column(
            mainAxisSize: MainAxisSize.min, // Prevent excessive height
            children: [
              Image.asset(imagePath), // Display the image
              SizedBox(height: 10.0), // Add spacing between image and text
              Text(
                content,
                style: TextStyle(wordSpacing: 2.0),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
