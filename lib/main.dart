import 'package:deep/savedWorkPage.dart';
import 'package:deep/writingPage.dart';
import 'package:flutter/material.dart';
import 'package:deep/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(55, 55, 56, 1),
        accentColor: Color.fromRGBO(220, 220, 220, 1.0),
        fontFamily: "MavenPro",
        textTheme: TextTheme(
            bodyText1: TextStyle(fontSize: 50, fontFamily: "MavenPro")),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: <String, WidgetBuilder> {
      '/writingScreen' : (BuildContext context) => new writingPage(),
      '/savedNotesScreen' : (BuildContext context) => new savedNotes(),
    },
      home: HomePage(),
    );
  }
}


