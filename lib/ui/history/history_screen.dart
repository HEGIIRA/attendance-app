import 'package:attendance_app/services/data_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class _AttendanceHistoryScreenState extends StatefulWidget {
  const _AttendanceHistoryScreenState({super.key});

  @override
  State<_AttendanceHistoryScreenState> createState() => __AttendanceHistoryScreenStateState();
}

class __AttendanceHistoryScreenStateState extends State<_AttendanceHistoryScreenState> {
  //ini manggil si data service nya itu buat disini (UI)
  final DataService dataService = DataService(); 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendance History"),
      ),
      body: StreamBuilder( //untuk membungkus widget kita jdi satu kesatuan, widgetnya jadi ter manage well
        stream: dataService.dataCollection.snapshots(), //snapshots ngasih tau/manage/handle data kita yang kita ambil dari dataCollection, ngasih tau UI klo data nya udh siap dipake, 
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) { //klo snapshot kita gapunya data
            return const Center(
              child: Text("There is no data"), //bakal munculin ini
            );
          }

          final data = snapshot.data!.docs; //ini kalo ada data nya

          return ListView.builder(
            itemCount: data.length, //jumlah data yg kita punya/di firebase
            itemBuilder: (context, index) {
              //put attendance card UI here
            },
          );
        }
      ),
    );
  }
}