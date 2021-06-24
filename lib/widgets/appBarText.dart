import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget appBarText (context, String text, {double colorOpacity=1}) {
  double screenHeight = MediaQuery.of(context).size.height;
  double screenWidth = MediaQuery.of(context).size.width;

  return Text(
    text,
    textAlign: TextAlign.left,
    style: TextStyle(
        color: Theme.of(context).accentColor.withOpacity(colorOpacity), fontSize: screenWidth * 0.08),
  );
}