import 'package:flutter/material.dart';
import 'package:homofix/Custom_Widget/textStyle.dart';
import 'package:homofix/Wallet/razorPey.dart';

import 'package:intl/intl.dart';

import 'addMoneyWallet.dart';

class Transaction {
  final String title;
  final double amount;
  final DateTime date;

  Transaction({required this.title, required this.amount, required this.date});
}

class WalletScreen extends StatefulWidget {
  WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  List<Transaction> _transactionList = [
    Transaction(title: 'Groceries', amount: 50.0, date: DateTime.now()),
    Transaction(title: 'Gas', amount: 30.0, date: DateTime.now()),
    Transaction(title: 'Rent', amount: 500.0, date: DateTime.now()),
    Transaction(title: 'Groceries', amount: 50.0, date: DateTime.now()),
    Transaction(title: 'Gas', amount: 30.0, date: DateTime.now()),
    Transaction(title: 'Rent', amount: 500.0, date: DateTime.now()),
    Transaction(title: 'Groceries', amount: 50.0, date: DateTime.now()),
    Transaction(title: 'Gas', amount: 30.0, date: DateTime.now()),
    Transaction(title: 'Rent', amount: 500.0, date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff6956F0),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            "My Wallet",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0, 0.25, 0.75, 1],
                      colors: [
                        Color.fromARGB(153, 78, 61, 233),
                        Color(0xff6956F0),
                        Color(0xff6956F0),
                        Color.fromARGB(153, 78, 61, 233),
                      ],
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                        gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            // colors: [Color(0xff6956F0), Color(0xff6956F0)],
                            colors: [
                              Color.fromARGB(255, 255, 255, 255),
                              Color.fromARGB(255, 255, 255, 255)
                            ]),
                      ),
                      child: Stack(
                        children: [
                          circleTopRight(),
                          circleBottomLeft(),
                          backgroundChart(),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: (() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddMoneyWallet()));
                      }),
                      child: Card(
                        elevation: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2.0,
                              color: Color(0xff6956F0),
                            ),
                          ),
                          width: 150,
                          height: 50,
                          child: Center(
                            child: Text(
                              "Transfer",
                              style: TextStyle(
                                color: Color(0xff6956F0),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RazorPeyScreen()));
                      },
                      child: Card(
                        elevation: 2,
                        child: Container(
                          //   margin: EdgeInsets.all(8),
                          height: 50,
                          width: 150,
                          color: Color(0xff6956F0),
                          child: Center(
                              child: Text(
                            "Recharge",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
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
                        "Transactions ".toUpperCase(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff6956F0),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height - 200,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: _transactionList.length,
                        itemBuilder: (context, index) {
                          final transaction = _transactionList[index];
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Card(
                              elevation: 0,
                              child: ListTile(
                                title: Text(
                                  transaction.title,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  transaction.date.toString(),
                                  style: customSmallTextStyle,
                                ),
                                trailing: Text(
                                  '\$${transaction.amount}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

Widget backgroundChart() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Balance",
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            NumberFormat.currency(
              locale: 'en_IN',
              symbol: '₹',
              decimalDigits: 2,
            ).format(5000),
            style: TextStyle(
                color: Color(0xff6956F0),
                //  color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 3,
          ),
        ],
      ),
    ),
  );
}

Widget circleTopRight() {
  return Positioned(
    left: -80,
    top: -160,
    child: Container(
      width: 265,
      height: 265,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment(-0.8, -0.7),
          end: Alignment.bottomCenter,
          colors: [
            Color(0x00ADA4F3),
            Color.fromARGB(255, 206, 201, 245),
          ],
        ),
      ),
    ),
  );
}

Widget circleBottomLeft() {
  return Positioned(
    right: -100,
    bottom: -200,
    child: Container(
      width: 280,
      height: 280,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment(0.9, -0.2),
          colors: [
            Color.fromARGB(255, 173, 164, 243),
            Color.fromARGB(255, 206, 201, 245),
          ],
        ),
      ),
    ),
  );
}

List serviceName = ['Transfer ', 'Add Money '].toList();
List<Icon> serviceIcon = [
  Icon(
    Icons.payment,
    color: Color(0xff6956F0),
  ),
  Icon(
    Icons.attach_money,
    color: Color(0xff6956F0),
  ),
];
