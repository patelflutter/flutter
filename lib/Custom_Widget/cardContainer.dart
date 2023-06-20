import 'package:flutter/material.dart';
import 'package:homofix/Custom_Widget/responsiveHeigh_Width.dart';

class MyCustomCard extends StatelessWidget {
  final Widget child;

  MyCustomCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      //  height: getMediaQueryHeight(context: context, value: 80),
      margin: EdgeInsets.all(16),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        //  color: Color(0xff7d68f1),
        color: Colors.white,
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.white.withOpacity(0.5),
        //     spreadRadius: 2,
        //     blurRadius: 1,
        //     offset: Offset(0, 1),
        //   ),
        // ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: child,
      ),
    );
  }
}
