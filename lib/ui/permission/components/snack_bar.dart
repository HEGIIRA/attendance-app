import 'package:flutter/material.dart';

class SnackBarComponent {
  //static model -> buat mempertahankan value dri pada function yg dipanggil, kan klo dynamic berubah2 ya, nah ini kebalikannya
  static void showSnackBar(BuildContext context, String message, {bool isError = false}) { //buildcontext tuh class nya
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Icon(
            isError ? Icons.error : Icons.check_circle_outline,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      backgroundColor: isError ? Colors.red : Colors.blue,
      shape: const StadiumBorder(),
      behavior: SnackBarBehavior.floating,
    ));
  }
}