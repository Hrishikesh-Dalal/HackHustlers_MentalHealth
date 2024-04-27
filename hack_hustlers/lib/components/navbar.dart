// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// class NavBar extends StatelessWidget {
//   const NavBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         children: [
//           UserAccountsDrawerHeader(accountName:const Text('UserName'),
//           accountEmail:const Text("Email"),
//           currentAccountPicture: CircleAvatar(
//             child: ClipOval(
//               child:Icon(Icons.home),

//             ),
//           ),

//           ),
//           ListTile(
//             leading: Icon(Icons.person),
//             title: Text('Profile Page'),

//           ),
//           ListTile(
//             leading: Icon(Icons.pages),
//             title: Text('Journal Page'),

//           ),
//           ListTile(
//             leading: Icon(Icons.face),
//             title: Text('Activity'),

//           ),
//           ListTile(
//             leading: Icon(Icons.flag),
//             title: Text('Goal Tracker'),

//           ),
//           ListTile(
//             leading: Icon(Icons.logout),
//             title: Text('Log Out'),

//           )

//         ],
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hack_hustlers/Blog.dart';
import 'package:hack_hustlers/authentication/login.dart';
import 'package:hack_hustlers/pages/Activity.dart';
import 'package:hack_hustlers/pages/Journal/JournalPage.dart';
import 'package:hack_hustlers/utils.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
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

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
            color: Colors.black12,
            child: ListView(
              children: [
                DrawerHeader(
                  padding: const EdgeInsets.only(left: 20),
                  child: Container(
                    child: const Row(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              'https://images.ctfassets.net/hrltx12pl8hq/3Z1N8LpxtXNQhBD5EnIg8X/975e2497dc598bb64fde390592ae1133/spring-images-min.jpg'),
                        ),
                        SizedBox(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text('ABC EFGH'), Text('abc@gmail.com')],
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                    leading: Icon(Icons.person),
                    title: Text('My Profile'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JournalPage(id: _userEmail),
                          ));
                    }),
                ListTile(
                    leading: Icon(Icons.note),
                    title: Text('Journal'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JournalPage(id: _userEmail),
                          ));
                    }),
                ListTile(
                    leading: Icon(Icons.face),
                    title: Text('Activity'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Activity(),
                          ));
                    }),
                ListTile(
                    leading: Icon(Icons.pages),
                    title: Text('Blog'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Blog(),
                          ));
                    }),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Log out'),
                  onTap: () {
                    _auth.signOut().then((value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginView(),
                        ),
                      ).onError((error, stackTrace) =>
                          Utils().toastmessage(error.toString()));
                    });
                  },
                ),
              ],
            )));
  }
}
