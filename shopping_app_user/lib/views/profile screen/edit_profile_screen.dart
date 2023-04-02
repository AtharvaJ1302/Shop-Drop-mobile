// ignore_for_file: prefer_const_constructors, use_build_context_synchronously
import 'dart:io';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/widgets%20common/bg_widget.dart';
import 'package:emart_app/widgets%20common/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/profile_controller.dart';
import '../../widgets common/our_button.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //if data image URL and path is empty show this --->
            data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                ? Image.asset(
                    myProfileImg,
                    height: 100,
                    width: 90,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make()

                //if data isn't empty but controller path is empty show this --->
                : data['imageUrl'] != '' && controller.profileImgPath.isEmpty
                    ? Image.network(
                        data['imageUrl'],
                        width: 90,
                        height: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make()

                    //if both are empty show this --->
                    : Image.file(
                        File(controller.profileImgPath.value),
                        height: 100,
                        width: 90,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make(),

            // controller.profileImgPath.isEmpty
            //     ? Image.asset(
            //         myProfileImg,
            //         width: 100,
            //         fit: BoxFit.cover,
            //       ).box.roundedFull.clip(Clip.antiAlias).make()
            //     : Image.file(
            //         File(controller.profileImgPath.value),
            //       ),
            10.heightBox,

            //change button
            ourButton(
                color: redColor,
                onPress: () {
                  controller.changeImage(context);
                },
                textColor: whiteColor,
                title: "Change"),
            Divider(),
            20.heightBox,
            customTextField(
                hint: nameHint,
                title: name,
                isPass: false,
                controller: controller.nameController),
            10.heightBox,
            customTextField(
                hint: passwordHint,
                title: oldpass,
                isPass: true,
                controller: controller.oldpassController),
            10.heightBox,
            customTextField(
                hint: passwordHint,
                title: newpass,
                isPass: true,
                controller: controller.newpassController),

            20.heightBox,

            //save button
            controller.isloading.value
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  )
                : SizedBox(
                    width: context.screenWidth - 40,
                    child: ourButton(
                        color: redColor,
                        onPress: () async {
                          controller.isloading(true);

                          //if img not selected
                          if (controller.profileImgPath.value.isNotEmpty) {
                            //if profile image is changed
                            await controller.uploadProfileImage();
                          } else {
                            //if img is not changed same image will remain in database and screen
                            controller.profileImageLink = data['imageUrl'];
                          }

                          //password auth:if old pass matches database
                          if (data['password'] ==
                              controller.oldpassController.text) {
                            await controller.changeAuthPassword(
                              email: data['email'],
                              password: controller.oldpassController.text,
                              newpassword: controller.newpassController.text,
                            );

                            await controller.updateProfile(
                              imgUrl: controller.profileImageLink,
                              name: controller.nameController.text,
                              password: controller.newpassController.text,
                            );
                            VxToast.show(context, msg: "Updated");
                          } else {
                            VxToast.show(context,
                                msg: "Old password is not correct!!");
                            controller.isloading(false);
                          }
                        },
                        textColor: whiteColor,
                        title: "Save"),
                  ),
          ],
        )
            .box
            .white
            .shadowSm
            .padding(EdgeInsets.all(16))
            .margin(EdgeInsets.only(top: 50, left: 12, right: 12))
            .rounded
            .make(),
      ),
    ));
  }
}
