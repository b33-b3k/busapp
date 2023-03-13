import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yatri_app/main.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _emailController = emailController,
        _passwordController = passwordController;

  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            final userCredentials =
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: email,
              password: password,
            );
            final user = FirebaseAuth.instance.currentUser;
            await user?.sendEmailVerification();
            Navigator.pushNamed(context, '/verify');
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
    );
  }
}
