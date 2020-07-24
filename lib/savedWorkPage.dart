import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class writingPage extends StatelessWidget {
  const writingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
