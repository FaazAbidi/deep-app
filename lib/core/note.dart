import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Note {
   String noteText;
   String dateTimeText;
   int ID;

   Note({@required this.noteText}) {
     assignID();
     assignDateTime();
   }

   getByID(String id) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     noteText = prefs.getString(id);
     dateTimeText = prefs.getString(id+"datetime");
     return this;
   }

   void assignDateTime() async {
     DateTime now = DateTime.now();
     String formattedDate = DateFormat('hh:mm a EEE d MMM yy').format(now);
     SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setString(ID.toString()+"datetime", formattedDate);
   }

   void assignID () async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     var random = new Random();
     while (true) {
       ID = random.nextInt(10000);
       if (!prefs.getKeys().contains(ID)) {
         prefs.setString(ID.toString(), noteText);
         break;
       }
     }

   }


   void removeSharedPreference () async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.remove(ID.toString());
   }

   getDateTime() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     dateTimeText = prefs.getString(ID.toString()+"datetime");
     return dateTimeText;
   }

   getNoteText() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     noteText = prefs.getString(ID.toString());
     return noteText;
   }

   getID() {
     return ID;
   }

   static Future<Map<String,String>> getAll() async {
     print("inside");
     Map <String, String> all = {};
     SharedPreferences prefs = await SharedPreferences.getInstance();
     Set keys = prefs.getKeys();
      print(keys);
     keys.forEach((element) async {
       all[element] = prefs.getString(element);
     });

     return all;
   }

}