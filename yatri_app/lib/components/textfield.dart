import 'package:flutter/material.dart';

class textfield extends StatefulWidget {
  const textfield({
    Key? key,
    required TextEditingController Controller,
    required this.hinttext,
    this.obscureText = false,
  })  : _Controller = Controller,
        super(key: key);

  final TextEditingController _Controller;
  final String hinttext;
  final bool obscureText;

  @override
  _textfieldState createState() => _textfieldState();
}

class _textfieldState extends State<textfield> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onLongPress: () {
                setState(() {
                  _obscureText = true;
                });
              },
              onTap: () {
                setState(() {
                  _obscureText = false;
                });
              },
              child: TextField(
                obscureText: _obscureText && widget.obscureText,
                decoration: InputDecoration(
                  hintText: widget.hinttext,
                  hintStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w100,
                    color: Colors.grey,
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
                controller: widget._Controller,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
