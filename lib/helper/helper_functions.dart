import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// display error to user
void displayMessageToUser(String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(title: Text(message)),
  );
}

// format data from timestamp
String formatData(Timestamp timestamp) {
  // timestamp is the object we retrieve from firebase
  // so to display it, lets convert it to a string
  DateTime dateTime = timestamp.toDate();

  // get year
  String year = dateTime.year.toString();

  // get month
  String month = dateTime.month.toString();

  // get day
  String day = dateTime.day.toString();

  // final formatted date
  String formattedData = '$month/$day/$year';

  return formattedData;
}
