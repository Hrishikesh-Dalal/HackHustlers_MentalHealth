import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hack_hustlers/pages/home.dart';
// import 'package:hack_hustlers/mood.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class UserSignUp extends StatefulWidget {
  const UserSignUp({Key? key}) : super(key: key);

  @override
  State<UserSignUp> createState() => _UserSignUpState();
}

class _UserSignUpState extends State<UserSignUp> {
  String? errorMessage = '';
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  String? _uploadedFileURL;
  Reference referenceRoot = FirebaseStorage.instance.ref();

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = pickedFile;
      } else {
        debugPrint('No image selected.');
      }
    });
  }

  Future<void> _uploadImage() async {
    Reference storageReference = FirebaseStorage.instance.ref().child(
        'user_profile_pictures/${DateTime.now().millisecondsSinceEpoch.toString()}.jpg');
    UploadTask uploadTask = storageReference.putFile(File(_imageFile!.path));
    await uploadTask.whenComplete(() async {
      await storageReference.getDownloadURL().then((fileURL) {
        setState(() {
          _uploadedFileURL = fileURL;
        });
      });
    });
  }

  Future<void> createDoctorAccount(BuildContext context) async {
    try {
      if (_imageFile != null) {
        await _uploadImage();
      }
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      await _firestore.collection('User').doc(emailController.text).set({
        'full name': nameController.text,
        'mobileNumber': mobileController.text,
        'age': ageController.text,
        'email': emailController.text,
        'uid': userCredential.user!.uid,
        'image upload': _uploadedFileURL,
      });

      

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    } catch (e) {
      debugPrint('Error saving data to Firestore: $e');
    }
  }

  Widget entryField(String title, TextEditingController controller,
      {bool isPassword = false}) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some value';
        }
        return null;
      },
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: title,
        labelStyle:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : '$errorMessage');
  }

  Widget submitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          createDoctorAccount(context);
        }
      },
      child:
          const Text('Sign Up', style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Container(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 10,
                    left: 10,
                    right: 10,
                  ),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/doc-pat.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: _pickImage,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey[200],
                            backgroundImage: _imageFile == null
                                ? null
                                : FileImage(File(_imageFile!.path)),
                            child: _imageFile == null
                                ? Icon(
                                    Icons.add_a_photo,
                                    size: 40,
                                    color: Colors.grey[800],
                                  )
                                : null,
                          ),
                        ),
                        const SizedBox(height: 10),
                        entryField('Name', nameController),
                        const SizedBox(height: 10),
                        entryField('Mobile Number', mobileController),
                        const SizedBox(height: 10),
                        entryField('Age', ageController),
                        const SizedBox(height: 10),
                        entryField('Email', emailController),
                        const SizedBox(height: 10),
                        entryField('Password', passwordController,
                            isPassword: true),
                        const SizedBox(height: 10),
                        _errorMessage(),
                        submitButton(context),
                      ],
                    ),
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
