import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../Custom_Widget/responsiveHeigh_Width.dart';

class BookingHistory extends StatefulWidget {
  const BookingHistory({Key? key}) : super(key: key);

  @override
  State<BookingHistory> createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> {
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
          "Booking History",
          style: TextStyle(color: Colors.black),
        ),
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
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 4,
          // separatorBuilder: (context, index) => SizedBox(
          //   height: getMediaQueryHeight(context: context, value: 2),
          // ),
          itemBuilder: (context, index) => Column(
            children: [
              SizedBox(
                height: getMediaQueryHeight(context: context, value: 10),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: Material(
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => OrderDetailsView()));
                    },
                    child: Material(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                    radius: 30,
                                    backgroundImage:
                                        AssetImage("assets/download.jpg")),
                                title: Text(
                                  "Switch Board Installation",
                                  style: TextStyle(
                                      color: Color(0xff1b213c),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Electrician"),
                                  ],
                                ),
                                trailing:
                                    Wrap(direction: Axis.vertical, children: [
                                  Text("9472064003"),
                                  Text(" #3972"),
                                ]),
                              ),
                              Divider(
                                color: Colors.black,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: getMediaQueryWidth(
                                        context: context, value: 200),
                                    child: Text(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      "Ashok Vihar, New Delhi",
                                    ),
                                  ),
                                  Text(
                                    DateFormat('yyyy-MM-dd HH:mm')
                                        .format(DateTime.now()),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
