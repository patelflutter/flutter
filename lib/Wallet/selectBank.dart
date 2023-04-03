import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:homofix/Custom_Widget/textStyle.dart';
import 'package:homofix/Wallet/completeProcess.dart';
import 'package:homofix/Wallet/transferMoney.dart';

class SelectBankScreen extends StatefulWidget {
  final String amount;
  const SelectBankScreen({Key? key, required this.amount}) : super(key: key);

  @override
  State<SelectBankScreen> createState() => _SelectBankScreenState();
}

class _SelectBankScreenState extends State<SelectBankScreen> {
  List<dynamic> _dataList = [];
  bool _isLoading = true;

  Future<void> fetchData() async {
    Dio dio = Dio();
    String url = "https://armaan.pythonanywhere.com/api/Kyc/";
    try {
      Response response = await dio.get('$url?technician=40');
      if (response.statusCode == 200) {
        setState(() {
          _dataList = response.data;
          _isLoading = false;
        });
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  int? _selectedIndex;
  @override
  void initState() {
    super.initState();
    fetchData();
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
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.black,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text(
                                  "Select Saved Bank Account",
                                  style: customTextStyle,
                                )),
                            Expanded(
                              child: InkWell(
                                onTap: (() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TransferMoneyScreen()));
                                }),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                      width: 2.0,
                                      color: Color(0xff6956F0),
                                    ),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text(
                                        "Add New",
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
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListTileTheme(
                          selectedTileColor: Color.fromARGB(255, 157, 144, 250),
                          child: ListView.separated(
                            separatorBuilder: (context, index) => Container(
                              height: 0.5,
                              color: Color.fromARGB(255, 201, 200, 200),
                            ),
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _dataList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                child: ListTile(
                                  tileColor: Colors.white,
                                  selected: _selectedIndex == index,
                                  subtitle: Text(
                                    _dataList[index]["Ac_no"],
                                  ),
                                  title: Text(
                                    _dataList[index]["bank_holder_name"],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CompleteWalletScreen(
                                              acNo: _dataList[index]["Ac_no"],
                                              bankHolderName: _dataList[index]
                                                  ["bank_holder_name"],
                                              amounts: widget.amount),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ));
  }
}
