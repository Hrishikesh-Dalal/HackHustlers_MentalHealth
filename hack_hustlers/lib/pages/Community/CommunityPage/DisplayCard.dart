// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:hack_hustlers/pages/Community/CommunityPage/Fetchdata.dart';
// import 'package:intl/intl.dart';

// // ... (other imports)

// Future<List<Widget>> getCommunityCards(String? id) async {
//   // Get community data
//   List<Map<String, dynamic>> communityDataList = await getCommunityData();

//   // Convert each data map to a Card widget with replies handling
//   return communityDataList.map((data) => _buildCommunityCard(data)).toList();
// }

// class ReplyState extends ChangeNotifier {
//   bool _showReplies = false;
//   List<Map<String, dynamic>> _replies = [];

//   bool get showReplies => _showReplies;
//   List<Map<String, dynamic>> get replies => _replies;

//   void toggleReplies() async {
//     if (_showReplies) {
//       _replies = []; // Clear previous replies
//     } else {
//       await _fetchReplies(widget.id); // Fetch replies using widget.id
//     }
//     _showReplies = !_showReplies;
//     notifyListeners();
//   }

//   Future<void> _fetchReplies(String documentId) async {
//     final _firestore = FirebaseFirestore.instance;
//     final docRef = _firestore
//         .collection('Collection')
//         .doc(documentId)
//         .collection('replies');
//     final snapshot = await docRef.get();

//     _replies = snapshot.docs.map((doc) => doc.data()).toList();
//   }
// }

// Widget _buildCommunityCard(Map<String, dynamic> data) {
//   final replyState = ReplyState();

//   return Padding(
//     padding:
//         const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
//     child: Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Display user (if available)
//             if (data['user'] != null) Text(data['user']),
//             const SizedBox(height: 8.0),

//             // Display date (formatted)
//             // Text(DateFormat.yMMMd().format(data['date'])), // Adjust format as needed
//             const SizedBox(height: 16.0),

//             // Display content
//             Text(data['content']),

//             // Divider for separation
//             const Divider(),

//             // Dropdown arrow for showing/hiding replies
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 IconButton(
//                   icon: Icon(
//                     replyState.showReplies
//                         ? Icons.expand_less
//                         : Icons.expand_more,
//                   ),
//                   onPressed: () => replyState.toggleReplies(),
//                 ),
//               ],
//             ),

//             // Conditionally display reply section
//             if (replyState.showReplies) _buildReplySection(replyState.replies),
//           ],
//         ),
//       ),
//     ),
//   );
// }

// Widget _buildReplySection(List<Map<String, dynamic>> replies) {
//   if (replies.isEmpty) {
//     return const Text('No replies yet.');
//   }

//   return Column(
//     children: replies.map((reply) => _buildReply(reply)).toList(),
//   );
// }

// Widget _buildReply(Map<String, dynamic> reply) {
//   // Display reply content, user (if available), and date (formatted)
//   return Row(
//     children: [
//       if (reply['user'] != null) Text(reply['user'] + ': '),
//       Text(reply['content']),
//       const Spacer(),
//       Text(DateFormat.yMMMd().format(reply['date'])), // Adjust format as needed
//     ],
//   );
// }
