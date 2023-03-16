import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homofix/Custom_Widget/responsiveHeigh_Width.dart';
import 'package:homofix/Custom_Widget/textStyle.dart';
import 'package:homofix/User_Profile/user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Custom_Widget/cardContainer.dart';
import '../Custom_Widget/customdashBordcard.dart';
import '../LoginPage/logInPageView.dart';
import 'DashBord_Material/New_order_list/bookingHistroy.dart';
import 'DashBord_Material/New_order_list/neworderView.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:http/http.dart' as http;
import 'DataList/userdata.dart';
import 'das.dart';

class DashBord extends StatefulWidget {
  DashBord({
    Key? key,
  }) : super(key: key);

  @override
  State<DashBord> createState() => _DashBordState();
}

class _DashBordState extends State<DashBord> {
  late MyData _myData;

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  bool positive = false;
  bool loading = false;

  String _userId = '';
  String _username = '';
  String name = '';
  String imageUrl = '';
  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('https://armaan.pythonanywhere.com/api/Expert/1'));
    if (response.statusCode == 200) {
      final parsedResponse = json.decode(response.body);
      setState(() {
        name = parsedResponse['mobile'];
        imageUrl = parsedResponse['profile_pic'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Future<void> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('id') ?? '';
    final username = prefs.getString('username') ?? '';
    setState(() {
      _userId = userId;
      _username = username;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserId();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: SafeArea(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Color(0xff7d68f1)),
                  accountName: Text(
                    _username.toUpperCase(),
                    style: TextStyle(fontSize: 18),
                  ),
                  accountEmail: Text("abhishekm977@gmail.com"),
                  currentAccountPicture: imageUrl.isEmpty
                      ? CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ))
                      : CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(imageUrl),
                          ),
                        )),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Color(0xff1b213c),
                ),
                title: Text('Home',
                    style: TextStyle(
                        color: Color(0xff1b213c), fontWeight: FontWeight.bold)),
                onTap: () {
                  // Navigate to home screen
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Color(0xff1b213c),
                ),
                title: Text('Home',
                    style: TextStyle(
                        color: Color(0xff1b213c), fontWeight: FontWeight.bold)),
                onTap: () {
                  // Navigate to home screen
                },
              ),
              // Text('Mobile: ${_myData.mobile}'),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                title: Text(
                  'Logout',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  _logout();
                },
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => [
            SliverAppBar(
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(40),
                child: Column(children: [
                  Container(
                    decoration: BoxDecoration(
                      //  backgroundBlendMode: BlendMode.lighten,
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    height: getMediaQueryHeight(context: context, value: 35),
                    width: double.infinity,
                  ),
                ]),
              ),
              expandedHeight: 300.0,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xff6a52ee), // Start color
                    Color(0xFF66b52ef), // End color
                  ],
                )),
                child: FlexibleSpaceBar(
                  background: Column(
                    children: [
                      SizedBox(
                        height:
                            getMediaQueryHeight(context: context, value: 85),
                      ),
                      ClipRRect(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xff6a52ee), // Start color
                                Color(0xFF66b52ef), // End color
                              ],
                            ),
                          ),
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: MyCustomCard(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Text(
                                                  "10%",
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xfff9ecff)),
                                                ),
                                                Text(
                                                  "Discount",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xfff9ecff)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: MyCustomCard(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "10%",
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xfff9ecff)),
                                                ),
                                                Text(
                                                  "Discount",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xfff9ecff)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: MyCustomCard(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Text(
                                                  "10%",
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xfff9ecff)),
                                                ),
                                                Text(
                                                  "Discount",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xfff9ecff)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              //  circleTopRight(),
                              circleBottomLeft(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              pinned: true,

              // snap: true,
              elevation: 0,
              //  backgroundColor:LinearGradient
              //  Color(0xFF66b52ef),
              automaticallyImplyLeading: false,
              primary: true,
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserPeofileVew(
                                expertId: _userId, expertname: _username)));
                  },
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: imageUrl.isEmpty
                            ? CircleAvatar(
                                child: Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.black),
                                ),
                              )
                            : CircleAvatar(
                                radius: 22,
                                backgroundImage: NetworkImage(imageUrl),
                              ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 5,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 12,
                          child: Icon(
                            FontAwesomeIcons.user,
                            size: 15,
                            color: Color(0xff1b213c),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset('assets/homofixlogo.jpg'),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 28,
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.bars,
                          size: 18,
                          color: Color(0xff1b213c),
                        ),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
          body: SafeArea(
            child: SingleChildScrollView(
              //   physics: NeverScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    SizedBox(
                      height: getMediaQueryHeight(context: context, value: 15),
                    ),
                    // Text(
                    //   'Logged in as user ID: $_userId!',
                    //   style: TextStyle(fontSize: 24.0),
                    // ),
                    // $_username!

                    Text(
                      "Working Mode",
                      style: customTextStyle,
                    ),
                    SizedBox(
                      height: getMediaQueryHeight(context: context, value: 15),
                    ),
                    AnimatedToggleSwitch<bool>.dual(
                      indicatorColor: Colors.white,
                      current: positive,
                      loading: false,
                      first: false,
                      second: true,
                      dif: 30.0,
                      borderColor: Colors.transparent,
                      borderWidth: 5.0,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 1.5),
                        ),
                      ],
                      onChanged: (b) {
                        setState(() => positive = b);
                        return Future.delayed(Duration(seconds: 1));
                      },
                      colorBuilder: (b) => b ? Colors.green : Colors.red,
                      iconBuilder: (value) => value
                          ? Icon(
                              Icons.work,
                              color: Colors.white,
                            )
                          : Icon(
                              FontAwesomeIcons.stopwatch,
                              color: Colors.white,
                            ),
                      textBuilder: (value) => value
                          ? Center(child: Text('ON'))
                          : Center(child: Text('OFF')),
                    ),
                    SizedBox(
                      height: getMediaQueryHeight(context: context, value: 15),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomWidget(
                            text: 'Register',
                            imagePath: 'assets/recent.png',
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => UserPeofileVew(
                              //               expertId: 42,
                              //             )));
                            },
                          ),
                        ),
                        Expanded(
                          child: CustomWidget(
                            text: 'Booking History',
                            imagePath: 'assets/booking (1).png',
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BookingHistory()));
                            },
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomWidget(
                            text: 'New Booking',
                            imagePath: 'assets/order.png',
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewOrderList()));
                            },
                          ),
                        ),
                        Expanded(
                          child: CustomWidget(
                            text: 'Payment Method',
                            imagePath: 'assets/credit-card.png',
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ExpertDataWidget(
                                            expertId: _userId,
                                          )));
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget circleTopRight() {
  return Positioned(
    right: -100,
    top: -80,
    child: Container(
      width: 265,
      height: 265,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment(-0.8, -0.7),
          end: Alignment.bottomCenter,
          colors: [
            Color(0xffe6edf7),
            Color(0xffe6edf7),
          ],
        ),
      ),
    ),
  );
}

Widget circleBottomLeft() {
  return Positioned(
    left: -20,
    bottom: -140,
    child: Container(
      width: 280,
      height: 280,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment(0.9, -0.2),
          colors: [
            Color(0x00FFFFFF),
            Color(0x4DFFFFFF),
          ],
        ),
      ),
    ),
  );
}
