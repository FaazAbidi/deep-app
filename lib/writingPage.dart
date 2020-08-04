import 'dart:ui';
import 'package:deep/savedWorkPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class writingPage extends StatelessWidget {
  const writingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String note = "";
    List<String> notesKeys = [];

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: WillPopScope(
          onWillPop: () async {
            SharedPreferences saving = await SharedPreferences.getInstance();
            DateTime now = DateTime.now();
            String formattedDate = DateFormat('kk:mm:ss EEE d MMM').format(now);

            if (note != ""){
              print(note);
              saving.setString(formattedDate, note);
              notesKeys.add(formattedDate);
            }
            return true;
          },
                  child: Column(
            children: <Widget>[
              Container(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 40),
                  child: TextField(
                    // expands: true,
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
                    onChanged: (text) {
                      note = text;
                    },
                  ),
                ),
              
              ),
            ],
          ),
        ),
      ),
    );
  }
}
