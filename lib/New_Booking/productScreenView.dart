import 'dart:convert';
import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homofix/New_Booking/productDetailsScrren.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Custom_Widget/textStyle.dart';
import 'productDetailsScrren.dart';

class Booking {
  final int id;
  final String customerName;
  final String bookingDate;

  Booking(
      {required this.id,
      required this.customerName,
      required this.bookingDate});

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      customerName: json['customer_name'],
      bookingDate: json['booking_date'],
    );
  }
}

class ProductScreenView extends StatefulWidget {
  final String expertId;
  final String expertname;
  ProductScreenView(
      {Key? key, required this.expertId, required this.expertname})
      : super(key: key);

  @override
  State<ProductScreenView> createState() => _ProductScreenViewState();
}

class _ProductScreenViewState extends State<ProductScreenView> {
  List<Map<String, dynamic>> items = [];
  TextEditingController textController = TextEditingController();
  bool isLoading = true;
  String _userId = '';
  String _username = '';

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

  // List<Map<String, dynamic>> _taskDetails = [];
  // Future<List<Booking>> fetchBookingDetails() async {
  //   final response = await http.get(Uri.parse(
  //       'https://armaan.pythonanywhere.com/api/Task/?technician_id=40'));

  //   if (response.statusCode == 200) {
  //     final tasks = jsonDecode(response.body) as List<dynamic>;
  //     final bookings = <Booking>[];

  //     for (final task in tasks) {
  //       final bookingId = task['booking'] as int?;
  //       if (bookingId != null) {
  //         final bookingResponse = await http.get(Uri.parse(
  //             'https://armaan.pythonanywhere.com/api/Booking/$bookingId/'));
  //         if (bookingResponse.statusCode == 200) {
  //           final bookingJson =
  //               jsonDecode(bookingResponse.body) as Map<String, dynamic>;
  //           final booking = Booking.fromJson(bookingJson);
  //           bookings.add(booking);
  //         }
  //       }
  //     }

  //     return bookings;
  //   } else {
  //     throw Exception('Failed to fetch booking details');
  //   }
  // }

  // Future<List<dynamic>> fetchBookingDetails() async {
  //   final response = await http.get(Uri.parse(
  //       'https://armaan.pythonanywhere.com/api/Task/?technician_id=40'));

  //   if (response.statusCode == 200) {
  //     isLoading = false;
  //     print(response.body);
  //     return jsonDecode(response.body);
  //   } else {
  //     throw Exception('Failed to fetch booking details');
  //   }
  // }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://armaan.pythonanywhere.com/api/Task/?technician_id=${widget.expertId}'));
    if (response.statusCode == 200) {
      final parsedResponse = json.decode(response.body);
      final List<Map<String, dynamic>> itemsList =
          List<Map<String, dynamic>>.from(parsedResponse);
      setState(() {
        items = itemsList
            .map<Map<String, dynamic>>((item) => item['booking'])
            .where((booking) => booking['status'] != 'completed')
            .toList();

        // sort items by order id
        items.sort((a, b) => a['order_id'].compareTo(b['order_id']));
        items.sort((a, b) =>
            a['booking']?['order_id']
                ?.compareTo(b['booking']?['order_id'] ?? 0) ??
            0);
        isLoading = false;
      });
      print(parsedResponse);

      print(widget.expertId);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserId();
    fetchData();
    // fetchBookingDetails().then((bookingDetails) {
    //   setState(() {
    //     _bookingDetails = bookingDetails;
    //   });
    // });
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Assign':
        return Colors.orange;
      case 'in_progress':
        return Colors.yellow;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  int _selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 65),
          child: SafeArea(
              child: Container(
            decoration:
                const BoxDecoration(color: Color(0xff6956F0), boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  spreadRadius: 0,
                  offset: Offset(0, 5))
            ]),
            alignment: Alignment.center,
            child: AnimationSearchBar(
                searchIconColor: Colors.white,
                backIcon: FontAwesomeIcons.arrowLeft,
                backIconColor: Colors.white,
                centerTitle: 'Your Booking'.toUpperCase(),
                centerTitleStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 20),
                onChanged: (text) => debugPrint(text),
                cursorColor: Colors.black,
                searchTextEditingController: textController,
                searchFieldDecoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white, width: .5),
                    borderRadius: BorderRadius.circular(15)),
                horizontalPadding: 5),
          ))),
      body: SafeArea(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              )
            : items.isEmpty
                ? Center(
                    child: Text('No new booking'.toUpperCase()),
                  )
                : ListView.separated(
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox();
                    },
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      final booking = items[index];
                      final orderID = booking['order_id'];
                      final orderDate = DateFormat('dd/MM/yyyy')
                          .format(DateTime.parse(booking['booking_date']));

                      final orderState = booking['id'];
                      final orderCity = booking['city'];
                      final orderArea = booking['area'];
                      final orderZipcode = booking['zip_code'];
                      final orderAddress = booking['address'];
                      final orderDispriction = booking['description'];
                      final orderRealState = booking['state'];
                      final orderStatus = booking['status'];

                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(

                                  //  border: Border.all(width: 1, color: Colors.grey),
                                  ),
                              child: Card(
                                elevation: 0,
                                color: _selectedIndex == index
                                    ? Colors.yellow
                                    : null,
                                child: ListTile(
                                  onTap: () {
                                    Map<String, dynamic> customer =
                                        items[index]['customer'];
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NewOrderList(
                                            expertId: _userId,
                                            orderId: orderState,
                                            city: orderCity,
                                            area: orderArea,
                                            zipCode: orderZipcode,
                                            address: orderAddress,
                                            discription: orderDispriction,
                                            orederState: orderRealState,
                                            products: booking['products'],
                                            customerdetails: customer,
                                            expertname: _username),
                                      ),
                                    );
                                  },
                                  leading: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        // border:
                                        //     Border.all(width: 1, color: Colors.black),
                                        borderRadius: BorderRadius.circular(9),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.white54.withOpacity(0.5),
                                            spreadRadius: 1.5,
                                            blurRadius: 10,
                                            offset: Offset(
                                              1,
                                              1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      child: Image(
                                          image: AssetImage(
                                              "assets/download.jpg")),
                                    ),
                                  ),
                                  title: Text(
                                    '$orderRealState'.toString(),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff1b213c),
                                    ),
                                  ),
                                  subtitle: Text(
                                    '$orderID',
                                    style: customSmallTextStyle,
                                  ),
                                  trailing: Wrap(
                                    direction: Axis.vertical,
                                    children: [
                                      Text(
                                        "$orderDate".toString(),
                                        style: customSmallTextStyle,
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Icon(
                                              Icons.fiber_manual_record,
                                              size: 12,
                                              color:
                                                  _getStatusColor(orderStatus),
                                            ),
                                          ),
                                          Text(
                                            '$orderStatus',
                                            style: TextStyle(
                                              color:
                                                  _getStatusColor(orderStatus),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
