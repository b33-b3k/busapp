import 'package:flutter/material.dart';
import 'package:yatri_app/components/textfield.dart';
import 'package:yatri_app/screens/login.dart';

import '../components/appBar.dart';
import '../main.dart';

class Verify extends StatelessWidget {
  const Verify({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //verify with email firebase
        appBar: ApppBar(
          () {
            Navigator.pop(context);
          },
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.verified_user,
              size: 200,
              color: Colors.green,
            ),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: const Text(
                  "You are verified!",
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              width: 300,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.black),
              child: TextButton(
                onPressed: () {
                  Navigator.popAndPushNamed(
                    context,
                    '/mapApp',
                  );
                },
                child: const Text(
                  "Get Started",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ));
  }
}
