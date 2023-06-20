import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Custom_Widget/responsiveHeigh_Width.dart';

class AdomsScreen extends StatefulWidget {
  final List<dynamic> products;

  AdomsScreen({Key? key, required this.products}) : super(key: key);

  @override
  State<AdomsScreen> createState() => _AdomsScreenState();
}

class _AdomsScreenState extends State<AdomsScreen> {
  @override
  void initState() {
    super.initState();
    fetchSpareParts();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> pro = widget.products;
    double price = 799;
    double tax = 0.18;
    double totalPrice = price + (price * tax);
    String formattedPrice = totalPrice.toStringAsFixed(2);
    double taxPrice = totalPrice - price;
    String formattedtaxPrice = taxPrice.toStringAsFixed(2);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Image(
                  image: AssetImage(
                    "assets/homofixlogo.jpg",
                  ),
                  height: 15,
                ),
                title: Text(
                  "Homofix Technologies Pvt Ltd",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "501 D Second Floor, Rishi Complex, Ashok Vihar, Delhi, New Delhi, Delhi 110052,",
                      style: TextStyle(
                          //letterSpacing: 1,
                          wordSpacing: 1,
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Regd Office : 5139, Awas Vikas 3, Kalyanpur, Kanpur,Utter Pradesh,India,208017",
                      style: TextStyle(
                          wordSpacing: 1,
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "GSTIN : 07AAGCH4863F1ZI",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Table(
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'ITEMS',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'QTY',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'RATE',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'TAX',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'Amount',
                            style: TextStyle(
                              // fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...List.generate(
                    pro.length,
                    (index) => TableRow(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      children: [
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  pro[index]['name'].toUpperCase(),
                                  style: TextStyle(fontSize: 10),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _openAddonsDialog();
                                  },
                                  child: Container(
                                    decoration:
                                        BoxDecoration(color: Colors.yellow),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        '+  Addons'.toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              '1 PCS',
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              pro[index]['price'].toString(),
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$formattedtaxPrice',
                                  style: TextStyle(fontSize: 10),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    '(18%)',
                                    style: TextStyle(fontSize: 8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              "$formattedPrice",
                              style: TextStyle(fontSize: 10),
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
    );
  }

  String? _selectedSparePart;
  List<String> _sparePartList = []; // list to store fetched data

  void fetchSpareParts() async {
    final response = await http
        .get(Uri.parse('https://armaan.pythonanywhere.com/api/SpareParts/'));
    final data = json.decode(response.body);
    setState(() {
      _sparePartList =
          List<String>.from(data.map((item) => item['spare_part']));
      print(_sparePartList);
    });
  }

// call the function to fetch data in initState or somewhere appropriate

  _openAddonsDialog() {
    TextEditingController _valueController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add Addons"),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 4,
                height: getMediaQueryHeight(context: context, value: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: DropdownButton(
                        hint: Text("Select"),
                        icon: Icon(FontAwesomeIcons.angleDown,
                            color: Colors.black),
                        iconSize: 18,
                        iconEnabledColor: Colors.black,
                        isDense: true,
                        isExpanded: true,
                        underline: null,
                        value: _selectedSparePart,
                        items: _sparePartList.map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            _selectedSparePart = newValue;
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                _selectedSparePart ?? '',
                style: TextStyle(color: Colors.black),
              ),

              SizedBox(
                width: 10,
              ),
              //  Spacer(),
              Container(
                height: getMediaQueryHeight(context: context, value: 40),
                width: MediaQuery.of(context).size.width / 5,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _valueController,
                  // controller: TextEditingController(text: "$_count"),
                  decoration: InputDecoration(
                    isDense: true,
                  ),
                ),
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel', style: TextStyle(color: Colors.black)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Add to Cart', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.pop(context);
                addAddon();
                //  Navigator.of(context).pop(_selectedQuantity.toString());
              },
            ),
          ],
        );
      },
    );
  }

  void addAddon() async {
    var url = Uri.parse('https://armaan.pythonanywhere.com/api/Addons/');
    var response = await http.post(url, body: {
      "quantity": 2.toString(),
      "description": "Addon Description",
      "booking_prod_id": 2.toString(),
      "addon_products": 4.toString()
    });
    print(response.statusCode);
    print(response.body);
  }
}
  // List<dynamic> _spareParts = [];

  // Future<void> _fetchSpareParts() async {
  //   final response = await http
  //       .get(Uri.parse('https://armaan.pythonanywhere.com/api/SpareParts/'));

  //   if (response.statusCode == 200) {
  //     setState(() {
  //       _spareParts = jsonDecode(response.body);
  //     });
  //   } else {
  //     throw Exception('Failed to load spare parts');
  //   }
  // }

  // _openAddonsDialog() {
  //   int _selectedQuantity = 1; // default quantity
  //   String _selectedStatus = 'Copperwire';
  //   Color _buttonColor = Color(0xFFF7E2C2);

  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("Addons"),
  //         content: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: [
  //             Container(
  //               width: MediaQuery.of(context).size.width / 3,
  //               height: getMediaQueryHeight(context: context, value: 40),
  //               decoration: BoxDecoration(
  //                 color: _buttonColor,
  //                 borderRadius: BorderRadius.circular(4),
  //               ),
  //               child: Center(
  //                 child: SizedBox(
  //                   width: double.infinity,
  //                   child: Padding(
  //                       padding: const EdgeInsets.symmetric(horizontal: 8),
  //                       child: DropdownButton<String>(
  //                         icon: Icon(FontAwesomeIcons.angleDown,
  //                             color: Colors.black),
  //                         iconSize: 18,
  //                         iconEnabledColor: Colors.black,
  //                         isDense: true,
  //                         isExpanded: true,
  //                         value: _selectedStatus,
  //                         underline: Text(""),
  //                         items: <String>[
  //                           'Copperwire',
  //                           'switch',
  //                         ].map((String value) {
  //                           return DropdownMenuItem<String>(
  //                             value: value,
  //                             child: Text(value),
  //                           );
  //                         }).toList(),
  //                         onChanged: (String? newValue) {
  //                           if (newValue != null) {
  //                             setState(() {
  //                               _selectedStatus = newValue;
  //                             });
  //                           }
  //                         },
  //                       )),
  //                 ),
  //               ),
  //             ),
  //             // SizedBox(width: 16),
  //             Container(
  //               width: 50,
  //               // width: MediaQuery.of(context).size.width / 4,
  //               child: TextFormField(
  //                 decoration: InputDecoration(
  //                   hintText: 'Quantity',
  //                   border: OutlineInputBorder(),
  //                 ),
  //                 keyboardType: TextInputType.number,
  //                 initialValue: '$_selectedQuantity',
  //                 onChanged: (value) {
  //                   setState(() {
  //                     _selectedQuantity = int.parse(value);
  //                   });
  //                 },
  //               ),
  //             ),
  //           ],
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text('Cancel', style: TextStyle(color: Colors.black)),
  //             onPressed: () => Navigator.of(context).pop(),
  //           ),
  //           TextButton(
  //             child: Text('Add to Cart', style: TextStyle(color: Colors.black)),
  //             onPressed: () {
  //               Navigator.of(context).pop(_selectedQuantity.toString());
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   ).then((value) {
  //     if (value != null) {
  //       setState(() {
  //         _selectedQuantity = int.parse(value);
  //       });
  //     }
  //   });
  // }

