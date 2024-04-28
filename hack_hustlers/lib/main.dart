import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hack_hustlers/authentication/login.dart';
import 'package:hack_hustlers/pages/home.dart';
import 'firebase_options.dart';
import 'package:hack_hustlers/pages/sleep_tracker.dart';
import 'package:hack_hustlers/components/bottomNavBar.dart';

// await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
// );

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginView(),
    );
  }
}
