import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';


Future<void> getGeoLocationPosition(BuildContext context, Function(Position) onPositionReceived) async {
  // ignore: deprecated_member_use
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
  onPositionReceived(position);
}

//CARA MEMANGGIL ALAMAT
Future<void> getAddressFromLongLat(Position position, Function(String) onAddressReceived) async {
  //lat = vertikal, long = horizontal
  List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);
  Placemark place = placemark[0];
  String address = "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
  onAddressReceived(address);
}

Future<bool> handleLocationPermission(BuildContext context) async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) { //ini kebalikan, brarti klo service GAK enable
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.location_off,
            color: Colors.white
          ),
          SizedBox(width: 10),
          Text(
            "Location Service are Disabled, Please enable the services",
            style: TextStyle(color: Colors.white),
          )
        ]
      ),
      backgroundColor: Colors.blueGrey,
      shape: StadiumBorder(),
      behavior: SnackBarBehavior.floating,
    ));
    return false; //biar app nya ga munculin apa apa, karna user blm ngasih permission
  }
  //ini udh checking,
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.location_off,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text(
              "Location permission are Denied",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
        backgroundColor: Colors.blueGrey,
        shape: StadiumBorder(),
        behavior: SnackBarBehavior.floating,
      ));
      return false; //ini juga sama, buat nge blok is user biar gabisa pake apk nya, karna dia nge denied si location nya
    }
  }

  //ini jarang bgt dipake, biasanya yg pake/ ke triger buat denied forever tuh karna dev yg maksa masuk lewat belakan
  if (permission == LocationPermission.deniedForever) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.location_off,
            color: Colors.white,
          ),
          SizedBox(width: 10),
          Text(
            "Location permission denied forever, we cannot access",
            style: TextStyle(color: Colors.white)
          )
        ],
      ),
      backgroundColor: Colors.blueGrey,
      shape: StadiumBorder(),
      behavior: SnackBarBehavior.floating,
    ));
    return false; //untuk memblokr user
  }
  //INI NIH ELSE NYA
  return true; //user ini brarti bisa lanjutin aktifitas nya, karna udah ngijinin apk buat nyalain location
}