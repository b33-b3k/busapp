import 'package:firebase/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:yatri_app/components/appBar.dart';
import 'package:yatri_app/components/textfield.dart';

import '../main.dart';
import 'login.dart';

final auth = FirebaseAuth.instance;

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> registerUser() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User registered successfully")),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == "user-not-found") {
        errorMessage = "No user found for that email";
      } else if (e.code == "wrong-password") {
        errorMessage = "Wrong password provided for that user";
      } else if (e.code == "email-already-exists") {
        errorMessage = "Email already exists";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("errorMessage")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Container(
            padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
            child: IconButton(
              icon: const Icon(
                FeatherIcons.arrowLeftCircle,
                color: Colors.black,
                size: 40,
              ),
              onPressed: () async {
                final email = _emailController.text;
                final password = _passwordController.text;

                try {
                  final userCredentials = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  final user = FirebaseAuth.instance.currentUser;
                  await user?.sendEmailVerification();
                  Navigator.pushNamed(context, '/verify');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("User registered successfully")),
                  );
                } on FirebaseAuthException catch (e) {
                  String errorMessage;
                  if (e.code == "user-not-found") {
                    errorMessage = "No user found for that email";
                  } else if (e.code == "wrong-password") {
                    errorMessage = "Wrong password provided for that user";
                  } else if (e.code == "email-already-exists") {
                    errorMessage = "Email already exists";
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.code)),
                  );
                }
              },
            ),
          ),
          actions: [
            Container(
              padding: const EdgeInsets.all(20),
              child: const Icon(
                Icons.image,
                color: Colors.black,
              ),
            )
          ],
        ),
        body: Column(children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
            child: Row(
              children: const [
                Text(
                  "Sign Up",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
          ),
          textfield(Controller: userNameController, hinttext: 'Username'),
          textfield(
            Controller: _emailController,
            hinttext: 'Email',
          ),
          textfield(
            Controller: _passwordController,
            hinttext: 'Password',
            obscureText: true,
          ),
          textfield(
            Controller: confirmPassController,
            hinttext: 'Confirm Password',
            obscureText: true,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            width: 300,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.black),
            child: TextButton(
              onPressed: () async {
                final email = _emailController.text;
                final password = _passwordController.text;

                try {
                  final userCredentials = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  final user = FirebaseAuth.instance.currentUser;
                  await user?.sendEmailVerification();
                  Navigator.pushNamed(context, '/verify');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("User registered successfully")),
                  );
                } on FirebaseAuthException catch (e) {
                  String errorMessage;
                  if (e.code == "user-not-found") {
                    errorMessage = "No user found for that email";
                  } else if (e.code == "wrong-password") {
                    errorMessage = "Wrong password provided for that user";
                  } else if (e.code == "email-already-exists") {
                    errorMessage = "Email already exists";
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.code)),
                  );
                }
              },
              child: const Text(
                "Register",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
              child: Column(
            children: const [
              Divider(
                color: Colors.black,
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
              Text("Or Sign Up with",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w100,
                  )),
              SizedBox(
                height: 20,
              ),
              logoButtons(),
            ],
          ))
        ]));
  }
}
