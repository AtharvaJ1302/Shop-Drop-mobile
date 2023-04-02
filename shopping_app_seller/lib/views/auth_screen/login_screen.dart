// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'dart:ffi';

import 'package:emart_seller/views/home%20screen/home.dart';
import 'package:get/get.dart';
import '../../const/const.dart';
import '../../const/images.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/our_button.dart';
import '../../widgets/text_style.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: purpleColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.heightBox,
              normalText(text: welcome, size: 18.0),
              20.heightBox,
              Row(
                children: [
                  Image.asset(
                    icLogo,
                    width: 70,
                    height: 70,
                  )
                      .box
                      .border(color: whiteColor)
                      .roundedSM
                      .padding(EdgeInsets.all(8))
                      .make(),
                  20.widthBox,
                  boldText(text: appname, size: 20.0)
                ],
              ),
              40.heightBox,
              normalText(text: loginTo, size: 18.0, color: lightGrey),
              10.heightBox,
              Obx(
                () => Column(
                  children: [
                    //email field
                    TextFormField(
                      controller: controller.emailController,
                      decoration: InputDecoration(
                          hintText: emailHint,
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.email,
                            color: purpleColor,
                          )),
                    ),

                    10.heightBox,

                    //password field
                    TextFormField(
                      obscureText: true,
                      controller: controller.passwordController,
                      decoration: InputDecoration(
                          hintText: passwordHint,
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: purpleColor,
                          )),
                    ),

                    //forgot password text
                    10.heightBox,
                    Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: normalText(
                              text: forgotPassword, color: purpleColor),
                        )),

                    30.heightBox,

                    //login button
                    SizedBox(
                      width: context.screenWidth - 100,
                      child: controller.isloading.value
                          ? loadingIndicator()
                          : ourButton(
                              title: login,
                              onPress: () async {
                                controller.isloading(true);

                                await controller
                                    .loginMethod(context: context)
                                    .then((value) {
                                  if (value != null) {
                                    VxToast.show(context, msg: "Logged in");
                                    controller.isloading(false);
                                    //Get.offAll(() => Home());
                                  } else {
                                    controller.isloading(false);
                                  }
                                });
                                Get.to(() => Home());
                              },
                            ),
                    ),
                  ],
                )
                    .box
                    .white
                    .rounded
                    .padding(EdgeInsets.all(8))
                    .outerShadowMd
                    .make(),
              ),
              10.heightBox,
              Center(child: normalText(text: anyProblem, color: lightGrey)),
              Spacer(),
              Center(child: boldText(text: credit)),
            ],
          ),
        ),
      ),
    );
  }
}
