import 'dart:math';
import 'package:flutter/material.dart';

import 'package:homofix/Custom_Widget/responsiveHeigh_Width.dart';

class OtpPageView extends StatefulWidget {
  const OtpPageView({
    Key? key,
  }) : super(key: key);

  @override
  State<OtpPageView> createState() => _OtpPageViewState();
}

class _OtpPageViewState extends State<OtpPageView> {
  String otp = '';
  void generateOTP() {
    var rng = Random();
    otp = rng.nextInt(1000000).toString().padLeft(6, '0');
    print('Dummy OTP: $otp');
  }

  List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  List<TextEditingController> _textControllers =
      List.generate(4, (index) => TextEditingController());
  String _expectedOTP = '1234';
  Color _defaultBorderColor = Colors.grey;
  @override
  void initState() {
    super.initState();
    generateOTP();
    print(otp);
  }

  @override
  TextEditingController _otpController = TextEditingController();
  @override
  void dispose() {
    for (var i = 0; i < 4; i++) {
      _textControllers[i].dispose();
      _focusNodes[i].dispose();
    }
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 3,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text(
              "",
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              width: getMediaQueryWidth(context: context, value: 5),
            ),
            Text(
              "mobile verification".toUpperCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: getMediaQueryHeight(context: context, value: 35),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Waiting for OTP to Verify Your Mobile No.',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // SizedBox(
                //   width: getMediaQueryHeight(context: context, value: 5),
                // ),
                Text(
                  "9472064003",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
            SizedBox(height: getMediaQueryHeight(context: context, value: 25)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildOTPTextField(0),
                buildOTPTextField(1),
                buildOTPTextField(2),
                buildOTPTextField(3),
              ],
            ),
            SizedBox(height: getMediaQueryHeight(context: context, value: 25)),
            ElevatedButton(
              onPressed: () {
                // Validate the entered OTP
                String enteredOTP = '';
                for (var i = 0; i < 4; i++) {
                  enteredOTP += _textControllers[i].text;
                }
                if (enteredOTP == _expectedOTP) {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => MainScreenView(),
                  //   ),
                  // );
                } else {
                  // OTP didn't match, show an error message
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Error'),
                      content: Text('Invalid OTP'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text('Verify OTP'),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {},
              child: Column(
                children: [
                  Text(
                    'The OTP is Valid For 30 Minutes',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Didnot Receive Your OTP?',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Resent Code',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                            decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOTPTextField(int index) {
    return SizedBox(
      width: getMediaQueryWidth(context: context, value: 60),
      height: getMediaQueryHeight(context: context, value: 60),
      child: TextFormField(
        cursorColor: Colors.redAccent,
        autofocus: true,
        controller: _textControllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        decoration: const InputDecoration(
            counter: Offstage(),
            hintText: '-',
            hintStyle: TextStyle(color: Colors.grey),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent),
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.redAccent))),
        onTap: () {
          setState(() {
            // Change the border color of the tapped field
            // _defaultBorderColor = Colors.blue;
          });
        },
        onChanged: (value) {
          setState(() {
            // Reset the border color of the field when a value is entered
            //  _defaultBorderColor = Colors.grey;
          });
          if (value.isNotEmpty) {
            if (index < 3) {
              _focusNodes[index + 1].requestFocus();
            } else {
              _focusNodes[index].unfocus();
            }
          } else {
            if (index > 0) {
              _focusNodes[index - 1].requestFocus();
            }
          }
        },
      ),
    );
  }
}
