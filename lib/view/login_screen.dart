import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lilac/controller/loginandvalidation.dart';
import 'package:lilac/utils/labelStyle.dart';
import 'package:provider/provider.dart';

import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phNoController = TextEditingController();
  bool isError = false;
  onLogin() {
    Provider.of<LoginAndValidateUser>(context, listen: false)
        .getOtp(_phNoController.text, context);
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: SizedBox(
            height: _height,
            child: Consumer<LoginAndValidateUser>(
              builder: (context, value, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      autovalidateMode: AutovalidateMode.always,
                      controller: _phNoController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          label: Text("Mobile Number"), prefix: Text("+91")),
                    ),
                    ElevatedButton(
                        onPressed: onLogin,
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 7, horizontal: 10),
                            child: const Text(
                              "Login",
                              style: TextStyle(fontSize: 18),
                            )))
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
