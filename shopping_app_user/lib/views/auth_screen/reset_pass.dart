// ignore_for_file: prefer_const_constructors, avoid_print,

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/widgets%20common/bg_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../widgets common/custom_textfield.dart';
import '../../widgets common/our_button.dart';

class ResetPass extends StatefulWidget {
  const ResetPass({super.key});

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Reset link sent to registerd email !!!!"),
            );
          });
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: restPass.text.fontFamily(semibold).make(),
        ),
        body: Center(
          child: Column(
            children: [
              Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(
                      "Enter Registered Email to receive a link",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  20.heightBox,
                  customTextField(
                      hint: emailHint,
                      title: email,
                      isPass: false,
                      controller: emailController),
                  10.heightBox,
                  ourButton(
                      color: redColor,
                      title: "Reset",
                      //textColor: Colors.black,
                      onPress: () {
                        passwordReset();
                      })
                ],
              )
                  .box
                  .width(context.screenWidth - 80)
                  .height(context.screenHeight / 2.5)
                  .white
                  .rounded
                  .shadowLg
                  .margin(EdgeInsets.only(top: 30))
                  .padding(EdgeInsets.all(16))
                  .make()
            ],
          ),
        ),
      ),
    );
  }
}
