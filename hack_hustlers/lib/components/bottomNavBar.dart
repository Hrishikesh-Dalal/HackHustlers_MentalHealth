import 'package:firebase_auth/firebase_auth.dart';
import 'package:hack_hustlers/pages/chatbot.dart';
import 'package:hack_hustlers/pages/Community/community.dart';
import 'package:hack_hustlers/pages/home.dart';
import "package:flutter/material.dart";
import 'package:hack_hustlers/pages/Map/location.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currIndex = 0;
  PageController pageController = PageController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _userEmail;

  void initState() {
    super.initState();
    _getUserEmail();
  }

  Future<void> _getUserEmail() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        if (user.email != null) {
          _userEmail = user.email;
          debugPrint('User email: $_userEmail');
        } else {
          debugPrint('User email is null');
        }
      } else {
        debugPrint('User is not authenticated');
      }
    } catch (e) {
      debugPrint('Error retrieving user email: $e');
    }
  }

  void onTapped(int index) {
    setState(() {
      currIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [
          const HomePage(),
          const LocationPage(),
          const ChatBot(),
          CommunityPage(
            id: _userEmail,
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 80,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'Location',
              icon: Icon(Icons.location_city),
            ),
            BottomNavigationBarItem(
              label: 'Chat Bot',
              icon: Icon(Icons.games),
            ),
            BottomNavigationBarItem(
              label: 'Community',
              icon: Icon(Icons.people),
            ),
          ],
          currentIndex: currIndex,
          onTap: onTapped,
          //selectedItemColor: const Color.fromARGB(255, 108, 199, 242),
          selectedItemColor: const Color.fromARGB(255, 108, 199, 242),
        ),
      ),
    );
  }
}
