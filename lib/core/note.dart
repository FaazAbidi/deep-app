import 'dart:math';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Note {
   String noteText;
   String dateTimeText;
   int ID;

   Note({this.noteText}) {
     assignID();
     assignDateTime();
   }

   assignDateTime() async {
     DateTime now = DateTime.now();
     String formattedDate = DateFormat('hh:mm a EEE d MMM yy').format(now);
     SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setString(ID.toString()+"datetime", formattedDate);
   }

   assignID () async {
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


   removeSharedPreference () {
     return;
   }

   getDateTime() {
     return dateTimeText;
   }

   getNoteText() {
     return noteText;
   }

   getID() {
     return ID;
   }
}