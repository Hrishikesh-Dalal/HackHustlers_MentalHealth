import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Map<String, dynamic>>> getPositiveEmotions(String? userId) async {
  List<Map<String, dynamic>> positiveEmotionsList = [];

  try {
    // Get reference to the "PositiveEmotions" collection
    CollectionReference positiveEmotionsCollection = FirebaseFirestore.instance
        .collection('User')
        .doc(userId)
        .collection('PositiveEmotions');

    // Retrieve all documents from the collection
    QuerySnapshot querySnapshot = await positiveEmotionsCollection.get();

    // Extract data from each document and add it to the list
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      positiveEmotionsList.add({
        'note': data['note'],
        'timestamp':
            data['timestamp'].toDate(), // Convert Timestamp to DateTime
      });
    }

    print('Positive emotions retrieved successfully.');
  } catch (e) {
    print('Error retrieving positive emotions: $e');
  }

  return positiveEmotionsList;
}
