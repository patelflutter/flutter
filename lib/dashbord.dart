import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homofix/Custom_Widget/responsiveHeigh_Width.dart';
import 'package:homofix/Custom_Widget/textStyle.dart';
import 'package:homofix/User_Profile/user_profile.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Custom_Widget/cardContainer.dart';
import 'Custom_Widget/customdashBordcard.dart';
import 'LoginPage/logInPageView.dart';
import 'New_Booking/CompleteBooking.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:http/http.dart' as http;
import 'New_Booking/productScreenView.dart';
import 'RebookingPageScreen/rebooking.dart';
import 'Wallet/walletScreenView.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' as math;

class DashBord extends StatefulWidget {
  // final int id;
  DashBord({
    Key? key,
  }) : super(key: key);

  @override
  State<DashBord> createState() => _DashBordState();
}

class _DashBordState extends State<DashBord> {
  Map<String, dynamic> expertData = {};
  bool isRotated = false;
  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  List<Map<String, dynamic>> items = [];

  bool positive = false;
  bool loading = false;
  var isDeviceConnected = false;
  bool isAlertSet = false;
  late StreamSubscription subscription;
  String _userId = '';
  String _username = '';
  String name = '';
  String expertGmail = '';
  String imageUrl = '';
  int? bookingComplete;
  int? newBookingCount;
  int? rebookingCount;
  Timer? timer;
  bool isButtonClicked = false;

  // int completedBookingsCount = 0;
  Future<void> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('id') ?? '';
    final username = prefs.getString('username') ?? '';

