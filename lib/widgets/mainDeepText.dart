import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget mainDeepText (context) {
  double screenHeight = MediaQuery.of(context).size.height;
  double screenWidth = MediaQuery.of(context).size.width;

  return Center(
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.1),
      child: Text(
        "deep",
        style: TextStyle(
          fontSize: (screenWidth + screenHeight) * 0.020,
          color: Theme.of(context).accentColor,
        ),
      ),
    ),
  );
}