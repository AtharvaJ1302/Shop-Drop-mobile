// ignore_for_file: prefer_const_constructors, avoid_print,
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/views/chat_screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets common/our_button.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetails({Key? key, required this.title, this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
//redirect to whatsapp
    _launchWhatsapp() async {
      var whatsapp = "+919370612830";
      var whatsappAndroid =
          Uri.parse("whatsapp://send?phone=$whatsapp&text=hello");
      if (await canLaunchUrl(whatsappAndroid)) {
        await launchUrl(whatsappAndroid);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("WhatsApp is not installed on the device"),
          ),
        );
      }
    }

    //var controller = Get.find<ProductController>();
    var controller = Get.put(ProductController());

    print(Colors.red.value);
    print(Colors.greenAccent.value);

    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                controller.resetValues();
                Get.back();
              },
              icon: Icon(Icons.arrow_back)),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
            //share button
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.share,
                )),

            //wishlist button
            Obx(
              () => IconButton(
                  onPressed: () {
                    if (controller.isFav.value) {
                      controller.removeFromWishlist(data.id, context);
                      // controller.isFav(false);
                    } else {
                      controller.addToWishlist(data.id, context);
                      // controller.isFav(true);
                    }
                  },
                  icon: Icon(
                    Icons.favorite_outlined,
                    color: controller.isFav.value ? redColor : darkFontGrey,
                  )),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                  padding: EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //image slider

                          VxSwiper.builder(
                              autoPlay: true,
                              height: 350,
                              aspectRatio: 16 / 9,
                              viewportFraction: 1.0,
                              itemCount: data['p_images'].length,
                              itemBuilder: (context, index) {
                                return Image.network(
                                  data['p_images'][index],
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                );
                              }),

                          10.heightBox,
                          title!.text
                              .size(16)
                              .color(darkFontGrey)
                              .fontFamily(bold)
                              .make(),
                          10.heightBox,

                          //rating
                          VxRating(
                            isSelectable: false,
                            value: double.parse(data['p_rating']),
                            onRatingUpdate: (value) {},
                            normalColor: textfieldGrey,
                            selectionColor: golden,
                            size: 25,
                            count: 5,
                            maxRating: 5,
                          ),

                          10.heightBox,
                          "${data['p_price']}"
                              .numCurrency
                              .text
                              .color(redColor)
                              .fontFamily(bold)
                              .size(18)
                              .make(),

                          10.heightBox,

                          //seller name
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "Seller"
                                      .text
                                      .white
                                      .fontFamily(semibold)
                                      .make(),
                                  5.heightBox,
                                  "${data['p_seller']}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make()
                                ],
                              )),

                              //chat button
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  //Icons.message_rounded,
                                  // color: darkFontGrey,
                                  Icons.whatsapp,
                                  color: Colors.green,
                                ),
                              ).onTap(() {
                                _launchWhatsapp();

                                // Get.to(
                                //   () => ChatScreen(),
                                //   arguments: [
                                //     data['p_seller'],
                                //     data['vendor_id']
                                //   ],
                                // );
                              })
                            ],
                          )
                              .box
                              .height(70)
                              .padding(EdgeInsets.symmetric(horizontal: 16))
                              .color(textfieldGrey)
                              .make(),

                          20.heightBox,

                          //colors section
                          Obx(
                            () => Column(
                              children: [
                                /* Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: "Color: "
                                          .text
                                          .color(textfieldGrey)
                                          .make(),
                                    ),
                                    Row(
                                      children: List.generate(
                                          data['p_colors'].length,
                                          (index) => Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  VxBox()
                                                      .margin(
                                                          EdgeInsets.symmetric(
                                                              horizontal: 6))
                                                      .color(Color(
                                                              data['p_colors']
                                                                  [index])
                                                          .withOpacity(1.0))
                                                      .size(40, 40)
                                                      .roundedFull
                                                      .make()
                                                      .onTap(() {
                                                    controller.changeColorIndex(
                                                        index);
                                                  }),
                                                  Visibility(
                                                    visible: index ==
                                                        controller
                                                            .colorIndex.value,
                                                    child: Icon(
                                                      Icons.done,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                ],
                                              )),
                                    )
                                  ],
                                ).box.padding(EdgeInsets.all(8)).make(),*/

                                //quantity section
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: "Quantity: "
                                          .text
                                          .color(textfieldGrey)
                                          .make(),
                                    ),
                                    Obx(
                                      () => Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                controller.decreaseQuantity();
                                                controller.calculateTotalPrice(
                                                    int.parse(data['p_price']));
                                              },
                                              icon: Icon(Icons.remove)),
                                          controller.quantity.value.text
                                              .size(16)
                                              .color(darkFontGrey)
                                              .fontFamily(bold)
                                              .make(),
                                          IconButton(
                                              onPressed: () {
                                                controller.increaseQuantity(
                                                  int.parse(data['p_quantity']),
                                                );
                                                controller.calculateTotalPrice(
                                                    int.parse(data['p_price']));
                                              },
                                              icon: Icon(Icons.add)),
                                          10.widthBox,
                                          "(${data['p_quantity']} available)"
                                              .text
                                              .color(textfieldGrey)
                                              .make(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ).box.padding(EdgeInsets.all(8)).make(),

                                //total row
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: "Total: "
                                          .text
                                          .color(textfieldGrey)
                                          .make(),
                                    ),
                                    "${controller.totalPrice.value}"
                                        .numCurrency
                                        .text
                                        .color(redColor)
                                        .size(16)
                                        .fontFamily(bold)
                                        .make(),
                                  ],
                                ).box.padding(EdgeInsets.all(8)).make(),
                              ],
                            ).box.white.shadowSm.make(),
                          ),

                          //description
                          10.heightBox,
                          "Description"
                              .text
                              .color(darkFontGrey)
                              .fontFamily(semibold)
                              .make(),
                          10.heightBox,
                          "${data['p_desc']}".text.color(darkFontGrey).make(),

                          10.heightBox,

                          //buttons section
                          /*
                          ListView(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: List.generate(
                                itemDetailButtonList.length,
                                (index) => ListTile(
                                      title: itemDetailButtonList[index]
                                          .text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .make(),
                                      trailing: Icon(Icons.arrow_forward),
                                    )),
                          ),
*/
                          20.heightBox,
                          //products you may like
                          // productsyoumaylike.text
                          //     .fontFamily(bold)
                          //     .size(16)
                          //     .color(darkFontGrey)
                          //     .make(),
                          // 10.heightBox,
                          // SingleChildScrollView(
                          //   scrollDirection: Axis.horizontal,
                          //   child: Row(
                          //     children: List.generate(
                          //         6,
                          //         (index) => Column(
                          //               crossAxisAlignment:
                          //                   CrossAxisAlignment.start,
                          //               children: [
                          //                 Image.asset(
                          //                   imgP1,
                          //                   width: 150,
                          //                   fit: BoxFit.cover,
                          //                 ),
                          //                 10.heightBox,
                          //                 "Laptop 4GB/64GB"
                          //                     .text
                          //                     .fontFamily(semibold)
                          //                     .color(darkFontGrey)
                          //                     .make(),
                          //                 10.heightBox,
                          //                 "\$600"
                          //                     .text
                          //                     .color(redColor)
                          //                     .fontFamily(bold)
                          //                     .size(16)
                          //                     .make(),
                          //               ],
                          //             )
                          //                 .box
                          //                 .white
                          //                 .roundedSM
                          //                 .margin(EdgeInsets.symmetric(
                          //                     horizontal: 4))
                          //                 .padding(EdgeInsets.all(8))
                          //                 .make()),
                          //   ),
                          // ),
                        ]),
                  )),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ourButton(
                  color: redColor,
                  onPress: () {
                    if (controller.quantity.value == 0) {
                      VxToast.show(context,
                          msg: "Choose at-least one product to add to cart");
                    } else {
                      controller.addToCart(
                        color: data['p_colors'][controller.colorIndex.value],
                        context: context,
                        vendorId: data['vendor_id'],
                        img: data['p_images'][0],
                        qty: controller.quantity.value,
                        sellername: data['p_seller'],
                        title: data['p_name'],
                        tprice: controller.totalPrice.value,
                      );
                      VxToast.show(context, msg: "Added to Cart");
                    }
                  },
                  textColor: whiteColor,
                  title: "Add To Cart"),
            )
          ],
        ),
      ),
    );
  }
}
