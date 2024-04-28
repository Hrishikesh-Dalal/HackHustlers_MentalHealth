import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:hack_hustlers/pages/navbar.dart';
// import 'package:hack_hustlers/pages/bottomNavBar.dart';
import 'package:hack_hustlers/pages/sleep_tracker.dart';
//import 'package:webview_flutter/webview_flutter.dart';

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

//         backgroundColor: Color.fromARGB(200, 300 ,300, 200),
//         title:Text('Mental Health') ,

//       ),
//       //body: SleepTrackerPage(),
//         /*body:WebView(
//           initialUrl: 'https://example.com/your-mini-game',
//           javascriptMode: JavascriptMode.unrestricted,
//         ),*/

        backgroundColor: Color.fromARGB(199, 107, 107, 247),
        title: Text('Mental Health'),
      ),
// <<<<<<< NewUpdate
      // bottomNavigationBar: BottomNavBar(),
// =======
//       bottomNavigationBar: BottomNavBar(),

// >>>>>>> main
    );
  }
}
