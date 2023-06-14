import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lilac/view/otp_screen.dart';
import 'package:lilac/view/widget/snack_bar.dart';

class LoginAndValidateUser extends ChangeNotifier {
  bool isLoggedIn = false;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<void> getOtp(String phNo, BuildContext context) async {
    try {
      _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+91$phNo",
        verificationCompleted: (phoneAuthCredential) async {
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          throw Exception(error);
        },
        codeSent: (verificationId, forceResendingToken) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpScreen(verificationId: verificationId),
              ));
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on FirebaseAuthException catch (err) {
      SnackBars.errorSnackBar(context, err.message!);
    }
  }

  Future<void> checkOtp(BuildContext context, String otp, String verificationId,
      VoidCallback onSuccess) async {
    try {
      PhoneAuthCredential _authCred = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);
      var _cred = await _firebaseAuth.signInWithCredential(_authCred);
      if (_cred.user != null) {
        onSuccess();
      } else {}
    } on FirebaseAuthException catch (err) {
      SnackBars.errorSnackBar(context, err.message!);
    }
  }
}