    setState(() {
      _userId = userId;
      _username = username;
      print("check :${_userId}");
    });
  }

  Future<void> fetchDatas() async {
    final response = await http.get(
        Uri.parse('https://support.homofixcompany.com/api/Expert/$_userId/'));
    if (response.statusCode == 200) {
      final parsedResponse = json.decode(response.body);
      final admin = parsedResponse['admin'];
      final fullName = admin != null ? admin['first_name'].toString() : "";
      final email = admin != null ? admin['email'].toString() : "";

      setState(() {
        name = fullName;
        expertGmail = email;
        imageUrl = parsedResponse['profile_pic'].toString();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> fetchDataCount() async {
    final prefs = await SharedPreferences.getInstance();
    final idS = prefs.getString('id');
    final response = await http.get(Uri.parse(
        'https://support.homofixcompany.com/api/Task/Counting/Get/?technician_id=$idS'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      bookingComplete = jsonData['Booking_Completed'];
      newBookingCount = jsonData['new_booking_count'];
      rebookingCount = jsonData['rebooking_count'];

      // Do something with the retrieved data
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://support.homofixcompany.com/api/Task/?technician=$_userId'));
    if (response.statusCode == 200) {
      print(response.statusCode);
      final parsedResponse = json.decode(response.body);
      final List<Map<String, dynamic>> itemsList =
          List<Map<String, dynamic>>.from(parsedResponse);
      setState(() {
        items = itemsList
            .map<Map<String, dynamic>>((item) => item['booking'])
            .where((booking) =>
                booking['status'] != 'Completed' && booking['id'] == '$_userId')
            .toList();

        // sort items by order id
        items.sort((a, b) => a['order_id'].compareTo(b['order_id']));
        items.sort((a, b) =>
            a['booking']?['order_id']
                ?.compareTo(b['booking']?['order_id'] ?? 0) ??
            0);
        //      completedBookingsCount = itemsList.where((item) =>
        // item['booking'] != null &&
        // item['booking']['status'] == 'Completed').length;
      });

      //  count bookings with status 'completed'

    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    getConnectivity();
    super.initState();

    fetchDataCount();

    _getUserId().then((value) => fetchDatas());
    fetchData();

    SharedPreferences.getInstance().then((prefs) {
      bool savedPositive = prefs.getBool('positive') ?? false;
      setState(() => positive = savedPositive);
    });
  }

  getConnectivity() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      if (!isDeviceConnected && isAlertSet == false) {
        showDialogBox(context);
        setState(() {
          isAlertSet = true;
        });
      }
    });
  }

  Future<void> getCurruntPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print("Permission not given");
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
      String locationaddress =
          '${placemark.name}, ${placemark.street}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.postalCode}, ${placemark.country}';

      Map<String, dynamic> data = {
        "technician_id": _userId,
        "location": locationaddress,
      };
      String jsonData = jsonEncode(data);
      print(jsonData);

      final response = await http.put(
        Uri.parse(
            'https://support.homofixcompany.com/api/ExpertAllLocation/$_userId/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonData,
      );

      if (response.statusCode == 200) {
        print("Data added successfully");
      } else if (response.statusCode == 201) {
        print("Data added successfully");
      } else {
        print("Failed to add data");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Exit App'),
              content: Text('Do you want to exit an App?'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  //return false when click on "NO"
                  child: Text('No'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Yes'),
                ),
              ],
            ),
          ) ??
          false;
    }

    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: SafeArea(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: Color(0xff002790)),
                    accountName: Text(
                      name.toUpperCase(),
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    accountEmail: Text(
                      expertGmail.toString(),
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    currentAccountPicture: imageUrl.isEmpty
                        ? CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(FontAwesomeIcons.user))
                        : CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(imageUrl),
                            ),
                          )),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(0xFFE6E3F7),
                    child: Icon(Icons.person, color: Color(0xff002790)),
                  ),
                  title: Text('Profile ',
                      style: TextStyle(
                          color: Color(0xff1b213c),
                          fontWeight: FontWeight.bold)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserPeofileVew(
                              expertId: _userId, expertname: _username)),
                    );
                  },
                  trailing: CircleAvatar(
                    radius: 12,
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                    ),
                    backgroundColor: Color(0xFFE6E3F7),
                  ),
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(0xFFE6E3F7),
                    child: Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                  ),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    _logout();
                  },
                  trailing: CircleAvatar(
                    radius: 12,
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                    ),
                    backgroundColor: Color(0xFFE6E3F7),
                  ),
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
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/WhatsApp Image 2023-04-15 at 10.50.08 AM.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    child: FlexibleSpaceBar(
                      background: Column(
                        children: [
                          SizedBox(
                            height: getMediaQueryHeight(
                                context: context, value: 85),
                          ),
                          ClipRRect(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: MyCustomCard(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  if (newBookingCount != null)
                                                    Text(
                                                      "$newBookingCount"
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black
                                                          // color: Color(
                                                          //     0xfff9ecff
                                                          //     )
                                                          ),
                                                    ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "New",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black
                                                            // color:
                                                            //     Color(0xfff9ecff),
                                                            ),
                                                      ),
                                                      Text(
                                                        "Booking",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black
                                                            // color:
                                                            //     Color(0xfff9ecff),
                                                            ),
                                                      ),
                                                    ],
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
                                                  if (rebookingCount != null)
                                                    Text(
                                                      "$rebookingCount",
                                                      style: TextStyle(
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black
                                                          // color:
                                                          //     Color(0xfff9ecff),
                                                          ),
                                                    ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "New",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black
                                                            // color:
                                                            //     Color(0xfff9ecff),
                                                            ),
                                                      ),
                                                      Text(
                                                        "Rebooking",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black
                                                            // color:
                                                            //     Color(0xfff9ecff),
                                                            ),
                                                      ),
                                                    ],
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
                                                  if (bookingComplete != null)
                                                    Text(
                                                      "$bookingComplete",
                                                      style: TextStyle(
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black
                                                          // color:
                                                          //     Color(0xfff9ecff),
                                                          ),
                                                    ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "Complete",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black
                                                            // color:
                                                            //     Color(0xfff9ecff),
                                                            ),
                                                      ),
                                                      Text(
                                                        "Booking",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black
                                                            // color:
                                                            //     Color(0xfff9ecff),
                                                            ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            fetchDataCount();

                                            isRotated =
                                                !isRotated; // Toggle the rotation state
                                          });
                                        },
                                        icon: AnimatedBuilder(
                                          animation: AlwaysStoppedAnimation<
                                                  double>(
                                              isRotated
                                                  ? 0.25
                                                  : 0), // Define the rotation animation
                                          builder: (BuildContext context,
                                              Widget? child) {
                                            return Transform.rotate(
                                              angle: isRotated
                                                  ? math.pi * 2 * 0.25
                                                  : 0, // Rotate the icon by 90 degrees (quarter-turn)
                                              child: Icon(FontAwesomeIcons
                                                  .arrowsRotate),
                                            );
                                          },
                                        ),
                                        color: Colors.white,
                                        iconSize: 22,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 22,
                              backgroundColor: Colors.grey[300],
                              backgroundImage: imageUrl.isNotEmpty
                                  ? NetworkImage(imageUrl)
                                      as ImageProvider<Object>?
                                  : AssetImage('assets/logolight.png'),
                            ),
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
                    child: SizedBox(
                      //  width: getMediaQueryWidth(context: context, value: 70),
                      child:
                          Image.asset('assets/logolight.png', fit: BoxFit.fill),
                    ),
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
                        height:
                            getMediaQueryHeight(context: context, value: 15),
                      ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     setState(() {
                      //       isButtonClicked = true; // Update the state variable
                      //     });
                      //   },
                      //   child: Text('Update UI'),
                      // ),
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
                        height:
                            getMediaQueryHeight(context: context, value: 15),
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
                        onChanged: (b) async {
                          setState(() => positive = b);
                          final apiUrl =
                              'https://support.homofixcompany.com/api/OnlineOffline/$_userId/';
                          final response = await http.put(
                            Uri.parse(apiUrl),
                            body: {
                              'online': b.toString(),
                              'technician_id': '$_userId',
                            },
                          );
                          if (response.statusCode == 200) {
                            final responseBody = json.decode(response.body);
                            final data = responseBody['data'];
                            final online = data['online'] as bool;
                            setState(() => positive = online);
                            //   getCurruntPosition();
                            Fluttertoast.showToast(
                                msg:
                                    'You are now ${online ? 'online' : 'offline'}');
                            print('Online status updated');
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.setBool('positive', positive);
                          } else {
                            print('Failed to update online status');
                          }
                          // return Future.delayed(Duration(seconds: 25));
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
                        height:
                            getMediaQueryHeight(context: context, value: 15),
                      ),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: CustomWidget(
                      //         text: 'Register',
                      //         imagePath: 'assets/recent.png',
                      //         onTap: () {
                      //           // Navigator.push(
                      //           //     context,
                      //           //     MaterialPageRoute(
                      //           //         builder: (context) => MyOrderDetals()));
                      //         },
                      //       ),
                      //     ),
                      //     Expanded(
                      //       child: CustomWidget(
                      //         text: 'Booking History',
                      //         imagePath: 'assets/booking (1).png',
                      //         onTap: () {
                      //           Navigator.push(
                      //               context,
                      //               MaterialPageRoute(
                      //                   builder: (context) => BookingHistory()));
                      //         },
                      //       ),
                      //     )
                      //   ],
                      // ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomWidget(
                              text: 'New Booking',
                              imagePath: 'assets/order.png',
                              onTap: () {
                                if (!positive) {
                                  Fluttertoast.showToast(
                                    msg:
                                        'You are currently working mode off. Please go working mode of to access this feature.',
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductScreenView(
                                        expertId: _userId,
                                        expertname: _username,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          Expanded(
                            child: CustomWidget(
                              text: 'Wallet',
                              imagePath: 'assets/credit-card.png',
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WalletScreen(
                                              expertId: _userId,
                                            )));
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height:
                            getMediaQueryHeight(context: context, value: 15),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomWidget(
                              text: 'Rebooking List',
                              imagePath: 'assets/recent.png',
                              onTap: () {
                                if (!positive) {
                                  Fluttertoast.showToast(
                                    msg:
                                        'You are currently working mode off. Please go working mode of to access this feature.',
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RebookingListView(
                                        expertId: _userId,
                                        expertname: _username,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          Expanded(
                            child: CustomWidget(
                              text: 'Booking Complete',
                              imagePath: 'assets/booking (1).png',
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CompleteBookingView(
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
      ),
    );
  }

  showDialogBox(context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("No Connection"),
          content: const Text("Please check your internet connectivity"),
          actions: [
            CupertinoDialogAction(
              child: const Text("OK"),
              onPressed: () async {
                Navigator.pop(context, 'cancel');
                setState(() => isAlertSet = false);

                isAlertSet = false;
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected) {
                  showDialogBox(context);
                  setState(() {
                    isAlertSet = true;
                  });
                }
              },
            ),
          ],
        );
      },
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
