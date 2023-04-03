import 'package:flutter/material.dart';
import 'package:homofix/Custom_Widget/custom_mediamButton.dart';
import 'package:homofix/Custom_Widget/textStyle.dart';
import 'package:dio/dio.dart';

import 'addMoneyWallet.dart';

class AccountDetails {
  String? accountNo;
  String? ifscCode;
  String? accountHolderName;

  AccountDetails({this.accountNo, this.ifscCode, this.accountHolderName});
}

class TransferMoneyScreen extends StatefulWidget {
  const TransferMoneyScreen({Key? key}) : super(key: key);

  @override
  State<TransferMoneyScreen> createState() => _TransferMoneyScreenState();
}

class _TransferMoneyScreenState extends State<TransferMoneyScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController accountNoController = TextEditingController();
  TextEditingController ifscCodeController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController accountHolderNameController = TextEditingController();
  List<dynamic> _dataList = [];

  Future<void> postData() async {
    Dio dio = Dio();
    String url = "https://armaan.pythonanywhere.com/api/Kyc/?technician=40";

    try {
      FormData formData = FormData.fromMap({
        "Ac_no": accountNoController.text,
        "ifsc_code": ifscCodeController.text,
        "bank_holder_name": accountHolderNameController.text,
        "branch": branchController.text,
        "technician_id": 40
      });
      Response response = await dio.post(url, data: formData);
      if (response.statusCode == 201) {
        // handle success
        print(response.data);
      } else {
        // handle error
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      // handle error
      print(e.toString());
    }
  }

  AccountDetails _accountDetails = AccountDetails();

  int? _selectedIndex;
  @override
  void dispose() {
    accountHolderNameController.dispose();
    accountNoController.dispose();
    ifscCodeController.dispose();
    branchController.dispose();
    super.dispose();
  }

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
          "Bank Details".toUpperCase(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Add Bank Account",
                    style: customTextStyle,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Enter Account No.',
                          textAlign: TextAlign.start,
                          style:
                              TextStyle(color: Color(4288914861), fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(10.0),
                        elevation: 0,
                        color: Colors.white,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6.0,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Account no';
                              }
                              return null;
                            },
                            controller: accountNoController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Color(4288914861),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  Column(children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'IFSC Code',
                        textAlign: TextAlign.start,
                        style:
                            TextStyle(color: Color(4288914861), fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(10.0),
                      elevation: 0,
                      color: Colors.white,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6.0,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'IFSC code';
                              }
                              return null;
                            },
                            controller: ifscCodeController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Color(4288914861),
                              ),
                            )),
                      ),
                    )
                  ]),
                  SizedBox(height: 15),
                  Column(children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Account Branch",
                        textAlign: TextAlign.start,
                        style:
                            TextStyle(color: Color(4288914861), fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(10.0),
                      elevation: 0,
                      color: Colors.white,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6.0,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Account Branch';
                              }
                              return null;
                            },
                            controller: branchController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Color(4288914861),
                              ),
                            )),
                      ),
                    ),
                  ]),
                  SizedBox(height: 15),
                  Column(children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Account Holder's Name",
                        textAlign: TextAlign.start,
                        style:
                            TextStyle(color: Color(4288914861), fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(10.0),
                      elevation: 0,
                      color: Colors.white,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6.0,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter AccountHolder name';
                              }
                              return null;
                            },
                            controller: accountHolderNameController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Color(4288914861),
                              ),
                            )),
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 25,
                  ),
                  CustomContainerMediamButton(
                      buttonText: 'Proceed',
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          await postData();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddMoneyWallet(),
                            ),
                          );
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
