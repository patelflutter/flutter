import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homofix/Custom_Widget/responsiveHeigh_Width.dart';
import 'package:homofix/Custom_Widget/textStyle.dart';
// ignore: unused_import
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'adomsScreen.dart';

class NewOrderList extends StatefulWidget {
  final String expertId;
  final String city;
  final String area;
  final int orderId;
  final String zipCode;
  final String address;
  final String discription;
  final String orederState;
  final String expertname;
  final Map<String, dynamic> customerdetails;
  final List<dynamic> products;
  const NewOrderList({
    Key? key,
    required this.address,
    required this.area,
    required this.orederState,
    required this.city,
    required this.discription,
    required this.zipCode,
    required this.expertId,
    required this.expertname,
    required this.orderId,
    required this.products,
    required this.customerdetails,
  }) : super(key: key);

  @override
  State<NewOrderList> createState() => _NewOrderListState();
}

class _NewOrderListState extends State<NewOrderList>
    with SingleTickerProviderStateMixin {
  bool _showDetails = false;
  void _toggleDetails() {
    setState(() {
      _showDetails = !_showDetails;
    });
  }

  List<dynamic> orders = [];

  Color _buttonColor = Color(0xFFF7E2C2); // Default color for button
  String _selectedStatus = 'Pending';
  String _selectedCard = 'add'; // Default value for status
  late TabController _tabController;
  String _userId = '';
  String _username = '';

  List<Map<String, dynamic>> items = [];
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (_selectedStatus) {
      case 'Active':
        _buttonColor = Color(0xFFF7E2C2);
        break;
      case 'Complete':
        _buttonColor = Color(0xFFCFEED0);
        break;
      case 'Pending':
      default:
        _buttonColor = Color(0xFFFAF1A3);
    }
    double totalPrice = 0.0;

    for (var product in widget.products) {
      totalPrice += product['price'];
    }

    List<String> selectedChips = [];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Order".toUpperCase(),
          style: TextStyle(color: Colors.white),
        ),
        elevation: 4,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Color(0xff6956F0),
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.idCard),
            onPressed: () {},
          ),
          SizedBox(
            width: getMediaQueryWidth(context: context, value: 20),
          ),
          IconButton(
            icon: Icon(
              Icons.search,
              size: 30,
            ),
            onPressed: () {},
          ),
          SizedBox(
            width: getMediaQueryWidth(context: context, value: 10),
          ),
        ],
        bottom: TabBar(
          labelColor: Colors.white,
          controller: _tabController,
          tabs: [
            Tab(
              text: 'Your Order'.toUpperCase(),
            ),
            Tab(text: 'Your Customer'.toUpperCase()),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: getMediaQueryHeight(context: context, value: 10),
                ),

                // Text(widget.orderId.toString()),
                // Expanded(
                //   child:
                // ),
                SizedBox(
                  height: getMediaQueryHeight(context: context, value: 10),
                ),
                Card(
                  elevation: 0,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFFF1F0FD),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "product address".toUpperCase(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff6956F0),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        // border:
                        //     Border.all(width: 0.5, color: Color(0xFFD6D4D4)),
                        ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // CircleAvatar(
                            //   child: Text(widget.orederState.substring(0, 1)),
                            //   backgroundColor: Colors.red,
                            // ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.orederState,
                                    style: customTextStyle,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    widget.area + ', ' + widget.city,
                                    style: customSmallTextStyle,
                                  ),
                                  SizedBox(height: 4),
                                  Text(widget.address),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Zip Code".toUpperCase(),
                                  style: customSmallTextStyle,
                                ),
                                SizedBox(height: 4),
                                Text(widget.zipCode,
                                    style: customSmallTextStyle),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height:
                              getMediaQueryHeight(context: context, value: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                Card(
                  elevation: 0,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFFF1F0FD),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Product Status".toUpperCase(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff6956F0),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    height: getMediaQueryHeight(context: context, value: 40),
                    decoration: BoxDecoration(
                      color: _buttonColor,
                      // border: Border.all(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(
                          4), // adjust the radius as desired
                    ),
                    width: double.infinity, // set width to fill the container
                    child: Center(
                      child: SizedBox(
                        width: double
                            .infinity, // set width to fill the parent container
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: DropdownButton<String>(
                            icon: Icon(FontAwesomeIcons.angleDown,
                                color: Colors.black),
                            iconSize: 18,
                            iconEnabledColor: Colors.black,
                            isDense: true,
                            isExpanded: true,
                            value: _selectedStatus,
                            underline: Text(""),
                            items: <String>['Active', 'Complete', 'Pending']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  // style: TextStyle(
                                  //     fontWeight: FontWeight.bold,
                                  //     color: Colors.black,
                                  //     fontSize: 10),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedStatus = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                // Container(
                //   padding: EdgeInsets.all(8.0),
                //   decoration: BoxDecoration(
                //     border: Border.all(
                //       color: Colors.grey,
                //       width: 1.0,
                //     ),
                //     borderRadius: BorderRadius.circular(8.0),
                //   ),
                //   child: Column(
                //     children: [
                //       DropdownButton<String>(
                //         icon: Icon(FontAwesomeIcons.angleDown,
                //             color: Colors.black),
                //         iconSize: 18,
                //         iconEnabledColor: Colors.black,
                //         isDense: true,
                //         isExpanded: true,
                //         value: _selectedCard,
                //         underline: Text(""),
                //         items:
                //             <String>['add', 'plus', 'div'].map((String value) {
                //           return DropdownMenuItem<String>(
                //             value: value,
                //             child: Text(value),
                //           );
                //         }).toList(),
                //         onChanged: (String? myValue) {
                //           setState(() {
                //             _selectedCard = myValue!;
                //             selectedChips.add(myValue);
                //           });
                //         },
                //       ),
                //       Container(
                //         margin: EdgeInsets.symmetric(vertical: 8.0),
                //         child: Row(
                //           children: selectedChips
                //               .map(
                //                 (e) => Chip(
                //                   avatar: CircleAvatar(
                //                     backgroundColor: Colors.grey.shade800,
                //                     child: Text(
                //                       'City Initial',
                //                       style: TextStyle(color: Colors.black),
                //                     ),
                //                   ),
                //                   label: Text(
                //                     e,
                //                     style: TextStyle(color: Colors.black),
                //                   ),
                //                   backgroundColor: Colors.grey,
                //                   onDeleted: () {
                //                     setState(() {
                //                       selectedChips.remove(e);
                //                     });
                //                   },
                //                 ),
                //               )
                //               .toList(),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                Card(
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFFF1F0FD),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Product List".toUpperCase(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff6956F0),
                        ),
                      ),
                    ),
                  ),
                ),
                ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: widget.products.length,
                  itemBuilder: (context, index) {
                    final product = widget.products[index];
                    final productName = product['name'];
                    final productTitle = product['product_title'];
                    final productPrice = product['price'];

                    final productDiscription = product['description'];
                    final productImage = product['product_pic'];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 0,
                        //  margin: EdgeInsets.zero,
                        child: Container(
                            child: Column(
                          children: [
                            SizedBox(
                              height: getMediaQueryHeight(
                                  context: context, value: 10),
                            ),
                            ListTile(
                              leading: productImage != null
                                  ? Image(
                                      image: NetworkImage('$productImage'),
                                      height: 80,
                                      width: 60,
                                    )
                                  : Image.asset(
                                      'assets/undraw_two_factor_authentication_namy.png', // replace with your default image path
                                      height: 80,
                                      width: 60,
                                    ),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "$productName",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff1b213c),
                                    ),
                                  ),
                                  Text(
                                    NumberFormat.currency(
                                      locale: 'en_IN',
                                      symbol: '₹',
                                      decimalDigits: 0,
                                    ).format(
                                      productPrice,
                                    ),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff6956F0),
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "$productTitle",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff1b213c),
                                    ),
                                  ),
                                  // Html(data: "$productDiscription"),

                                  Text("$productDiscription"),
                                  SizedBox(
                                    height: getMediaQueryHeight(
                                        context: context, value: 10),
                                  ),
                                ],
                              ),
                            )

                            //Text("$productDiscription")
                          ],
                        )),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: getMediaQueryHeight(context: context, value: 10),
                    );
                  },
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: getMediaQueryHeight(context: context, value: 10),
                ),
                Card(
                  elevation: 0,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFFF1F0FD),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Customer Details".toUpperCase(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff6956F0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: getMediaQueryHeight(context: context, value: 10),
                ),
                ListTile(
                  title: Text("Customer id "),
                  trailing:
                      Text(' ${widget.customerdetails['id']}'.toUpperCase()),
                ),
                ListTile(
                  title: Text("Customer Name "),
                  trailing: Text(
                      ' ${widget.customerdetails['admin']['username']}'
                          .toUpperCase()),
                ),
                ListTile(
                  title: Text("Customer Mobile "),
                  trailing: Text(
                      ' ${widget.customerdetails['mobile']}'.toUpperCase()),
                ),
                ListTile(
                  title: Text("Customer State "),
                  trailing:
                      Text(' ${widget.customerdetails['state']}'.toUpperCase()),
                ),
                ListTile(
                  title: Text("Customer Address "),
                  trailing: Container(
                    width: 200.0, // set a fixed width of 200 pixels
                    child: Text(
                      ' ${widget.customerdetails['address']}'.toUpperCase(),
                      overflow: TextOverflow
                          .ellipsis, // add this line to add ellipsis (...) if the text overflows
                    ),
                  ),
                ),
                SizedBox(
                  height: getMediaQueryHeight(context: context, value: 10),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                height: getMediaQueryHeight(context: context, value: 45),
                color: Color.fromARGB(255, 236, 235, 235),
                child: Center(
                  child: Text(
                    NumberFormat.currency(
                      locale: 'en_IN',
                      symbol: '₹',
                      decimalDigits: 2,
                    ).format(totalPrice),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff6956F0),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdomsItemScreen()));
                },
                child: Container(
                  height: getMediaQueryHeight(context: context, value: 45),
                  color: Color(0xff6956F0),
                  child: Center(
                      child: Text(
                    "Submit",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildListItem(String title, String trailing) {
  return ListTile(
    dense: true,
    title: Text(title.toUpperCase(),
        style: TextStyle(fontWeight: FontWeight.bold)),
    trailing: Text(trailing),
  );
}
