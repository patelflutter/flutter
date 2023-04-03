import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPeyScreen extends StatefulWidget {
  const RazorPeyScreen({Key? key}) : super(key: key);

  @override
  State<RazorPeyScreen> createState() => _RazorPeyScreenState();
}

class _RazorPeyScreenState extends State<RazorPeyScreen> {
  final Razorpay _razorpay = Razorpay();

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // handle payment success
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // handle payment error
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // handle external wallet response
  }
  void _openRazorpay() {
    var options = {
      'key': '<YOUR_RAZORPAY_API_KEY>',
      'amount': 100,
      'name': 'Acme Corp.',
      'description': 'Test Payment',
      'prefill': {'contact': '1234567890', 'email': 'test@example.com'}
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(onPressed: _openRazorpay, child: Text("Open"))
          ],
        ),
      ),
    );
  }
}
