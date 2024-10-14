import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:workmanager/workmanager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const checkInOutTask = "checkInOutTask";

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case checkInOutTask:
        // Perform your location and check-in/check-out logic
        await checkAutoCheckInOut();
        break;
    }
    return Future.value(true);
  });
}

Future<void> checkAutoCheckInOut() async {
  User? user = FirebaseAuth.instance.currentUser;

  // Check if the user is logged in
  if (user != null) {
    const double officeLatitude = 26.7802159; // Office Latitude
    const double officeLongitude = 75.8211531; // Office Longitude
    const double radius = 4.0; // Office Radius in meters

    // Fetch the current location
    Position position;
    try {
      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      print('Error fetching position: $e');
      return;
    }

    double distance = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      officeLatitude,
      officeLongitude,
    );

    // Query Firestore for incomplete check-ins
    List<QueryDocumentSnapshot> attendanceRecords;
    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.email)
          .collection('attendance')
          .where('checkOutTime', isNull: true)
          .orderBy('checkInTime', descending: true)
          .limit(1)
          .get();
      attendanceRecords = querySnapshot.docs;
    } catch (e) {
      print('Error fetching Firestore data: $e');
      return;
    }

    if (attendanceRecords.isEmpty && distance <= radius) {
      // Perform check-in
      await performCheckIn(user, position);
    } else if (attendanceRecords.isNotEmpty && distance > radius) {
      // Perform check-out
      var checkInRecord = attendanceRecords.first;
      await performCheckOut(user, checkInRecord, position);
    }
  }
}

Future<void> performCheckIn(User user, Position position) async {
  DateTime checkInTime = DateTime.now();
  String docId = DateFormat('yyyy-MM-dd_HH:mm:ss').format(checkInTime);

  await FirebaseFirestore.instance
      .collection('users')
      .doc(user.email)
      .collection('attendance')
      .doc(docId)
      .set({
    'checkInLocation': GeoPoint(position.latitude, position.longitude),
    'checkInTime': checkInTime,
  });
}

Future<void> performCheckOut(
    User user, QueryDocumentSnapshot checkInRecord, Position position) async {
  DateTime checkOutTime = DateTime.now();
  DateTime checkInTime = checkInRecord['checkInTime'].toDate();
  Duration workingDuration = checkOutTime.difference(checkInTime);
  String formattedDuration = _formatDuration(workingDuration);

  String docId = checkInRecord.id;

  await FirebaseFirestore.instance
      .collection('users')
      .doc(user.email)
      .collection('attendance')
      .doc(docId)
      .update({
    'checkOutLocation': GeoPoint(position.latitude, position.longitude),
    'checkOutTime': checkOutTime,
    'totalWorkingHours': formattedDuration,
  });
}

String _formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String hours = twoDigits(duration.inHours);
  String minutes = twoDigits(duration.inMinutes.remainder(60));
  String seconds = twoDigits(duration.inSeconds.remainder(60));
  return "$hours:$minutes:$seconds";
}
