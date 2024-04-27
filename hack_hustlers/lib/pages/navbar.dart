import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(accountName:const Text('UserName'), 
          accountEmail:const Text("Email"),
          currentAccountPicture: CircleAvatar(
            child: ClipOval(
              child:Icon(Icons.home),

            ),
          ),
          

          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile Page'),

          ),
          ListTile(
            leading: Icon(Icons.pages),
            title: Text('Journal Page'),

          ),
          ListTile(
            leading: Icon(Icons.face),
            title: Text('Activity'),

          ),
          ListTile(
            leading: Icon(Icons.flag),
            title: Text('Goal Tracker'),

          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log Out'),

          )
          

        ],
      ),
    );
  }
}