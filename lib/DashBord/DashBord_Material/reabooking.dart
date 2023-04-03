import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Custom_Widget/textStyle.dart';

class ReabookingScreenView extends StatefulWidget {
  final String expertId;
  final String expertname;
  const ReabookingScreenView(
      {Key? key, required this.expertId, required this.expertname})
      : super(key: key);

  @override
  State<ReabookingScreenView> createState() => _ReabookingScreenViewState();
}

class _ReabookingScreenViewState extends State<ReabookingScreenView> {
  List<Map<String, dynamic>> items = [];
  String _userId = '';
  String _username = '';
  bool isLoading = true;
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

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        //'https://armaan.pythonanywhere.com/api/Rebooking${widget.expertId}'
        'https://armaan.pythonanywhere.com/api/Rebooking/?technician=11'));
    if (response.statusCode == 200) {
      final parsedResponse = json.decode(response.body);
      final List<Map<String, dynamic>> itemsList =
          List<Map<String, dynamic>>.from(parsedResponse);
      setState(() {
        items = itemsList
            .map<Map<String, dynamic>>((item) => item['booking_product'])
            .toList();

        // sort items by order id
        items.sort((a, b) => a['total_price'].compareTo(b['total_price']));
        items.sort((a, b) =>
            a['booking_product']?['total_price']
                ?.compareTo(b['booking_product']?['total_price'] ?? 0) ??
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff6956F0),
        elevation: 4,
        title: Text(
          "Rebooking ".toUpperCase(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
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
                      final orderID = booking['total_price'];
                      // final orderDate = DateFormat('dd/MM/yyyy')
                      //     .format(DateTime.parse(booking['booking_date']));

                      final orderState = booking['id'];
                      final orderCity = booking['city'];
                      final orderArea = booking['area'];
                      final orderZipcode = booking['zip_code'];
                      final orderAddress = booking['address'];
                      final orderDispriction = booking['description'];
                      final orderRealState = booking['quantity'];
                      final orderStatus = booking['total_price'];
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(

                                  //  border: Border.all(width: 1, color: Colors.grey),
                                  ),
                              child: Card(
                                child: ListTile(
                                  onTap: () {
                                    Map<String, dynamic> customer =
                                        items[index]['customer'];
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => NewOrderList(
                                    //         expertId: _userId,
                                    //         orderId: orderState,
                                    //         city: orderCity,
                                    //         area: orderArea,
                                    //         zipCode: orderZipcode,
                                    //         address: orderAddress,
                                    //         discription: orderDispriction,
                                    //         orederState: orderRealState,
                                    //         products: booking['products'],
                                    //         customerdetails: customer,
                                    //         expertname: _username),
                                    //   ),
                                    // );
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
                                    "ID $orderID".toUpperCase().toString(),
                                    style: customSmallTextStyle,
                                  ),
                                  trailing: Wrap(
                                    direction: Axis.vertical,
                                    children: [
                                      // Text(
                                      //   "$orderDate",
                                      //   style: customSmallTextStyle,
                                      // ),
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
                                            '$orderStatus'.toString(),
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
