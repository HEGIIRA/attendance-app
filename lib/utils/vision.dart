//class yg sering dipakai klo mw implementasi fitur, 
//khusus nya gugel ml kit, buat fitur kyk deteksi wajah gitu, pindai kode, dll
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class Vision { 
  Vision._(); //ini private constructor, yg gabisa di inisialisasi dri luar

  static final Vision instance = Vision._(); //ini kode safety

  FaceDetector faceDetector([FaceDetectorOptions? option]) {
    return FaceDetector(options: option ?? FaceDetectorOptions()); //satu step klo mw pke face setector dri gugel ml kit
  }
}