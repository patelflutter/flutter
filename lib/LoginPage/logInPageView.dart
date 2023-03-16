import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:homofix/Custom_Widget/textStyle.dart';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../DashBord/dashbord.dart';
import 'SignUpPage/signupPageView.dart';
import 'dart:async';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _showPassword = false;
  bool isLoading = false;

  int? state = 0;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController _email = TextEditingController();
    TextEditingController _paasword = TextEditingController();

    Future<void> _login(BuildContext context) async {
      setState(() {
        isLoading = true;
      });
      final url = Uri.parse('https://armaan.pythonanywhere.com/api/Login/');
      final body = {'username': _email.text, 'password': _paasword.text};

      final response = await http.post(url, body: body);

      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        final jsonResponse = json.decode(response.body);
        final id = jsonResponse['user']['id'];
        final email = jsonResponse['user']['email'].toString();

        final prefs = await SharedPreferences.getInstance();

        prefs.setString('id', id.toString());
        prefs.setString('email', email.toString());
        prefs.setString('username', _email.text);

        prefs.setString('password', _paasword.text);
        Fluttertoast.showToast(
            msg: "Login successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        print('Response body: ${response.body}');
        print('Email: $email');
        print('User ID: $id');
        print('Email ID: $email');
        print(prefs.getString('email'));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashBord()),
        );
      } else {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(
            msg: "Invalid Username or Password ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }

//  Future post() async {
//     print(_email.text);
//     setState(() {
//       state = 1;
//     });
//     final Map<String, dynamic> activityData = {
//       "id": id,
//       "first_name": _firstName.text,
//       "last_name": _lastName.text,
//       "username": _username.text,
//       "password": password,
//       "email": _email.text,
//       "rank": rank,
//       "user_type": usertype,
//       "user_id": widget.userID
//     };
//     print(activityData);
//     try {
//       Dio dio = Dio();
//       print(id);
//       await http.put(
//         Uri.http("ssrnoida12.herokuapp.com", "/api/User/${id}/"),
//         body: jsonEncode(activityData),
//         headers: {
//           "content-type": "application/json",
//         },
//       );

//       print("Done");
//       setState(() {
//         state = 2;
//       });
//     } catch (e) {
//       print(e);
//     }
//   }
    Future<Map<String, dynamic>> getLoggedInUserData() async {
      // Get the stored token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await http.get(
        Uri.parse('https://armaan.pythonanywhere.com/api/Expert/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token',
        },
      );

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        return userData;
      } else {
        throw Exception('Failed to get logged-in user data');
      }
    }

    return Scaffold(
      body: Form(
        key: formKey,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.topRight,
                    child: Image.asset("assets/blob.png")),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 180, left: 30),
                        child:
                            // Text('Login',
                            //     style: TextStyle(
                            //         fontSize: 40,
                            //         fontWeight: FontWeight.bold,
                            //         color: Colors.black87)),
                            GradientText("Login",
                                gradient: LinearGradient(colors: [
                                  Color(4283794685),
                                  Color(4283794685)
                                ]),
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87))),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 8.0, left: 30, right: 30),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Username',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Color(4288914861), fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Material(
                            borderRadius: BorderRadius.circular(10.0),
                            elevation: 2,
                            color: Colors.white,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6.0,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter userId';
                                    }
                                    return null;
                                  },
                                  controller: _email,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 14.0),
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: Color(4288914861),
                                    ),
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'Password',
                                style: TextStyle(
                                    color: Color(4288914861), fontSize: 18),
                              )),
                          SizedBox(
                            height: 5,
                          ),
                          Material(
                            elevation: 3,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter password';
                                  }
                                  return null;
                                },
                                obscureText: !_showPassword,
                                controller: _paasword,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    color: Colors.grey,
                                    onPressed: () {
                                      setState(() {
                                        _showPassword = !_showPassword;
                                      });
                                    },
                                    icon: Icon(
                                      _showPassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: Color(4288914861),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'New to Logistics?',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF646464)),
                              ),
                              TextButton(
                                child: Text(
                                  'Register',
                                  style: customSmallTextStyle,
                                  //   textAlign: TextAlign.right,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignupPageView()),
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // Align(
                          //   alignment: Alignment.centerRight,
                          //   child: GestureDetector(
                          //     onTap: () {
                          //       print("object");
                          //       singin();
                          //     },
                          //     child: CustomContainerSmallButton(
                          //         buttonText: "Log in",
                          //         onTap: () {
                          //           // if (formKey.currentState!.validate()) {
                          //           //   singin();

                          //           //   Navigator.push(
                          //           //       context,
                          //           //       MaterialPageRoute(
                          //           //           builder: (context) => DashBord(
                          //           //                 id: 23,
                          //           //                 userId: '',
                          //           //                 userType: '',
                          //           //               )));
                          //           // }
                          //         }),
                          //   ),
                          // ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  await _login(context);
                                }
                              },
                              child: Container(
                                height: 50,
                                width: 180,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: isLoading
                                      ? Center(
                                          child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ))
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Login ',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Icon(
                                              Icons.arrow_forward_rounded,
                                              color: Colors.white,
                                            )
                                          ],
                                        ),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    gradient: LinearGradient(colors: [
                                      Color(4283794685),
                                      Color(4283794685)
                                    ])),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget setUpButtonChild() {
    if (state == 0) {
      return Text(
        "Update Profile",
        // style: GoogleFonts.outfit(
        //     color: Color(0xffffffff),
        //     fontSize: 20,
        //     fontWeight: FontWeight.w500),
      );
    } else if (state == 1) {
      return CircularProgressIndicator(
        color: Colors.white,
      );
    } else {
      Timer(Duration(seconds: 2), () {
        setState(() {
          state = 0;
        });
      });
      return Text(
        "Updated",
        // style: GoogleFonts.outfit(
        //     color: Color(0xffffffff),
        //     fontSize: 20,
        //     fontWeight: FontWeight.w500),
      );
    }
  }
}

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
