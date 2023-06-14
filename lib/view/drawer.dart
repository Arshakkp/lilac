import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../utils/labelStyle.dart';

class LilacDrawer extends StatelessWidget {
  const LilacDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Hi PhoneNumber",
              style: LabelStyle.heading,
            ),
            Divider(),
            InkWell(
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: const Text(
                  "Edit User",
                  style: LabelStyle.buttonStyle,
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
