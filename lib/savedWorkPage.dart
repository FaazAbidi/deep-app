import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';


class savedNotes extends StatefulWidget {
  savedNotes({Key key}) : super(key: key);

  @override
  _savedNotesState createState() => _savedNotesState();
}

class _savedNotesState extends State<savedNotes> {

  String data = "empty";
  static DateTime now = DateTime.now();
  static String formattedDate = DateFormat('kk:mm:ss EEE d MMM').format(now);
  String notePreview = "";

  @override
  void initState() { 
    super.initState();
    setData();
  }

  static Future<String> getSavedNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('saved_note');
    return name;
  }

  setData() {
    getSavedNotes().then((value) {
      setState((){
        print(formattedDate);
        if (value != null){
          data = value;
          notePreview = value.length > 10 ? value.substring(0,10) : value + " ...";
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(children: <Widget>[
          Text(notePreview+" "+formattedDate)
        ],),
      ));
  }
}