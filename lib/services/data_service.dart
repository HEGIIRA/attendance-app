import 'package:cloud_firestore/cloud_firestore.dart';
//kita ambil data dri firebase, nah data apa? data pas tadi attendance dan permission, hbis di upload ke firebase, di ambil lah data nya disini, dan ditampilin

//INTINYA INI BUAT GET DATA DRI INTERNET

class DataService {
  final CollectionReference dataCollection = FirebaseFirestore.instance.collection('attendance'); //klo mw ambil dri firebase

  Future<QuerySnapshot> getData() {
    return dataCollection.get();
  }

  Future<void> deleteData(String docId) {
    return dataCollection.doc(docId).delete(); //kegunaan atribut .doc tuh method buat nge get id dri di data itu, tau ah
  }
}