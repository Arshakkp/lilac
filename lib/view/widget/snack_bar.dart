import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnackBars {
  static errorSnackBar(BuildContext context, String content) =>
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(content)));
}
