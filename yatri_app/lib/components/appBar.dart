import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

AppBar ApppBar(var onPressed) {
  return AppBar(
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
        onPressed: onPressed,
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
  );
}
