import 'dart:ui';
import 'package:deep/main.dart';
import 'package:deep/pageTransitions.dart';
import 'package:deep/savedWorkPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class writingPage extends StatefulWidget {
  const writingPage({Key key}) : super(key: key);

  @override
  _writingPageState createState() => _writingPageState();
}

class _writingPageState extends State<writingPage> {
  Color writingColor = Color.fromRGBO(235, 237, 235, 1);
  String note = "";
  List<String> notesKeys = [];
  FocusNode _focus = new FocusNode();

  changeColor() {
    setState(() {
      writingColor = Color.fromRGBO(235, 237, 235, 0.5);
    });
  }

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    changeColor();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: WillPopScope(
          onWillPop: () async {
            SharedPreferences saving = await SharedPreferences.getInstance();
            DateTime now = DateTime.now();
            String formattedDate =
                DateFormat('hh:mm a EEE d MMM yy').format(now);

            if (note != "") {
              saving.setString(formattedDate, note);
              notesKeys.add(formattedDate);
            }
            return true;
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: <Widget>[
                    RawMaterialButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: EdgeInsets.only(top: 5),
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onPressed: () async {
                        HapticFeedback.selectionClick();
                        await FocusScope.of(context).requestFocus(FocusNode());
                        await sleep(const Duration(milliseconds: 200));
                        SharedPreferences saving = await SharedPreferences.getInstance();
                        DateTime now = DateTime.now();
                        String formattedDate =
                            DateFormat('hh:mm a EEE d MMM yy').format(now);

                        if (note != "") {
                          saving.setString(formattedDate, note);
                          notesKeys.add(formattedDate);
                        }

                        Navigator.of(context).pop(FadeRoute(page: MyApp()));
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 22,
                        color: writingColor,
                      ),
                    ),
                    Text(
                      "Notepad",
                      style: TextStyle(color: writingColor, fontSize: 28),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: TextField(
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
                        hintText: ". . . .",
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
