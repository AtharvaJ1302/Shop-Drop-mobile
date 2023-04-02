// ignore_for_file: prefer_const_constructors

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/orders_screen/components/order_status.dart';
import 'package:emart_app/widgets%20common/order_place_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class OrdersDetails extends StatelessWidget {
  final dynamic data;
  const OrdersDetails({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: "Order Details"
            .text
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Column(
                children: [
                  orderStatus(
                    color: redColor,
                    icon: Icons.done,
                    title: "Placed",
                    showDone: data['order_placed'],
                  ),
                  orderStatus(
                    color: Colors.blue,
                    icon: Icons.thumb_up,
                    title: "Confirmed",
                    showDone: data['order_confirmed'],
                  ),
                  orderStatus(
                    color: Colors.greenAccent,
                    icon: Icons.directions_bike,
                    title: " On Delivery",
                    showDone: data['order_on_delivery'],
                  ),
                  orderStatus(
                    color: Colors.purpleAccent,
                    icon: Icons.done_all,
                    title: "Delivered",
                    showDone: data['order_delivered'],
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  10.heightBox,
                  Column(
                    children: [
                      orderPlaceDetails(
                        d1: data['order_code'],
                        d2: data['shipping_method'],
                        title1: "Order Code",
                        title2: "Shipping Method",
                      ),
                      orderPlaceDetails(
                        d1: intl.DateFormat()
                            .add_yMd()
                            .format((data['order_date'].toDate())),
                        d2: data['payment_method'],
                        title1: "Order Date",
                        title2: "Payment Method",
                      ),
                      orderPlaceDetails2(
                          title1: "Payment Status",
                          showDone: data['payment_status'],
                          title2: "Delivery Status",
                          showDone2: data['delivery_status']),

                      // orderPlaceDetails(
                      //   d1: "Unpaid",
                      //   d2: "Confirmed",
                      //   title1: "Payment Status",
                      //   title2: "Delivery Status",
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Shipping Address"
                                    .text
                                    .fontFamily(semibold)
                                    .make(),
                                "name: " "${data['order_by_name']}".text.make(),
                                "email: " "${data['order_by_email']}"
                                    .text
                                    .make(),
                                "address: " "${data['order_by_address']}"
                                    .text
                                    .make(),
                                "city: " "${data['order_by_city']}".text.make(),
                                "state: " "${data['order_by_state']}"
                                    .text
                                    .make(),
                                "pin-code: " "${data['order_by_postalcode']}"
                                    .text
                                    .make(),
                                "contact: " "${data['order_by_phone']}"
                                    .text
                                    .make(),
                              ],
                            ),
                            SizedBox(
                              width: 110,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "Total Amount"
                                      .text
                                      .fontFamily(semibold)
                                      .make(),
                                  '${data['total_amount']}'
                                      .numCurrency
                                      .text
                                      .color(redColor)
                                      .fontFamily(bold)
                                      .make(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ).box.outerShadowMd.white.make(),
                  10.heightBox,
                  const Divider(
                    thickness: 2,
                  ),
                  10.heightBox,
                  "Ordered Product"
                      .text
                      .size(20)
                      .color(darkFontGrey)
                      .fontFamily(semibold)
                      .makeCentered(),
                  10.heightBox,
                  ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(data['orders'].length, (index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          orderPlaceDetails(
                            title1: data['orders'][index]['title'],
                            title2: data['orders'][index]['tprice'],
                            d1: "${data['orders'][index]['qty']}x ",
                            d2: "Refundable",
                          ),
                          /*Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                              width: 30,
                              height: 20,
                              color: Color(data['orders'][index]['colors']),
                            ),
                          ),*/
                          /*Divider(
                            thickness: 2,
                          ),*/
                        ],
                      );
                    }).toList(),
                  )
                      .box
                      .outerShadowMd
                      .white
                      .margin(EdgeInsets.only(bottom: 4))
                      .make(),
                  20.heightBox,
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
