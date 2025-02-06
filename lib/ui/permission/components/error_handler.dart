import 'package:attendance_app/ui/permission/components/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

//perkondisian terait snakbar
class ErrorHandler {
  static void handleError(BuildContext context, dynamic error) {
    if (error is PermissionDeniedException) {
      SnackBarComponent.showSnackBar(
        context, 
        "Permission Denied",
        isError: true //ngasih tau kalau ini error permission
      );
    } else {
      SnackBarComponent.showSnackBar(
        context,
        error, //ini bakal napilin error sesuai error nya, bukan yg permission,
        isError: true,
      );
    }
    Navigator.of(context).pop();
  }
}

class PermissionDeniedException implements Exception {
  final String message;
  //proses pembuatan placeholder dri sebuah exception/error
  PermissionDeniedException({this.message = ''});

  @override
  String toString() => message.isEmpty ? "Permission Denied" : message; //ini inline/anonymus ife condition
}