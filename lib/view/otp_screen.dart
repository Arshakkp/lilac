import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lilac/controller/loginandvalidation.dart';
import 'package:lilac/main.dart';
import 'package:lilac/view/home_screen.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.verificationId});
  final String verificationId;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController _otpController = TextEditingController();
  checkOtp() {
    Provider.of<LoginAndValidateUser>(context, listen: false)
        .checkOtp(context, _otpController.text, widget.verificationId, () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return HomeScreen();
          },
        ),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextField(
            controller: _otpController,
          ),
          ElevatedButton(onPressed: checkOtp, child: const Text("Check Otp"))
        ]),
      ),
    );
  }
}
