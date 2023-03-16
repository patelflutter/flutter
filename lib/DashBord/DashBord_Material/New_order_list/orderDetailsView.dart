import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../../Custom_Widget/responsiveHeigh_Width.dart';
import '../../../Custom_Widget/textStyle.dart';

class OrderDetailsView extends StatefulWidget {
  const OrderDetailsView({Key? key}) : super(key: key);

  @override
  State<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
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
          "Order Details",
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
                    'Rs 500',
                    style: TextStyle(
                        color: Color(0xff1b213c),
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
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
                  )
                  //     Theme(
                  //       data: Theme.of(context).copyWith(
                  //         canvasColor: Color(0xff1b213c),
                  //         buttonTheme: ButtonThemeData(
                  //           alignedDropdown: true,
                  //           padding: EdgeInsets.symmetric(horizontal: 16),
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(5),
                  //             side: BorderSide(color: Colors.black, width: 1),
                  //           ),
                  //         ),
                  //       ),
                  //       child: Row(
                  //         children: [
                  //           Expanded(
                  //             flex: 2,
                  //             child: DropdownButton<String>(
                  //               underline: Container(
                  //                 height: 0,
                  //               ),
                  //               value: 'ACTIVE',
                  //               icon: null,
                  //               iconSize: 0,
                  //               elevation: 16,
                  //               // style: const TextStyle(color: Colors.black),
                  //               onChanged: (String? newValue) {
                  //                 // Do something with the new value
                  //               },
                  //               items: <String>[
                  //                 'ACTIVE',
                  //                 'ONWAY',
                  //                 'PENDDING',
                  //                 'COMPLETED',
                  //               ].map<DropdownMenuItem<String>>((String value) {
                  //                 return DropdownMenuItem<String>(
                  //                   value: value,
                  //                   child: Text(
                  //                     value,
                  //                     style: TextStyle(
                  //                         color: Colors.white,
                  //                         fontWeight: FontWeight.bold),
                  //                   ),
                  //                 );
                  //               }).toList(),
                  //             ),
                  //           ),
                  //           Padding(
                  //             padding: const EdgeInsets.symmetric(horizontal: 5),
                  //             child: Icon(
                  //               FontAwesomeIcons.angleDown,
                  //               color: Colors.white,
                  //             ),
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                              "Switch Board Installation",
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
                                "Ravi Patel",
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
                            subtitle:
                                Text("Gali no 1. west sant nagar , Burari"),
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
                            height: getMediaQueryHeight(
                                context: context, value: 15),
                          ),
                          Container(
                            height: getMediaQueryHeight(
                                context: context, value: 40),
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
                                      style:
                                          const TextStyle(color: Colors.black),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
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
      ),
    );
  }
}
