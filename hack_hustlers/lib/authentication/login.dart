import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:doc_appoint/doctor/doc_homepage.dart';
// import 'package:doc_appoint/pages/BottomNavBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hack_hustlers/authentication/signup.dart';
import 'package:hack_hustlers/pages/home.dart';
// import 'package:hack_hustlers/mood.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String? errorMessage = '';
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: controllerEmail.text,
        password: controllerPassword.text,
      );

      User? user = _auth.currentUser;

      QuerySnapshot snapshot = await _firestore
          .collection('User')
          .where('email', isEqualTo: user?.email)
          .get();
      if (snapshot.docs.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const UserSignUp()),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

 
  Widget entryField(String title, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      ),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : '$errorMessage');
  }

  Widget submitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        signInWithEmailAndPassword(context);
      },
      child: Text('Login'),
    );
  }

  Widget loginOrRegisterButton() {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const UserSignUp()),
        );
      },
      child: Text('Don\'t have an account? Sign Up instead'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Image.asset('assets/doctor.jpg'),
                color: Colors.white,
                height: 100,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                color: const Color.fromARGB(255, 108, 199, 242),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      entryField('email', controllerEmail),
                      entryField('password', controllerPassword),
                      _errorMessage(),
                      submitButton(context),
                      loginOrRegisterButton(),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Forgot Password ?",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
