import 'package:flutter/material.dart';
import 'package:homofix/Custom_Widget/responsiveHeigh_Width.dart';
import '../../Custom_Widget/textStyle.dart';

class OtpView extends StatefulWidget {
  final String expertId;
  final String expertname;
  OtpView({Key? key, required this.expertId, required this.expertname})
      : super(key: key);

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();

  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  FocusNode focusNode4 = FocusNode();
  @override
  void dispose() {
    super.dispose();

    controller1.clear();
    controller2.clear();
    controller3.clear();
    controller4.clear();
  }

  @override
  Widget build(BuildContext context) {
    var size = SizedBox(
      height: 15,
    );
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/undraw_Vault_re_s4my.png"),
            size,
            Text("Enter OTP", style: customTextStyle),

            Text(
              "A 4 digit Code has been send to :",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Color(0xFFC5C5C5), fontSize: 12),
            ),
            Text(
              "9472064003 ",
              style: TextStyle(
                color: Color(0xff6956F0),
              ),
            ),
            size,
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              buildOTPTextField(controller1, focusNode1),
              buildOTPTextField(controller2, focusNode2),
              buildOTPTextField(controller3, focusNode3),
              buildOTPTextField(controller4, focusNode4),
            ]),
            size,
            size,
            Center(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Color(0xff6956F0)),
                      borderRadius: BorderRadius.circular(6)),
                  height: getMediaQueryHeight(context: context, value: 45),
                  width: getMediaQueryWidth(context: context, value: 100),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                      "Verify".toUpperCase(),
                      style: TextStyle(
                          color: Color(0xff6956F0),
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
              ),
            )
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => ResetPassword()),
            //     );
            //   },
            //   child: Center(
            //     child: CustomContainerSmallButton(
            //       buttonText: 'Verify',
            //       onTap: () {},
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget buildOTPTextField(
      TextEditingController controller, FocusNode focusNode) {
    return Card(
      elevation: 0,
      child: Container(
        width: getMediaQueryWidth(context: context, value: 38.0),
        height: getMediaQueryHeight(context: context, value: 40.0),
        decoration: BoxDecoration(
          color: Color(0xFFEBEBEB),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: focusNode.hasFocus ? Colors.blue : Colors.grey,
            width: 0.0,
          ),
        ),
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: TextInputType.number,
          style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Color(0xff6956F0)),
          maxLength: 1,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: '',
          ),
          onChanged: (value) {
            if (value.isNotEmpty) {
              focusNode.nextFocus();
            } else {
              focusNode.previousFocus();
            }
          },
        ),
      ),
    );
  }
}
