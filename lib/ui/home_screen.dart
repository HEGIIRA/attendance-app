import 'package:attendance_app/ui/attend/attendance_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope( //kyk buat make sure, mau back atau engga, tkut ada data yg ga kesimpen
      canPop: false,
      // ignore: deprecated_member_use
      onPopInvoked: (didPop) { //notif yg bakakal muncul klo mau exit
        if (didPop) {
          return;
        }
        _onWillPop;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea( //biar ga over lap biasanya buat app bar/bott app bar
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildMenuItem(  //ini nyimpen paramet nya ga hrus berurutan, yg bikin berurutan tuh klo
                  context, 
                  imagePath: '/assets/images/ic_attend.png',
                  label: 'Attendance Report',
                  destination: const AttendanceScreen()
                  
                ),
                const SizedBox(height: 40),
                _buildMenuItem(  //ini nyimpen paramet nya ga hrus berurutan, yg bikin berurutan tuh klo
                  context, 
                  imagePath: '/assets/images/ic_permission.png',
                  label: 'Permission Report',
                  destination: const AttendanceScreen()
                  
                ),
                const SizedBox(height: 40),
                _buildMenuItem(  //ini nyimpen paramet nya ga hrus berurutan, yg bikin berurutan tuh klo
                  context, 
                  imagePath: '/assets/images/ic_attendance_history.png',
                  label: 'Attendance History',
                  destination: const AttendanceScreen()
                  
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
     //ini parameter yg nampung apa aja yg bakal beda
    BuildContext context, { //contex juga masuknya parameter
      required String imagePath, //klo ini parameter yang wajib nanti dan bisa diubah (real data) (dalem kurwal)
      required String label,
      required Widget destination //tipe data nya widget karna si navigator itu termasuknya class
    }) {
    return Container(
                margin: const EdgeInsets.all(10),
                child: Expanded(
                  child: InkWell( //yg bisa di pencet
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => destination)); //jadi dipanggil nama parameter nya
                    },
                    child: Column(
                      children: [
                        Image(
                          image: AssetImage(imagePath),
                          height: 100,
                          width: 100,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          label,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    return (await showDialog(
      barrierDismissible: false, //klo ada popup kan, nah biasanya klo di tap di area diluar kotak popup nya, popupnya bakal ilang, ini di false karna biar dia ga ilang klo tap layar, dan bisa ilang klo udh klik pilihan
      context: context, 
      builder: (context) =>
      AlertDialog(
        title: const Text(
          "INFORMATION",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
        content: const Text(
          "Do you want to exit?",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(
              "No",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14
              ),
            )
          ),
          TextButton(
            onPressed: () => SystemNavigator.pop(), //ini buat klo di klik itu keluar dari apk nya lngsng, bukn dri tombol system spti home maupun back 
            child: const Text(
              "Yes",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14
              ),
            )
          )
        ],
      )
    )
    //ini adalah default value ketika semua kode yang ada di
    //blok alert dialog tidak tereksekusi karena beberapa hal
    )??
    false;
  }
}