import 'dart:math';
import 'package:attendance_app/utils/google_ml_kit.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FaceDetectorComponent {
  final FaceDetector faceDetector = GoogleMlKit.vision.faceDetector(FaceDetectorOptions(
    enableContours: true,
    enableClassification: true,
    enableTracking: true,
    enableLandmarks: true
  ));

  Future<void> detectFaces(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final faces = await faceDetector.processImage(inputImage);

    for (Face face in faces) { //ini kan loop, klo face nya sudah terdeteksi
      //rect tuh rectangle (2d) biar ga di tipu pas mw daftar, kalo itu tuh beneran org(2d) bukan 1d (foto org/gambar), 
      final Rect boundingBox = face.boundingBox;  //boundingBox buat ngambil beberapa komponen dri wajah (positioning), kyk titik kordinat gitu (hidung, mulut, mata)
      //ini buat nge handle posisi wajah secara verti, biar nnti disuruh s=nengok kanan dikit, nengok kiri dikit
      final double? verticalPosition = face.headEulerAngleY;
      //buat handle secara z brarti nusuk (kedepan) tpi sebagai hori, kenapa gapake x? karna rancu, dia deketan sama y (tengah2 y and z)
      final double? horizontalPosition = face.headEulerAngleZ;

      //perkondisian klo face landmark udah aktif, ditandai oleh (mulut, mata, pipi, dan hidung, telinga), default dri ml kit, hrus bngt ada telinga, karna ml nya yg minta (klo pke hijab?)
      final FaceLandmark? leftEar = face.landmarks[FaceLandmarkType.leftEar]; //ini nullable, kupingnya bisa ada, bisa enggak, opsional boss
      if (leftEar != null) { //klo punya kuping, dia bakal mengembalikan letak posisi si kuping nya. ngerti ga? engga.
        final Point<int> leftEarPosition = leftEar.position; //image tuh int
        print("Left Ear Position: $leftEarPosition");
      } 

      //perkondisian klo wajahnya terdeteksi (ditandai dgn bibir senyum)
      if (face.smilingProbability != null) { //klo senyum, bakal nge print
        final double? smileProbability = face.smilingProbability;
        print("Smile Probability: $smileProbability");
      }

      //perkondisian klo fitur tracking wajahnya udah aktif
      if (face.trackingId != null) { //nandain klo mukanya dah aktif
        final int? trackingId = face.trackingId;
        print("Tracking ID: $trackingId");
      }
    }
  }
}