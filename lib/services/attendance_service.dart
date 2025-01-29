import 'package:attendance_app/ui/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//entry point for submitting the attendance report
final CollectionReference dataCollection = FirebaseFirestore.instance.collection('attendance');

Future<void> submitAttendanceReport(
  BuildContext context, 
  String address, 
  String name, 
  String attendanceStatus, 
  String timeStamp
) async {
  showLoaderDialog(context);
  dataCollection.add(
    {
      'address': address,
      'name': name,
      'description' : attendanceStatus,
      'time' : timeStamp
    }
  ).then((result) {
    Navigator.of(context).pop();
    try { //ketika data udah benar
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text(
              "Attendance sumitted successfuly",
             style: TextStyle(color: Colors.white,),
            )
          ],
        ),
        backgroundColor: Colors.orangeAccent,
        shape: StadiumBorder(),
        behavior: SnackBarBehavior.floating,
      ));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()) 
      );
    }
    // e = error, i = information
    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.info_outline,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                "Ups, $e", //ini manggil eror
                style: TextStyle(color: Colors.white),
              )
            )
          ],
        ),
        backgroundColor: Colors.blueAccent,
        shape: StadiumBorder(),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }).catchError((error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.white,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "Ups, $error", 
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      backgroundColor: Colors.blueAccent,
      shape: StadiumBorder(),
      behavior: SnackBarBehavior.floating,
    ));
    Navigator.of(context).pop();
  });

}

void showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent), //always itu pokoknya animasi loading yg common lah
        ),
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Text("Loading..."),
        )
      ],
    )
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    } ,
  );
}