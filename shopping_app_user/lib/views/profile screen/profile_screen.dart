// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controllers/auth_controller.dart';
import 'package:emart_app/controllers/profile_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/chat_screen/messaging_screen.dart';
import 'package:emart_app/views/orders_screen/orders_screen.dart';
import 'package:emart_app/views/profile%20screen/components/details_card.dart';
import 'package:emart_app/views/profile%20screen/edit_profile_screen.dart';
import 'package:emart_app/views/wishlist%20screen/wishlist_screen.dart';
import 'package:emart_app/widgets%20common/bg_widget.dart';
import 'package:emart_app/widgets%20common/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts/firebase_const.dart';
import '../auth_screen/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return bgWidget(
        child: Scaffold(
            // backgroundColor: redColor,
            body: StreamBuilder(
      stream: FirestoreServices.getUser(currentUser!.uid),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(redColor),
            ),
          );
        } else {
          var data = snapshot.data!.docs[0];

          return SafeArea(
            child: Column(
              children: [
                //edit button
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.edit,
                      color: whiteColor,
                    ),
                  ).onTap(() {
                    controller.nameController.text = data['name'];

                    Get.to(() => EditProfileScreen(
                          data: data,
                        ));
                  }),
                ),

                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 5.0),
                  child: Row(
                    //user detail
                    children: [
                      data['imageUrl'] == ''
                          ? Image.asset(
                              myProfileImg,
                              height: 100,
                              width: 80,
                              fit: BoxFit.cover,
                            ).box.roundedFull.clip(Clip.antiAlias).make()
                          : Image.network(
                              data['imageUrl'],
                              height: 100,
                              width: 80,
                              fit: BoxFit.cover,
                            ).box.roundedFull.clip(Clip.antiAlias).make(),

                      10.widthBox,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // "Atharva Joshi".text.fontFamily(semibold).white.make(),
                            "${data['name']}"
                                .text
                                .fontFamily(semibold)
                                .white
                                .make(),
                            // "atharvaj1302@gmail.com".text.white.make(),
                            "${data['email']}".text.white.make(),
                          ],
                        ),
                      ),

                      //logout button
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: BorderSide(
                            color: whiteColor,
                          )),
                          onPressed: () async {
                            await Get.put(AuthController())
                                .signoutMethod(context: context);
                            Get.offAll(() => LoginScreen());
                          },
                          child: logout.text.fontFamily(semibold).white.make())
                    ],
                  ),
                ),

                FutureBuilder(
                    future: FirestoreServices.getCount(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: loadingIndicator());
                      } else {
                        var countData = snapshot.data;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            detailsCard(
                                count: countData[0].toString(),
                                title: "in cart",
                                width: context.screenWidth / 3.5),
                            detailsCard(
                                count: countData[1].toString(),
                                title: "in wishlist",
                                width: context.screenWidth / 3.5),
                            detailsCard(
                                count: countData[2].toString(),
                                title: "your orders",
                                width: context.screenWidth / 3.5),
                          ],
                        );
                      }
                    }),

                //buttons
                ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: lightGrey,
                    );
                  },
                  itemCount: profileButtonsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () {
                        switch (index) {
                          case 0:
                            Get.to(() => OrdersScreen());
                            break;
                          case 1:
                            Get.to(() => WishlistScreen());
                            break;
                          case 2:
                            Get.to(() => MessagesScreen());
                            break;
                        }
                      },
                      leading: Image.asset(
                        profileButtonsIcon[index],
                        width: 22,
                        color: darkFontGrey,
                      ),
                      title: profileButtonsList[index]
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                    );
                  },
                )
                    .box
                    .white
                    .shadowSm
                    .padding(EdgeInsets.symmetric(horizontal: 16))
                    .rounded
                    .margin(EdgeInsets.all(12))
                    .make()
                    .box
                    .color(redColor)
                    .make(),
              ],
            ),
          );
        }
      },
    )));
  }
}
