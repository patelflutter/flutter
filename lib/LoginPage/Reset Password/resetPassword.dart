import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Custom_Widget/custom_mediamButton.dart';
import '../../Custom_Widget/responsiveHeigh_Width.dart';
import '../../Custom_Widget/textStyle.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    var size = SizedBox(
      height: 15,
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/undraw_two_factor_authentication_namy.png"),
            Text("Reset Password", style: customTextStyle),
            size,
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.lock,
                  size: 18,
                  color: Color(0xFFB1AFAF),
                ),
                SizedBox(
                    width: getMediaQueryWidth(context: context, value: 13)),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      suffixIcon: Icon(
                        Icons.remove_red_eye_outlined,
                        size: 22,
                      ),
                      hintText: 'New password',
                      hintStyle: TextStyle(color: Color(0xFFC5C5C5)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFC5C5C5), width: 0.5),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFC5C5C5), width: 0.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.lock,
                  size: 18,
                  color: Color(0xFFB1AFAF),
                ),
                SizedBox(
                    width: getMediaQueryWidth(context: context, value: 13)),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      suffixIcon: Icon(
                        Icons.remove_red_eye_outlined,
                        size: 22,
                      ),
                      hintText: 'Confirm new password',
                      hintStyle: TextStyle(color: Color(0xFFC5C5C5)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFC5C5C5), width: 0.5),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFC5C5C5), width: 0.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            size,
            size,
            GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => SignupPageView()),
                // );
              },
              child: CustomContainerMediamButton(
                buttonText: 'Save',
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => SignupPageView()),
                  // );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
