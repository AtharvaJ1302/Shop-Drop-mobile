// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controllers/home_controller.dart';
import 'package:emart_app/views/cart%20screen/cart_screen.dart';
import 'package:emart_app/views/category%20screen/item_details.dart';
import 'package:emart_app/views/homescreen/search_screen.dart';
import 'package:emart_app/views/profile%20screen/profile_screen.dart';
import 'package:emart_app/views/top%20products/top_products_screen.dart';
import 'package:emart_app/widgets%20common/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets common/home_buttons.dart';
import 'components/featured_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _launchWhatsapp() async {
      //var whatsapp = "+919370612830";
      var whatsappAndroid = Uri.parse(
          "https://instagram.com/atharva_joshi1302?igshid=YmMyMTA2M2Y=");
      if (await canLaunchUrl(whatsappAndroid)) {
        await launchUrl(whatsappAndroid);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Instagram is not installed on the device"),
          ),
        );
      }
    }

    _launchYT() async {
      //var whatsapp = "+919370612830";
      var YT = Uri.parse("https://youtu.be/a25_gGnmJAw");
      if (await canLaunchUrl(YT)) {
        await launchUrl(YT);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Youtube is not installed on the device"),
          ),
        );
      }
    }

    var controller = Get.find<HomeController>();
    return Container(
      padding: EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
          child: Column(
        children: [
          //search bar
          Container(
            alignment: Alignment.center,
            height: 60,
            color: lightGrey,
            child: TextFormField(
              controller: controller.searchController,
              decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: Icon(Icons.search).onTap(() {
                  if (controller.searchController.text.isNotEmptyAndNotNull) {
                    Get.to(() => SearchScreen(
                          title: controller.searchController.text,
                        ));
                  }
                }),
                filled: true,
                fillColor: whiteColor,
                hintText: searchAnything,
                hintStyle: TextStyle(color: textfieldGrey),
              ),
            ).box.outerShadowSm.make(),
          ),
          10.heightBox,
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  //buttons below search bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        2,
                        (index) => homeButtons(
                              height: context.screenHeight * 0.15,
                              width: context.screenWidth / 2.5,
                              // icon: index == 0 ? icTodaysDeal : icFlashDeal,
                              // title: index == 0 ? todayDeal : flashSale,
                              icon: index == 0 ? icInsta : icYT,
                              title: index == 0 ? insta : youtube,
                            ).onTap(() {
                              if (index == 0) {
                                _launchWhatsapp();
                              } else {
                                _launchYT();
                              }
                            })),
                  ),
                  20.heightBox,

                  //1st image Slider
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 120,
                      enlargeCenterPage: true,
                      itemCount: slidersList1.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          slidersList1[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      }),

                  20.heightBox,

                  //category buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      2,
                      (index) => homeButtons(
                        height: context.screenHeight * 0.15,
                        width: context.screenWidth / 3.5,
                        icon: index == 0
                            ? icTopCategories
                            /*: index == 1
                                ? icBrands*/
                            : icTopSeller,
                        title: index == 0
                            ? topCategories
                            // : index == 1
                            //     ? brand
                            : topSellers,
                      ).onTap(() {
                        if (index == 0) {
                          Get.to(TopProducts());
                        }
                      }),
                    ),
                  ),

                  20.heightBox,

                  //featured category text
                  /* Align(
                    alignment: Alignment.centerLeft,
                    child: featuredCategories.text
                        .color(darkFontGrey)
                        .size(18)
                        .fontFamily(semibold)
                        .make(),
                  ),

                  20.heightBox,

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        3,
                        (index) => Column(
                          children: [
                            featuredButton(
                                icon: featuredImages1[index],
                                title: featuredTitles1[index]),
                            10.heightBox,
                            featuredButton(
                                icon: featuredImages2[index],
                                title: featuredTitles2[index]),
                          ],
                        ),
                      ).toList(),
                    ),
                  ),*/

                  20.heightBox,

                  //featured products section
                  Container(
                    padding: EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: BoxDecoration(color: redColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        featuredProduct.text.white
                            .fontFamily(bold)
                            .size(18)
                            .make(),
                        10.heightBox,
                        SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: FutureBuilder(
                              future: FirestoreServices.getFeaturedProducts(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: loadingIndicator(),
                                  );
                                } else if (snapshot.data!.docs.isEmpty) {
                                  return "No Featured Products"
                                      .text
                                      .white
                                      .makeCentered();
                                } else {
                                  var featuredData = snapshot.data!.docs;
                                  return Row(
                                    children: List.generate(
                                        featuredData.length,
                                        (index) => Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Image.network(
                                                  featuredData[index]
                                                      ['p_images'][0],
                                                  width: 150,
                                                  height: 130,
                                                  fit: BoxFit.cover,
                                                ),
                                                10.heightBox,
                                                "${featuredData[index]['p_name']}"
                                                    .text
                                                    .fontFamily(semibold)
                                                    .color(darkFontGrey)
                                                    .make(),
                                                10.heightBox,
                                                "${featuredData[index]['p_price']}"
                                                    .numCurrency
                                                    .text
                                                    .color(redColor)
                                                    .fontFamily(bold)
                                                    .size(16)
                                                    .make(),
                                              ],
                                            )
                                                .box
                                                .white
                                                .roundedSM
                                                .margin(EdgeInsets.symmetric(
                                                    horizontal: 4))
                                                .padding(EdgeInsets.all(8))
                                                .make()
                                                .onTap(() {
                                              Get.to(() => ItemDetails(
                                                    title:
                                                        "${featuredData[index]['p_name']}",
                                                    data: featuredData[index],
                                                  ));
                                            })),
                                  );
                                }
                              },
                            )),
                      ],
                    ),
                  ),

                  20.heightBox,

                  //2nd image slider
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 120,
                      enlargeCenterPage: true,
                      itemCount: slidersList2.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          slidersList2[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      }),

                  20.heightBox,

                  //all products section
                  Align(
                    alignment: Alignment.centerLeft,
                    child: allproducts.text
                        .fontFamily(bold)
                        .color(darkFontGrey)
                        .size(18)
                        .make(),
                  ),
                  20.heightBox,
                  StreamBuilder(
                    stream: FirestoreServices.allProducts(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return loadingIndicator();
                      } else {
                        var allproductsdata = snapshot.data!.docs;
                        return GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: allproductsdata.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8,
                                    mainAxisExtent: 300),
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    allproductsdata[index]['p_images'][0],
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                  Spacer(),
                                  "${allproductsdata[index]['p_name']}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  10.heightBox,
                                  "${allproductsdata[index]['p_price']}"
                                      .text
                                      .color(redColor)
                                      .fontFamily(bold)
                                      .size(16)
                                      .make(),
                                ],
                              )
                                  .box
                                  .white
                                  .roundedSM
                                  .margin(EdgeInsets.symmetric(horizontal: 4))
                                  .padding(EdgeInsets.all(12))
                                  .make()
                                  .onTap(() {
                                Get.to(() => ItemDetails(
                                      title:
                                          "${allproductsdata[index]['p_name']}",
                                      data: allproductsdata[index],
                                    ));
                              });
                            });
                      }
                    },
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
