import 'package:cloud_firestore/cloud_firestore.dart';

// ... (rest of your code)

Future<List<Map<String, dynamic>>> getCommunityData() async {
  // Get documents from the "Community" collection
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('Collection')
      .orderBy('date', descending: true) // Order by date (newest first)
      .get();
  print(snapshot);
  // Convert documents to a list of maps
  List<Map<String, dynamic>> communityDataList = snapshot.docs.map((doc) {
    return {
      'id': doc.id, // Include document ID
      'date': doc['date'].toDate(), // Convert Timestamp to DateTime
      'user': doc['user'],
      'content': doc['content'],
    };
  }).toList();

  return communityDataList;
}
