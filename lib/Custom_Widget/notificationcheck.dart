import 'package:flutter/material.dart';

class NotificationCheck extends StatefulWidget {
  final String? payload;
  const NotificationCheck({Key? key, this.payload}) : super(key: key);

  @override
  State<NotificationCheck> createState() => _NotificationCheckState();
}

class _NotificationCheckState extends State<NotificationCheck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(widget.payload ?? ''), Text("Payload")],
      ),
    );
  }
}
