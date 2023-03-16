import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homofix/Custom_Widget/textStyle.dart';
import 'package:homofix/LoginPage/logInPageView.dart';

import '../../Custom_Widget/customTextFormField.dart';
import '../../Custom_Widget/custom_mediamButton.dart';
import '../../Custom_Widget/responsiveHeigh_Width.dart';

class SignupPageView extends StatefulWidget {
  const SignupPageView({Key? key}) : super(key: key);

  @override
  State<SignupPageView> createState() => _SignupPageViewState();
}

class _SignupPageViewState extends State<SignupPageView> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = SizedBox(
      height: 15,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("assets/undraw_sign__up_nm4k.png"),
                Text("Sign up", style: customTextStyle),
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
                          hintText: 'Email Id',
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
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.lock,
                      size: 18,
                      color: Color.fromARGB(255, 177, 175, 175),
                    ),
                    SizedBox(
                        width: getMediaQueryWidth(context: context, value: 13)),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: 'Full name',
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
                Row(
                  children: [
                    Icon(
                      Icons.call,
                      size: 20,
                      color: Color.fromARGB(255, 177, 175, 175),
                    ),
                    SizedBox(
                        width: getMediaQueryWidth(context: context, value: 13)),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'Mobile',
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
                SizedBox(
                  height: getMediaQueryHeight(context: context, value: 20),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'By signing up, you are To agree to our',
                        style: TextStyle(color: Color(0xFFADADAD)),
                      ),
                      TextSpan(
                        text: ' Terms & Conditions',
                        style: TextStyle(
                          color: Color(0xff1b213c),
                        ),
                      ),
                      TextSpan(
                        text: ' and',
                        style: TextStyle(color: Color(0xFFADADAD)),
                      ),
                      TextSpan(
                        text: ' Privacy Policy',
                        style: TextStyle(
                          color: Color(0xff1b213c),
                        ),
                      ),
                    ],
                  ),
                ),
                size,
                CustomContainerMediamButton(
                  buttonText: 'Continue',
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => SignupPageView()),
                    // );
                  },
                ),
                size,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Joined us before ?",
                      style: TextStyle(color: Color(0xFFADADAD)),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => LoginPageView()));
                      },
                      child: Text(
                        " Login",
                        style: customSmallTextStyle,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
