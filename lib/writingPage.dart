import 'dart:ui';
import 'package:deep/pageTransitions.dart';

import 'core/note.dart';
import 'savedWorkPage.dart';
import 'widgets/appBarText.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class writingPage extends StatefulWidget {
  String note;
  bool isEditing;
  String noteKey;

  writingPage({Key key, this.note, this.isEditing, this.noteKey}) : super(key: key);

  @override
  _writingPageState createState() => _writingPageState(note, isEditing, noteKey);
}

class _writingPageState extends State<writingPage> {
  String note;
  bool isEditing;
  String noteKey;
  _writingPageState(this.note, this.isEditing, this.noteKey);
  Color writingColor = Color.fromRGBO(235, 237, 235, 1);
  double appBarTextOpacity = 1.0;
  List<String> notesKeys = [];
  FocusNode _focus = new FocusNode();
  TextEditingController _textEditingController;
  bool focus = false;
  String originalNote;

  changeColor() {
    setState(() {
      writingColor = Color.fromRGBO(235, 237, 235, 0.5);
    });
  }

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
    if (isEditing) originalNote = note.substring(0);  // creating original copy if it's editing mode
  }

  void _onFocusChange() {
    changeColor();
    appBarTextOpacity = 0.6;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    if (note != "") {
      _textEditingController = new TextEditingController(text: note);
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: WillPopScope(
          onWillPop: () async {

            if (note != "" && isEditing == false) {
              Note noteObject = Note(noteText: note);
            }

            else if (isEditing) {
              if (note != originalNote && note != "") {
                Note newNote = Note(noteText: note);
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove(noteKey);
                prefs.remove(noteKey+"datetime");
              }
            }

            if (isEditing) {
              Navigator.of(context).pushReplacementNamed("/savedNotesScreen");
            }
            else {
            Navigator.of(context).pop();
            }

            return;
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.02, left: 0),
                child: Row(
                  children: <Widget>[
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () async {
                        HapticFeedback.selectionClick();
                        FocusScope.of(context).requestFocus(FocusNode());
                        sleep(const Duration(milliseconds: 200));
                        if (note != "" && isEditing == false) {
                          Note noteObject = Note(noteText: note);
                        }
                        else if (isEditing) {
                          if (note != originalNote && note != "") {
                            Note newNote = Note(noteText: note);
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.remove(noteKey);
                            prefs.remove(noteKey+"datetime");
                          }
                        }
                        
                        if (isEditing) {
                          Navigator.of(context).popAndPushNamed("/savedNotesScreen");
                        }
                        else {
                          Navigator.of(context).pop();
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, right: 12),
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: screenWidth * 0.06,
                          color: writingColor,
                        ),
                      ),
                    ),
                    InkWell(
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        onTap: () {
                          _focus.unfocus();
                          setState(() {
                            writingColor = Color.fromRGBO(235, 237, 235, 1);
                            appBarTextOpacity = 1.0;
                          });
                        },
                        child: appBarText(context, "Notepad",
                            colorOpacity: appBarTextOpacity))
                  ],
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: ScrollConfiguration(
                    behavior: MyBehavior(context),
                    child: TextField(
                      controller: _textEditingController,
                      expands: true,
                      autofocus: false,
                      focusNode: _focus,
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
                        hintText: "start writing...",
                        hintStyle: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 0.4),
                            fontWeight: FontWeight.normal,
                            fontSize: 18),
                        border: InputBorder.none,
                      ),
                      onChanged: (text) {
                        note = text;
                      },
                    ),
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
