import 'package:intl/intl.dart';


//INI NGAMBIL DATA SECARA REAL TIME DRI LIBRARY
void setDateTime(Function(String, String, String) onDateTimeSet) {
  var dateNow = DateTime.now();
  var dateFormat = DateFormat('dd mm yyyy');
  var dateTime = DateFormat('hh:mm:ss');

  String date = dateFormat.format(dateNow);
  String time = dateTime.format(dateNow);
  String currentDate = '$date | $time';

  onDateTimeSet(date, time, currentDate);
}

void setAttendanceStatus(Function(String) onStatusSet) {
  var dateNow = DateTime.now();
  var hour = int.parse(DateFormat("hh").format(dateNow)); //int.parse ngubah int jadi string
  var minute = int.parse(DateFormat("mm").format(dateNow));

  String attendanceStatus;
  if (hour <= 7 || (hour == 7 && minute == 00)) {
    attendanceStatus = "Attend";
  } else if (hour > 7 || (hour == 7 && minute >= 01)) {
    attendanceStatus = "Late";
  } else {
    attendanceStatus = "Absent";
  }
  onStatusSet(attendanceStatus);
}