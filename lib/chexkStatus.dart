import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProtectedPage extends StatelessWidget {
  const ProtectedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Call checkPageAccess when you navigate to a protected page
    //  checkPageAccess();

    return Scaffold(
      appBar: AppBar(
        title: Text('Protected Page'),
      ),
      body: Center(
        child: Text('This page is protected'),
      ),
    );
  }
}

Future<bool> isLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  final username = prefs.getString('username');
  return username != null && username.isNotEmpty;
}

void checkLoginStatus(context) async {
  if (!await isLoggedIn()) {
    // Navigate to login page and clear shared preferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => LoginPage()),
    // );
  }
}

// void checkPageAccess(context) async {
//   if (!await isLoggedIn()) {
//     // Navigate to login page and clear shared preferences
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.clear();
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => LoginPage()),
//     );
//   }
  // Continue with the protected page logic