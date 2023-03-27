import 'package:flutter/material.dart';

import 'package:yatri_app/components/appBar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        //homepage

        body: Container(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      child: Row(
        children: const [
          Text(
            "Home",
            style: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ],
      ),
    ));
  }
}
