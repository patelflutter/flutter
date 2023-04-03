import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:homofix/main.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double _latitude = 0.0;
  double _longitude = 0.0;

  void getCurruntPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print("Permission not given");

      LocationPermission asked = await Geolocator.requestPermission();
    } else {
      Position curruntPossition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      setState(() {
        _latitude = curruntPossition.latitude;
        _longitude = curruntPossition.longitude;
      });
      print("Logitude:" + curruntPossition.longitude.toString());
      print("Latitude:" + curruntPossition.latitude.toString());
    }
  }

  void showNofication() async {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      "Notification-Homofix",
      "Homefix",
      priority: Priority.high,
      importance: Importance.defaultImportance,
    );
    DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    NotificationDetails notiDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    await Future.delayed(Duration(seconds: 10));
    await flutterLocalNotificationsPlugin.show(
        0, "Sample Notification", "This Is Notification", notiDetails,
        payload: "Ravi");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: InkWell(
                  onTap: showNofication,
                  child: Container(
                    height: 50,
                    // width: 200,
                    child: Center(child: Text("Notification")),
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: InkWell(
                  onTap: () {
                    getCurruntPosition();
                  },
                  child: Container(
                    height: 50,
                    // width: 200,
                    child: Center(child: Text("Location")),
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ),
            Text(
              "Latitude: $_latitude",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Longitude: $_longitude",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
