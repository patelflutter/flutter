import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../../Custom_Widget/responsiveHeigh_Width.dart';
import '../../../Custom_Widget/textStyle.dart';
import 'package:http/http.dart' as http;

class OrderDetailsView extends StatefulWidget {
  final String expertId;
  final String expertname;
  final int productId;
  //final Map<String, dynamic> orderDetails;
  final int orderPrice;
  final String Producttitele;
  final String productPic;
  final String productwarranty;
  final String productdescription;
  final String productdiscwarranty;
  final String productdate;
  final String productname;

  /// final Map<String, dynamic> productId;
  const OrderDetailsView(
      {Key? key,
      required this.expertId,
      required this.expertname,
      required this.productId,
      required this.productPic,
      required this.orderPrice,
      required this.Producttitele,
      required this.productdiscwarranty,
      required this.productdate,
      required this.productdescription,
      required this.productwarranty,
      required this.productname})
      : super(key: key);

  @override
  State<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  // Map<String, dynamic>? productDetails;
  // Future<void> fetchProductDetails() async {
  //   final response = await http.get(Uri.parse(
  //       //'https://armaan.pythonanywhere.com/api/Product/${widget.productId}/'
  //       'https://armaan.pythonanywhere.com/api/Task/?technician_id=1/${widget.productId}/'));
  //   if (response.statusCode == 200) {
  //     final parsedResponse = json.decode(response.body);
  //     setState(() {
  //       productDetails = parsedResponse;
  //     });
  //   } else {
  //     throw Exception('Failed to load product details');
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   fetchProductDetails();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf0f5fb),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Color(0xFFf0f5fb),
        title: Text(
          widget.productId.toString(),
          style: TextStyle(
            color: Color(0xff1b213c),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              FontAwesomeIcons.idCard,
              color: Color(0xff1b213c),
            ),
            onPressed: () {},
          ),
          SizedBox(
            width: getMediaQueryWidth(context: context, value: 20),
          ),
          IconButton(
            icon: Icon(
              Icons.search,
              size: 30,
              color: Color(0xff1b213c),
            ),
            onPressed: () {},
          ),
          SizedBox(
            width: getMediaQueryWidth(context: context, value: 10),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: getMediaQueryHeight(context: context, value: 50),
                color: Color(0xFFDBDBDD),
                child: Center(
                  child: Text(
                    widget.orderPrice.toString(),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  //  Text(
                  //   'Rs 500',
                  //   style: TextStyle(
                  //       color: Color(0xff1b213c),
                  //       fontSize: 24,
                  //       fontWeight: FontWeight.bold),
                  // ),
                ),
              ),
            ),
            Expanded(
                child: Container(
                    height: getMediaQueryHeight(context: context, value: 50),
                    color: Color(0xff1b213c),
                    child: Center(
                      child: Text(
                        "Update",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ))),
          ],
        ),
      ),
      body: SafeArea(
        //   child: ListView.builder(
        // itemCount: 4,
        // itemBuilder: (context, index) {
        // //  final product = products[index];

        //   return Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Text(
        //         product['product_title'].toString(),
        //         style: TextStyle(
        //           fontWeight: FontWeight.bold,
        //           fontSize: 18,
        //         ),
        //       ),
        //       SizedBox(height: 8),
        //       Text(
        //         'Price: ${product['price']}',
        //       ),
        //       SizedBox(height: 8),
        //       Text(
        //         'Warranty: ${product['warranty']}',
        //       ),
        //       SizedBox(height: 8),
        //       Text(
        //         'Description: ${product['description']}',
        //       ),
        //       SizedBox(height: 16),
        //     ],
        //   );
        // },
        //    );
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Column(
            children: [
              Card(
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.Producttitele,
                            style: customTextStyle,
                          ),
                          SizedBox(
                            height: getMediaQueryHeight(
                                context: context, value: 10),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              radius: 35,
                              backgroundImage:
                                  AssetImage("assets/download.jpg"),
                            ),
                            title: Text(
                              widget.productname,
                              style: customTextStyle,
                            ),
                            trailing: Wrap(
                              direction: Axis.vertical,
                              children: [
                                Text(
                                  "#2542",
                                  style: customTextStyle,
                                ),
                                Text(
                                  "9472064003",
                                  style: customSmallTextStyle,
                                ),
                              ],
                            ),
                            subtitle: Text(
                              "Elecrician",
                              style: customSmallTextStyle,
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //   children: [Text("data"), Text("data")],
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //   children: [Text("data"), Text("data")],
                          // ),
                          // SizedBox(
                          //   height: getMediaQueryHeight(
                          //       context: context, value: 15),
                          // ),
                          // Container(
                          //   height: getMediaQueryHeight(
                          //       context: context, value: 40),
                          //   width: double.infinity,
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(5),
                          //     border: Border.all(
                          //       color: Colors.black,
                          //       width: 1,
                          //     ),
                          //   ),
                          //   child: Theme(
                          //     data: Theme.of(context).copyWith(
                          //       canvasColor: Colors.white,
                          //       buttonTheme: ButtonThemeData(
                          //         alignedDropdown: true,
                          //         padding:
                          //             EdgeInsets.symmetric(horizontal: 16),
                          //         shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(5),
                          //           side: BorderSide(
                          //               color: Colors.black, width: 2),
                          //         ),
                          //       ),
                          //     ),
                          //     child: Row(
                          //       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         Expanded(
                          //           child: DropdownButton<String>(
                          //             underline: Container(
                          //               height: 0,
                          //             ),
                          //             value: 'Active',
                          //             icon: null,
                          //             iconSize: 0,
                          //             elevation: 16,
                          //             style: const TextStyle(
                          //                 color: Colors.black),
                          //             onChanged: (String? newValue) {
                          //               // Do something with the new value
                          //             },
                          //             items: <String>[
                          //               'Active',
                          //               'On Way',
                          //               'Pendding',
                          //               'Complete',
                          //             ].map<DropdownMenuItem<String>>(
                          //                 (String value) {
                          //               return DropdownMenuItem<String>(
                          //                 value: value,
                          //                 child: Text(value),
                          //               );
                          //             }).toList(),
                          //           ),
                          //         ),
                          //         Padding(
                          //           padding: const EdgeInsets.symmetric(
                          //               horizontal: 5),
                          //           child: Icon(FontAwesomeIcons.angleDown),
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ]),
                  ),
                ),
              ),
              SizedBox(
                height: getMediaQueryHeight(context: context, value: 10),
              ),
              Card(
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Location",
                              style: customTextStyle,
                            ),
                            Text(
                              DateFormat('yyyy-MM-dd HH:mm')
                                  .format(DateTime.now()),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(
                            Icons.location_on,
                            size: 40,
                            color: Color(0xff1b213c),
                          ),
                          title: Text(
                            "New Delhi",
                            style: customSmallTextStyle,
                          ),
                          subtitle: Text("Gali no 1. west sant nagar , Burari"),
                          trailing: Wrap(
                            children: [
                              Text(
                                "Zip Code",
                                style: customSmallTextStyle,
                              ),
                              Text("110115"),
                            ],
                            direction: Axis.vertical,
                          ),
                        ),
                        SizedBox(
                          height:
                              getMediaQueryHeight(context: context, value: 15),
                        ),
                        Container(
                          height:
                              getMediaQueryHeight(context: context, value: 40),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              canvasColor: Colors.white,
                              buttonTheme: ButtonThemeData(
                                alignedDropdown: true,
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: BorderSide(
                                      color: Color(0xff1b213c), width: 2),
                                ),
                              ),
                            ),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: DropdownButton<String>(
                                    underline: Container(
                                      height: 0,
                                    ),
                                    value: 'Active',
                                    icon: null,
                                    iconSize: 0,
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.black),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        // dropdownValue = newValue!;
                                      });
                                    },
                                    items: <String>[
                                      'Active',
                                      'On Way',
                                      'Pendding',
                                      'Complete',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Icon(FontAwesomeIcons.angleDown),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
