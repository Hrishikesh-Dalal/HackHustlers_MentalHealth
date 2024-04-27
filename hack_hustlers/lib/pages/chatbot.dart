import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hack_hustlers/components/navbar.dart';
import 'package:hack_hustlers/components/bottomNavBar.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  _ChatBotAppState createState() => _ChatBotAppState();
}

class _ChatBotAppState extends State<ChatBot> {
  @override
  void initState() {
    super.initState();
    openChatbot();
  }

  void openChatbot() async {
    try {
      var conversationObject = {
        'appId': '334d2b029b5b828d48ce2673f3809997e',
        'botIds': ['mental-health-xfxe1'],
      };
      dynamic result =
          await KommunicateFlutterPlugin.buildConversation(conversationObject);
      print('Chatbot opened: $result');
    } catch (e) {
      print('Error opening chatbot: $e');
      // Handle the error here, e.g., show a snackbar or navigate to an error screen.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(200, 300, 300, 200),
        title: Text('MentalHealth ChatBot'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Text(
            'Welcome to Mental Heaalth ChatBot\n       I am here to help you'),
      ),
    );
  }
}
