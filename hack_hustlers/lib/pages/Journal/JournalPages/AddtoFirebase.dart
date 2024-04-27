import 'package:cloud_firestore/cloud_firestore.dart';

void addToPositiveEmotions(String? userId, String positiveNote) async {
  try {
    // Get reference to the "PositiveEmotions" collection
    CollectionReference positiveEmotionsCollection = FirebaseFirestore.instance
        .collection('User')
        .doc(userId)
        .collection('PositiveEmotions');

    // Add the positive note to the "PositiveEmotions" collection
    await positiveEmotionsCollection.add({
      'note': positiveNote,
      'timestamp': FieldValue.serverTimestamp(), // Add timestamp
    });

    print('Positive note added successfully.');
  } catch (e) {
    print('Error adding positive note: $e');
  }
}

void addToNegativeEmotions(String? userId, String negativeNote) async {
  try {
    // Get reference to the "PositiveEmotions" collection
    CollectionReference positiveEmotionsCollection = FirebaseFirestore.instance
        .collection('User')
        .doc(userId)
        .collection('NegativeEmotions');

    // Add the positive note to the "PositiveEmotions" collection
    await positiveEmotionsCollection.add({
      'note': negativeNote,
      'timestamp': FieldValue.serverTimestamp(), // Add timestamp
    });

    print('Negative note added successfully.');
  } catch (e) {
    print('Error adding Negative note: $e');
  }
}
