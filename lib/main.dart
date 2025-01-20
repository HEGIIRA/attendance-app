import 'package:attendance_app/ui/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// MAIN DART ISINYA UNTUK ATUR TEMA, FONT, DAN LAIN-LAIN

Future<void> main() async { //yg di compile ini dlu.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( //klo mw pke firebase,initializeapp dulu buat pke layanann firbase yg lain, langkah pertama setelah atur pubspec
    options: const FirebaseOptions(
      //data diambil dari file google-services.json
      apiKey: 'AIzaSyCsItJtZWhEsREskCkJrddFS6ftdLIm00I', //ambil dri current_key || ini sifatnya rahasia, nnti ini bisa ter enskripsi(bintang2 atau pagar2 kyk pw).
      appId: '1:474983179997:android:4407bdb2a0420c61e99d34', //ambil dri mobilesdk-app_id
      messagingSenderId: '474983179997', //ambil dri project_number
      projectId: 'attendance-app-686b2' //ambil dri project_id
    )
  );
  runApp(const AttendanceApp());
}

class AttendanceApp extends StatelessWidget {
  const AttendanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        cardTheme: const CardTheme(surfaceTintColor: Colors.white),
        dialogTheme: const DialogTheme(surfaceTintColor: Colors.white, backgroundColor: Colors.white),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true
      ),
      home: const HomeScreen(),
    );
  }
}