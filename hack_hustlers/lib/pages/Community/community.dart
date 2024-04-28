import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import for user authentication
import 'package:flutter/material.dart';

class CommunityPage extends StatefulWidget {
  final String? id;
  CommunityPage({required this.id});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final _firestore = FirebaseFirestore.instance;
  final _replyController = TextEditingController();
  String inputText = '';

  // Initialize the map to store reply visibility
  Map<String, bool> _replyVisibility = {};

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Item'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                inputText = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Enter your text',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Submit'),
              onPressed: () async {
                // Firebase data submission logic
                final docId = _firestore.collection('Collection').doc().id;
                final now = DateTime.now();
                await _firestore.collection('Collection').doc(docId).set({
                  'date': FieldValue.serverTimestamp(),
                  'user': widget.id,
                  'content': inputText,
                });
                print('Submitted: $inputText');
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void deleteData(String? documentId) async {
    await FirebaseFirestore.instance
        .collection('Collection')
        .doc(documentId)
        .delete();
    print("User Deleted");
  }

  bool _isFilterActive = false;

  void _toggleFilter() {
    setState(() {
      _isFilterActive = !_isFilterActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 157, 157, 243),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Community'),
            ElevatedButton(
              onPressed: _toggleFilter,
              child: Text(
                "Sort",
              ),
              // ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Text(
          //   'Filter is ${_isFilterActive ? 'Active' : 'Inactive'}',
          //   style: TextStyle(fontSize: 20.0),
          // ),
          SizedBox(height: 20.0),
          // Padding(
          //   padding: const EdgeInsets.only(right: 10.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       ElevatedButton(
          //         onPressed: _toggleFilter,
          //         child: Text(
          //           "Reverse Sort",
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('Collection')
                  .orderBy('date', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final communities = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: communities.length,
                  itemBuilder: (context, index) {
                    final document = communities[index];
                    final content = document['content'] as String?;
                    final user = document['user'] as String?;
                    final date = document['date'] as Timestamp?;
                    final postId = document.id; // Get the document ID

                    // Initialize visibility for new posts
                    _replyVisibility[postId] ??= false;

                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Stack(
                            // Wrap content in a Stack for Positioned widget
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (user == widget.id)
                                        Text('By: You')
                                      else
                                        Text('By: Anonymous'),
                                      Text(date != null
                                          ? '${date.toDate().toString().substring(0, 11)}'
                                          : 'Date unavailable'),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    content ?? 'No Content',
                                    style: const TextStyle(fontSize: 18.0),
                                  ),
                                  const SizedBox(
                                      height:
                                          8.0), // Additional spacing for dropdown
                                  // Dropdown to toggle reply visibility
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      DropdownButton<bool>(
                                        value: _replyVisibility[postId],
                                        borderRadius: BorderRadius.zero,
                                        underline: Container(
                                          // Remove underline
                                          height: 0,
                                          color: Colors
                                              .transparent, // Transparent color
                                        ),
                                        items: [
                                          DropdownMenuItem(
                                            value: true,
                                            child: Text(
                                              'Show Replies',
                                              style: TextStyle(fontSize: 12.0),
                                            ),
                                          ),
                                          DropdownMenuItem(
                                            value: false,
                                            child: Text(
                                              'Hide Replies',
                                              style: TextStyle(fontSize: 12.0),
                                            ),
                                          ),
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            _replyVisibility[postId] = value!;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                      height:
                                          6.0), // Additional spacing after dropdown
                                  // Conditionally display reply section
                                  if (_replyVisibility[postId]!)
                                    _buildReplies(postId),
                                ],
                              ),
                              // Delete button positioned at bottom right
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  color: Colors.transparent,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 1.0),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      size: 20.0,
                                    ),
                                    color: Colors.black,
                                    splashColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    onPressed: () {
                                      // Confirmation dialog before deletion
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Confirm Delete'),
                                            content: const Text(
                                                'Are you sure you want to delete this post?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  // Call your deleteData function here
                                                  deleteData(postId);
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Delete'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDialog();
          print("hit");
        },
        tooltip: 'Add Item',
        child: Icon(Icons.add),
      ),
    );
  }

  // Widget to fetch and display replies
  Widget _buildReplies(String communityId) {
    return Column(
      children: [
        TextField(
          controller: _replyController,
          decoration: InputDecoration(hintText: 'Write a reply...'),
        ),
        ElevatedButton(
          onPressed: () => _addReply(communityId),
          child: Text('Add Reply'),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: _firestore
              .collection('Collection')
              .doc(communityId)
              .collection('Replies')
              .orderBy('date', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox.shrink();
            }
            final replies = snapshot.data!.docs;
            return Column(
              children: replies.map((replyDoc) {
                final replyContent = replyDoc['content'] as String?;
                final replyUser =
                    replyDoc['user'] != widget.id ? "Anonymous" : "You";
                final replyDate = replyDoc['date'] as Timestamp?;
                final replyId = replyDoc.id; // Get the reply document ID

                return Dismissible(
                  // Wrap ListTile in Dismissible
                  key: UniqueKey(), // Unique key for each reply
                  background: Container(
                    color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.delete, color: Colors.white),
                        const Text('Delete',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Delete',
                            style: TextStyle(color: Colors.white)),
                        const Icon(Icons.delete, color: Colors.white),
                      ],
                    ),
                  ),
                  // confirmDelete: true, // Ask for confirmation before deletion
                  onDismissed: (direction) {
                    if (direction == DismissDirection.endToStart ||
                        direction == DismissDirection.startToEnd) {
                      // Show confirmation dialog before deleting
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirm Delete'),
                            content: Text(
                                'Are you sure you want to delete this reply?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Call your deleteReply function here with replyId
                                  // deleteReply(replyId);
                                  // Navigator.pop(context);
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: ListTile(
                    dense: true,
                    leading: const Icon(Icons.reply, size: 18),
                    title: Text(replyContent ?? 'No Content'),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (replyUser == widget.id)
                          Text('By: You')
                        else
                          Text('By: Anonymous'),
                        Text(replyDate != null
                            ? '${replyDate.toDate().toString().substring(0, 11)}'
                            : 'Date unavailable'),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  Future<void> _addReply(String communityId) async {
    if (_replyController.text.isNotEmpty) {
      // Get reference to the 'replies' subcollection
      final repliesRef = _firestore
          .collection('Collection')
          .doc(communityId)
          .collection('Replies');
      // Add the new reply document
      await repliesRef.add({
        'content': _replyController.text,
        'user': widget.id,
        'date': Timestamp.now(),
      });
      // Clear the text field and update the UI
      _replyController.clear();
      setState(() {});
    }
  }
}
