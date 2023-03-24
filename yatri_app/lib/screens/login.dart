import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yatri_app/components/googleSignIn.dart';
import 'package:yatri_app/main.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yatri_app/components/appBar.dart';
import 'package:yatri_app/components/textfield.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

final auth = FirebaseAuth.instance;
final currentUser = auth.currentUser;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ApppBar(
          () {
            Navigator.pop(context);
          },
        ),
        body: Column(children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: Row(
              children: const [
                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          textfield(
            hinttext: 'Email',
            Controller: emailController,
          ),
          textfield(
            hinttext: 'Password',
            Controller: passwordController,
            obscureText: true,
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            width: 300,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.black),
            child: TextButton(
              onPressed: () async {
                final email = emailController.text;
                final password = passwordController.text;

                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email, password: password);

                  final user = FirebaseAuth.instance.currentUser;
                  if (user != null && !user.emailVerified) {
                    await user.sendEmailVerification();
                  }

                  //login
////////////////////////////////////changed this
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
                "Login",
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                children: const [
                  Divider(
                    color: Colors.black,
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Text("Or Login with",
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

class logoButtons extends StatelessWidget {
  const logoButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
        child: IconButton(
          icon: const Icon(
            FontAwesomeIcons.facebook,
            color: Colors.blue,
            size: 40,
          ),
          onPressed: () {},
        ),
      ),
      Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: IconButton(
              icon: Icon(FontAwesomeIcons.google, size: 40),
              onPressed: () => {})),
      Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
        child: IconButton(
          icon: const Icon(
            FontAwesomeIcons.apple,
            color: Colors.grey,
            size: 40,
          ),
          onPressed: () {},
        ),
      ),
    ]
        //icon button

        );
  }
}
