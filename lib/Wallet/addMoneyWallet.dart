import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homofix/Custom_Widget/custom_mediamButton.dart';
import 'package:homofix/Custom_Widget/textStyle.dart';
import 'package:homofix/Wallet/selectBank.dart';
import 'package:homofix/Wallet/transferMoney.dart';

class AddMoneyWallet extends StatefulWidget {
  const AddMoneyWallet({Key? key}) : super(key: key);

  @override
  State<AddMoneyWallet> createState() => _AddMoneyWalletState();
}

class _AddMoneyWalletState extends State<AddMoneyWallet> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _amountController = TextEditingController();
  @override
  void dispose() {
    _amountController.dispose();
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
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                "Send Money from Wallet to Bank",
                style: customTextStyle,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Send money from your wallet to bank",
                style: customSmallTextStyle,
              ),
              SizedBox(
                height: 25,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Enter Amount',
                        textAlign: TextAlign.start,
                        style:
                            TextStyle(color: Color(4288914861), fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 10,
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
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Amount ₹';
                            }
                            return null;
                          },
                          controller: _amountController,
                          //  controller: accountNoController,
                          decoration: InputDecoration(
                            hintText: 'Amount',
                            hintStyle: TextStyle(
                              color: Color(4288914861),
                            ),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 14.0),
                            prefixIcon: Icon(
                              FontAwesomeIcons.indianRupee,
                              color: Color(4288914861),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              CustomContainerMediamButton(
                  buttonText: "Proceed",
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectBankScreen(
                                    amount: _amountController.text,
                                  )));
                    }
                    ;
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
