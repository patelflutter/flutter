import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginPage/logInPageView.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geocoding/geocoding.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  final idS = prefs.getString('id');
  // print("Ids $idS");
  AndroidInitializationSettings androidSetting =
      AndroidInitializationSettings("@mipmap/ic_launcher");
  DarwinInitializationSettings iosSetting = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestCriticalPermission: true,
      requestSoundPermission: true);

  InitializationSettings initializationSettings = InitializationSettings(
    android: androidSetting,
    iOS: iosSetting,
  );
  bool? initialized =
      await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  log("Nofification: $initialized");
  runApp(MyApp());
}

Future<void> onSelectNotification(String? payload) async {
  if (payload != null) {
    debugPrint('notification payload: $payload');
  }
}

class MyApp extends StatefulWidget {
  // final bool isLoggedIn;
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  void getCurruntPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      //    print("Permission not given");
      LocationPermission asked = await Geolocator.requestPermission();
    } else {
      Position curruntPossition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      setState(() {});

      List<Placemark> placemarks = await placemarkFromCoordinates(
        curruntPossition.latitude,
        curruntPossition.longitude,
      );
      Placemark placemark = placemarks.first;
      String address =
          '${placemark.name}, ${placemark.street}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.postalCode}, ${placemark.country}';
      print(address);
    }
  }

  int previousBookingId = 0;

  void checkForNewBooking() async {
    final prefs = await SharedPreferences.getInstance();
    final idS = prefs.getString('id');

    final response = await http.get(Uri.parse(
        'https://support.homofixcompany.com/api/Task/?technician_id=$idS'));

    if (response.statusCode == 200) {
      final bookings = jsonDecode(response.body) as List<dynamic>;
      final latestBooking = bookings.last;

      if (latestBooking['id'] != previousBookingId) {
        showNofication();

        previousBookingId = latestBooking['id'];
      }
    } else {
      throw Exception('Failed to load API');
    }
  }

  void showNofication() async {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      "Homofix Company",
      "You have new task assign",
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
    await flutterLocalNotificationsPlugin.show(
        0, "Homofix", "You have new task assign", notiDetails,
        payload: "Homofix");
  }

  @override
  void initState() {
    super.initState();

    //   WidgetsBinding.instance.addObserver(this);
    getCurruntPosition();
    checkForNewBooking();
  }

  @override
  void dispose() {
    super.dispose();
    //   WidgetsBinding.instance.removeObserver(this);
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      checkForNewBooking();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            color: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.white)),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.black,
        ),
        brightness: Brightness.light,
        primarySwatch: const MaterialColor(
          0xffFFFFFF,
          {
            50: Color(0xffFFFFFF),
            100: Color(0xffFFFFFF),
            200: Color(0xffFFFFFF),
            300: Color(0xffFFFFFF),
            400: Color(0xffFFFFFF),
            500: Color(0xffFFFFFF),
            600: Color(0xffFFFFFF),
            700: Color(0xffFFFFFF),
            800: Color(0xffFFFFFF),
            900: Color(0xffFFFFFF),
          },
        ),
      ),
      home: Login(),
    );
  }
}
