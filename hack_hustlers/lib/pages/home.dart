import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hack_hustlers/pages/navbar.dart';
import 'package:hack_hustlers/pages/bottomNavBar.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(200, 300 ,300, 200),
        title:Text('Mental Health') ,

      

      

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
          //currentIndex: currIndex,
          //onTap: onTapped,
          //selectedItemColor: const Color.fromARGB(255, 108, 199, 242),
          selectedItemColor: const Color.fromARGB(255, 108, 199, 242),
        ),


    ),


    );
    
  }

}