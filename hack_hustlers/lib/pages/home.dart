import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hack_hustlers/authentication/login.dart';
import 'package:hack_hustlers/components/navbar.dart';
import 'package:hack_hustlers/components/bottomNavBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(199, 107, 107, 247),
        title: Text('Mental Health'),
      ),
      // bottomNavigationBar: BottomNavBar(),
    );
  }
}
