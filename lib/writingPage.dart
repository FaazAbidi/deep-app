import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class writingPage extends StatelessWidget {
  const writingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 40),
            child: TextField(
              expands: true,
              minLines: null,
              maxLines: null,
              cursorColor: Theme.of(context).accentColor,
              keyboardAppearance: Brightness.dark,
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: "MavenPro",
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).accentColor,
                  decoration: TextDecoration.none,
                  ),
              decoration: InputDecoration(
                  border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
