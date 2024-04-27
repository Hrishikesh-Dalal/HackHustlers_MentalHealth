import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ... (Existing code)

Widget buildPositiveEmotionsList(
    List<Map<String, dynamic>> positiveEmotionsList) {
  return ListView.builder(
    itemCount: positiveEmotionsList.length,
    itemBuilder: (context, index) {
      final noteData = positiveEmotionsList[index];
      final note = noteData['note'] as String;
      final timestamp =
          noteData['timestamp'] as Timestamp; // Assuming Timestamp

      return Card(
        child: ListTile(
          title: Text(note),
          subtitle:
              Text(timestamp.toDate().toString()), // Format timestamp as needed
        ),
      );
    },
  );
}
