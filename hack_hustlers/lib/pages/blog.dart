/*import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hack_hustlers/pages/home.dart';
import 'package:hack_hustlers/pages/sleep_tracker.dart';
import 'package:hack_hustlers/pages/bottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'dart:async';

import 'package:url_launcher/url_launcher.dart';


class Blog extends StatefulWidget {
  const Blog({super.key});

  @override
  State<Blog> createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Linkify(
            onOpen: _onOpen,
            text: "Made by https://cretezy.com \n\nMail: example@gmail.com \n\n  this is test http://pub.dev/ ",
          ),
        ),
    );
  }
 Future<void> _onOpen(LinkableElement link) async {
  final Uri uri = Uri.parse(link.url);
  if (await canLaunch(uri.toString())) {
    await launch(uri.toString());
  } else {
    throw 'Could not launch $link';
  };
}
}*/
/*import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class Blog extends StatefulWidget {
  const Blog({super.key});

  @override
  State<Blog> createState() => _BlogState();
}
void _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class _BlogState extends State<Blog> {
  //final Uri _url = Uri.parse('https://flutter.dev');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
              onTap: (
                
              )
              async {
                      const url = 'https://www.scaler.com';

                      if (await canLaunch(url)) {
                        await launch(url, forceSafariVC: false);
                      } else {
                        throw 'Could not launch $url';
                      }
              
               
                print('Entering tap');
                
                 // Replace with your desired URL
              },
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Visit Facebook',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
      ),
                  
                
    );
  }
  
}*/
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(urlLauncher());
}

_launchURL() async {
  const url = 'https://flutter.dev';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class urlLauncher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("URL LAUNCHER"),
            centerTitle: true,
          ),
          backgroundColor: Colors.lightBlue.shade100,
          body: Center(
            child: ElevatedButton(
              onPressed: _launchURL,
              child: Text('Goto Flutter docs',style: TextStyle(fontSize: 16),),
            ),
          ),
        ),
      ),
    );
  }
}



