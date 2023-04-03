import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homofix/LoginPage/Otp/otpView.dart';

import '../../Custom_Widget/custom_mediamButton.dart';
import '../../Custom_Widget/responsiveHeigh_Width.dart';
import '../../Custom_Widget/textStyle.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({Key? key}) : super(key: key);

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("assets/undraw_Access_account_re_8spm (1).png"),
                Text(
                  "Forgot Password?",
                  style: customTextStyle,
                ),
                size,
                Text(
                    "Don't worry! it happens. Please enter the address associated with your account"),
                size,
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.at,
                      size: 18,
                      color: Color.fromARGB(255, 177, 175, 175),
                    ),
                    SizedBox(
                        width: getMediaQueryWidth(context: context, value: 13)),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'Email ID / Mobile number',
                          hintStyle: TextStyle(color: Color(0xFFC5C5C5)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFC5C5C5), width: 0.5),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFC5C5C5), width: 0.5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                size,
                GestureDetector(
                  // onTap: () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => OtpView()),
                  //   );
                  // },
                  child: CustomContainerMediamButton(
                    buttonText: 'Submit',
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
