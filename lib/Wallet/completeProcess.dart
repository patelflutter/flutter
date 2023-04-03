import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:homofix/Custom_Widget/textStyle.dart';

import '../Custom_Widget/custom_mediamButton.dart';

class CompleteWalletScreen extends StatefulWidget {
  final String acNo;
  final String bankHolderName;
  final String amounts;
  const CompleteWalletScreen(
      {Key? key,
      required this.acNo,
      required this.bankHolderName,
      required this.amounts})
      : super(key: key);

  @override
  State<CompleteWalletScreen> createState() => _CompleteWalletScreenState();
}

class _CompleteWalletScreenState extends State<CompleteWalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff6956F0),
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
                        widget.amounts,
                        style: customSmallTextStyleNoBold,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Charge(0%)",
                        style: customSmallTextStyleNoBold,
                      ),
                      trailing: Text(
                        "0",
                        style: customSmallTextStyleNoBold,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Total Payble",
                        style: customSmallTextStyle,
                      ),
                      trailing: Text(
                        widget.amounts,
                        style: customSmallTextStyle,
                      ),
                    ),
                    Container(
                      height: 8,
                      color: Color(0xff6956F0),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              CustomContainerMediamButton(
                  buttonText: 'Proceed',
                  onTap: () {
                    //  await postData();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
