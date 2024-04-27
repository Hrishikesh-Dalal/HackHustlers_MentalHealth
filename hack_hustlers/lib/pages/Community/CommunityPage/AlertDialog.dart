import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddItemDialog extends StatelessWidget {
  final String? Function(BuildContext context)
      getUserId; // Callback to get user ID

  const AddItemDialog({Key? key, required this.getUserId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firestore = FirebaseFirestore.instance;
    String inputText = '';
    print("reached here");
    void submitData() async {
      // Firebase data submission logic
      final docId =
          _firestore.collection('Community').doc().id; // Auto-generated ID
      final now = DateTime.now();
      await _firestore.collection('Community').doc(docId).set({
        'date': FieldValue
            .serverTimestamp(), // Add date field using server timestamp
        'userId': getUserId(context), // Use provided callback for user ID
        'content': inputText,
      });
      print('Submitted: $inputText');
    }

    return AlertDialog(
      title: Text('Add Item'),
      content: TextField(
        onChanged: (value) => inputText = value,
        decoration: InputDecoration(
          hintText: 'Enter your text',
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text('Submit'),
          onPressed: () {
            submitData();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
