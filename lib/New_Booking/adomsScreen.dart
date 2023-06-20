import 'package:flutter/material.dart';
import 'package:homofix/New_Booking/invoiceView.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;

class AdomsItemScreen extends StatefulWidget {
  final String expertId;
  final String city;
  final String area;
  final int zipCode;
  final String state;
  final int orderId;
  final String expertname;
  final Map<String, dynamic> customerdetails;
  final List<dynamic> products;
  final List<dynamic> productSet;

  final String status;
  const AdomsItemScreen({
    Key? key,
    required this.productSet,
    required this.area,
    required this.state,
    required this.city,
    required this.zipCode,
    required this.status,
    required this.expertId,
    required this.expertname,
    required this.orderId,
    required this.products,
    required this.customerdetails,
  }) : super(key: key);

  @override
  State<AdomsItemScreen> createState() => _AdomsItemScreenState();
}

class _AdomsItemScreenState extends State<AdomsItemScreen> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> pro = widget.products;
    List<dynamic> proSet = widget.productSet;

    for (int i = 0; i < pro.length; i++) {
      String productId = pro[i]['id'].toString();
      // Do something with the productId
      print("My Id : $productId");
    }
    for (int i = 0; i < proSet.length; i++) {
      String productName = proSet[i]['id'].toString();
      print("My Id : $productName");
    }
    double firstTableTotalPrice = 0.0;
    double prices = 0.0;
    double firstTax = 0.0;
    double secondTax = 0.0;
    for (int i = 0; i < pro.length; i++) {
      double price = pro[i]['price'].toDouble();
      prices += price;
      double taxPrice = price * 0.18;
      firstTax += taxPrice / 2;
      secondTax += taxPrice / 2;
      double totalPriceWithTax = price + taxPrice;
      firstTableTotalPrice += totalPriceWithTax;
    }
    String formattedFirstTableTotalPrice =
        firstTableTotalPrice.toStringAsFixed(2);
    double secondTableTotalPrice = 0.0;
    // for (int i = 0; i < dataList.length; i++) {
    //   double price = dataList[i]['spare_parts_id']['price'].toDouble();
    //   double taxPrice = price * 0.18;
    //   int quantity = dataList[i]['quantity'];
    //   double totalPriceWithTax = (price * quantity) + taxPrice;
    //   secondTableTotalPrice += totalPriceWithTax;
    // }

    String formattedSecondTableTotalPrice =
        secondTableTotalPrice.toStringAsFixed(2);
    double overallTotalPrice = firstTableTotalPrice + secondTableTotalPrice;
    String formattedOverallTotalPrice = overallTotalPrice.toStringAsFixed(2);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            Center(child: Image.asset("assets/homofixlogo.jpg")),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 5,
              color: Colors.black,
            ),
            Container(
              //  height: 35,
              width: double.infinity,
              color: Color.fromARGB(255, 231, 229, 229),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Invoice No",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        Text("5"),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Invoice Date",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        Text("21/03/2023"),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Due Date",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                        Text("28/03/2023"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: SizedBox(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'BILL TO',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Customer Name',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '123 Main Stree Anytown, USA 12345\n Phone: (123) 456-7890\n Email: customer@email.com',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: SizedBox(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'SHIP TO',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.customerdetails['admin']['first_name'],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.customerdetails['address'] +
                                widget.zipCode.toString(),
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  flex: 1,
                )
              ],
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
                ...List.generate(pro.length, (index) {
                  double price = pro[index]['price'].toDouble();
                  double taxPrice = price * 0.18;
                  double totalPriceWithTax = price + taxPrice;
                  double totalPrice = 0.0;
                  totalPrice += totalPriceWithTax;
                  String formattedTotalPrice =
                      totalPriceWithTax.toStringAsFixed(2);
                  return TableRow(
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
                            "\u20B9 ${pro[index]['price'].toString()}",
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            '$taxPrice',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "\u20B9 ${formattedTotalPrice}",
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Divider(
              thickness: 1,
              color: Colors.black,
            ),
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
                          'total'.toUpperCase(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          '1',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          '',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          '15.25',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          '100',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text("Taxable amount".toUpperCase())),
                          Text("$prices")
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text("cgst @9%".toUpperCase())),
                          Text("$firstTax")
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text("sgst @9%".toUpperCase())),
                          Text("$secondTax")
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: .5,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Total Amount".toUpperCase(),
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Text(
                            "$firstTableTotalPrice",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: .5,
                        width: MediaQuery.of(context).size.width * 0.5,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(child: Text("Received Amount")),
                          SizedBox(
                            width: 40,
                          ),
                          Text("0")
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text("Total Amount (In Words)"),
                    Text("One Hundred Rupees")
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Divider(
              thickness: 1,
              color: Colors.black,
            ),
            Text(
              "Homofix Technologies Pvt Ltd",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "501 D Second Floor, Rishi Complex, Ashok Vihar, Delhi, New Delhi, Delhi 110052,",
              style: TextStyle(
                  //letterSpacing: 1,

                  color: Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              "Regd Office : 5139, Awas Vikas 3, Kalyanpur, Kanpur,Utter Pradesh,India,208017",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "GSTIN : 07AAGCH4863F1ZI",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.w500),
            )
          ]),
        ),
      ),
    );
  }
}
