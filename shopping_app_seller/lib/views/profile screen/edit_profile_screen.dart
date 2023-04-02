// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'dart:io';
import 'package:emart_seller/const/const.dart';
import 'package:get/get.dart';
import '../../const/images.dart';
import '../../controllers/profile_controller.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/text_style.dart';

class EditProfileScreen extends StatefulWidget {
  final String? username;
  const EditProfileScreen({Key? key, this.username}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var controller = Get.find<ProfileController>();

  @override
  void initState() {
    controller.nameController.text = widget.username!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: purpleColor,
      appBar: AppBar(
        title: boldText(text: editProfile, size: 16.0),
        actions: [
          TextButton(
            onPressed: () async {
              controller.isloading(true);

              //if img not selected
              if (controller.profileImgPath.value.isNotEmpty) {
                //if profile image is changed
                await controller.uploadProfileImage();
              } else {
                controller.profileImageLink =
                    controller.snapshotData['imageUrl'];
              }

              //password auth:if old pass matches database
              if (controller.snapshotData['password'] ==
                  controller.oldpassController.text) {
                await controller.changeAuthPassword(
                  email: controller.snapshotData['email'],
                  password: controller.oldpassController.text,
                  newpassword: controller.newpassController.text,
                );

                await controller.updateProfile(
                  imgUrl: controller.profileImageLink,
                  name: controller.nameController.text,
                  password: controller.newpassController.text,
                );
                VxToast.show(context, msg: "Updated");
              } else if (controller.oldpassController.text.isEmptyOrNull &&
                  controller.newpassController.text.isEmptyOrNull) {
                await controller.updateProfile(
                  imgUrl: controller.profileImageLink,
                  name: controller.nameController.text,
                  password: controller.snapshotData['password'],
                );
                VxToast.show(context, msg: "Updated");
              } else {
                VxToast.show(context, msg: "something went wrong");
                controller.isloading(false);
              }
            },
            child: normalText(text: save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => Column(
            children: [
              controller.snapshotData['imageUrl'] == '' &&
                      controller.profileImgPath.isEmpty
                  ? Image.asset(
                      imgProduct,
                      height: 100,
                      width: 90,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()

                  //if data isn't empty but controller path is empty show this --->
                  : controller.snapshotData['imageUrl'] != '' &&
                          controller.profileImgPath.isEmpty
                      ? Image.network(
                          controller.snapshotData['imageUrl'],
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

              // Image.asset(
              //   imgProduct,
              //   height: 100,
              //   width: 90,
              //   fit: BoxFit.cover,
              // ).box.roundedFull.clip(Clip.antiAlias).make(),

              10.heightBox,

              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: whiteColor),
                onPressed: () {
                  controller.changeImage(context);
                },
                child: normalText(text: changeImage, color: fontGrey),
              ),

              10.heightBox,
              Divider(color: whiteColor),

              //username field
              customTextfield(
                label: name,
                hint: "Atharva Joshi",
                controller: controller.nameController,
              ),

              30.heightBox,

              //change password text
              Align(
                  alignment: Alignment.centerLeft,
                  child: boldText(
                    text: "Change your password",
                  )),

              10.heightBox,

              //password field
              customTextfield(
                label: oldpass,
                hint: passwordHint,
                controller: controller.oldpassController,
              ),

              10.heightBox,

              //confirm password field
              customTextfield(
                label: confirmPass,
                hint: passwordHint,
                controller: controller.newpassController,
              )
            ],
          ),
        ),
      ),
    );
  }
}
