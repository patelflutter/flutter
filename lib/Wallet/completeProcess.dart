import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homofix/Custom_Widget/textStyle.dart';
import 'package:homofix/dashbord.dart';
import 'package:intl/intl.dart';
import '../Custom_Widget/custom_mediamButton.dart';

class CompleteWalletScreen extends StatefulWidget {
  final String acNo;
  final String bankHolderName;
  final String amounts;
  final String technicianId;
  const CompleteWalletScreen(
      {Key? key,
      required this.acNo,
      required this.technicianId,
      required this.bankHolderName,
      required this.amounts})
      : super(key: key);

  @override
  State<CompleteWalletScreen> createState() => _CompleteWalletScreenState();
}

class _CompleteWalletScreenState extends State<CompleteWalletScreen> {
  void _handlePaymentSuccess() async {
    final url = 'https://armaan.pythonanywhere.com/api/Withdraw/Request/Post/';
    final dio = Dio();
    dio.options.headers['Content-Type'] = 'application/json';
    final data = {
      'amount': widget.amounts,
      'technician_id': widget.technicianId,
    };
    print('--------------Hello--------');

    try {
      final response = await dio.post(url, data: data);
      if (response.statusCode == 200) {
        // Payment data successfully posted to the API
        debugPrint('Payment data successfully posted to the API');
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => DashBord()),
          (route) => false,
        );
      } else {
        debugPrint(
            'Error posting payment data to the API: ${response.statusCode}');
      }
    } catch (e) {
      // Exception while posting payment data to the API
      debugPrint('Exception while posting payment data to the API: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff002790),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25,
              ),
              Text(
                "Sending money from Wallet to",
                style: customTextStyle,
              ),
              SizedBox(
                height: 25,
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  widget.bankHolderName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(widget.acNo),
                trailing: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    //  borderRadius: BorderRadius.circular(1),
                    border: Border.all(
                      color: Color(0xFFD6D5D5),
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    // backgroundColor: Colors.grey,
                    child: Icon(
                      FontAwesomeIcons.bank,
                      size: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 0.5, color: Color.fromARGB(255, 214, 211, 211))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListTile(
                      title: Text(
                        "Amount to be send ",
                        style: customSmallTextStyleNoBold,
                      ),
                      trailing: Text(
                        NumberFormat.currency(
                          locale: 'en_IN',
                          symbol: '₹',
                          decimalDigits: 2,
                        ).format(double.parse(widget.amounts)).toString(),
                        style: customSmallTextStyleNoBold,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Charge(0%)",
                        style: customSmallTextStyleNoBold,
                      ),
                      trailing: Text(
                        NumberFormat.currency(
                          locale: 'en_IN',
                          symbol: '₹',
                          decimalDigits: 2,
                        ).format(0).toString(),
                        style: customSmallTextStyleNoBold,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Total Payble",
                        style: customSmallTextStyle,
                      ),
                      trailing: Text(
                        NumberFormat.currency(
                          locale: 'en_IN',
                          symbol: '₹',
                          decimalDigits: 2,
                        ).format(double.parse(widget.amounts)).toString(),
                        style: customSmallTextStyle,
                      ),
                    ),
                    Container(
                      height: 8,
                      color: Color(0xff002790),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              CustomContainerMediamButton(
                buttonText: 'Proceed',
                onTap: () async {
                  _handlePaymentSuccess();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
