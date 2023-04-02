// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/auth_controller.dart';
import 'package:emart_app/views/auth_screen/reset_pass.dart';
import 'package:emart_app/views/auth_screen/signup_screen.dart';
import 'package:emart_app/widgets%20common/applogo_widget.dart';
import 'package:emart_app/widgets%20common/bg_widget.dart';
import 'package:emart_app/widgets%20common/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../consts/lists.dart';
import '../../widgets common/our_button.dart';
import '../homescreen/home.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
            Obx(
              () => Column(
                children: [
                  //email field
                  customTextField(
                      hint: emailHint,
                      title: email,
                      isPass: false,
                      controller: controller.emailController),
                  //password field
                  customTextField(
                      hint: passwordHint,
                      title: password,
                      isPass: true,
                      controller: controller.passwordController),
                  //forgot password field
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Get.to(() => ResetPass());
                      },
                      child: forgetPass.text.make(),
                    ),
                  ),

                  5.heightBox,

                  //login button
                  controller.isloading.value
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        )
                      : ourButton(
                          color: redColor,
                          title: login,
                          textColor: whiteColor,
                          onPress: () async {
                            controller.isloading(true);

                            await controller
                                .loginMethod(context: context)
                                .then((value) {
                              if (value != null) {
                                VxToast.show(context, msg: loggedin);
                                Get.offAll(() => Home());
                              } else {
                                controller.isloading(false);
                              }
                            });
                          }).box.width(context.screenWidth - 50).make(),

                  5.heightBox,

                  //create new account text
                  createNewAccount.text.color(fontGrey).make(),

                  5.heightBox,

                  //signup button
                  ourButton(
                      color: Colors.black,
                      title: signup,
                      textColor: redColor,
                      onPress: () {
                        Get.to(() => SignupScreen());
                      }).box.width(context.screenWidth - 50).make(),

                  10.heightBox,
                  loginWith.text.color(fontGrey).make(),

                  5.heightBox,

                  //social icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        3,
                        (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: lightGrey,
                                radius: 25,
                                child: Image.asset(
                                  socialIconList[index],
                                  width: 30,
                                ),
                              ),
                            )),
                  )
                ],
              )
                  .box
                  .white
                  .rounded
                  .width(context.screenWidth - 70)
                  .padding(EdgeInsets.all(16))
                  .shadowSm
                  .make(),
            ),
          ],
        ),
      ),
    ));
  }
}
