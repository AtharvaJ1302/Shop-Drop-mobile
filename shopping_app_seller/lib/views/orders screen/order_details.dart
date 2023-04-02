// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:ffi';

import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controllers/orders_controller.dart';
import 'package:get/get.dart';
import '../../widgets/our_button.dart';
import '../../widgets/text_style.dart';
import 'components/order_place.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetails extends StatefulWidget {
  final dynamic data;
  const OrderDetails({Key? key, this.data}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  var controller = Get.find<OrdersController>();

  @override
  void initState() {
    super.initState();
    controller.getOrders(widget.data);
    controller.confirmed.value = widget.data['order_confirmed'];
    controller.ondelivery.value = widget.data['order_on_delivery'];
    controller.delivered.value = widget.data['order_delivered'];
    controller.paymentstatus.value = widget.data['payment_status'];
    controller.deliverystatus.value = widget.data['delivery_status'];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: darkGrey,
              )),
          title: boldText(text: "Order Details", color: fontGrey, size: 16.0),
        ),
        bottomNavigationBar: Visibility(
          visible: !controller.confirmed.value,
          child: SizedBox(
            height: 60,
            width: context.screenWidth,
            child: ourButton(
              color: green,
              onPress: () {
                controller.confirmed(true);
                controller.changeStatus(
                    title: "order_confirmed",
                    status: true,
                    docId: widget.data.id);
              },
              title: "Confirm Order",
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                //order status section
                Visibility(
                  visible: controller.confirmed.value,
                  child: Column(
                    children: [
                      boldText(
                          text: "Order status", color: Colors.blue, size: 16.0),

                      //order placed
                      SwitchListTile(
                        activeColor: green,
                        value: true,
                        onChanged: (value) {},
                        title: boldText(text: "Placed", color: fontGrey),
                      ),

                      //order confirmed
                      SwitchListTile(
                        activeColor: green,
                        value: controller.confirmed.value,
                        onChanged: (value) {
                          controller.confirmed.value = value;
                          controller.changeStatus(
                              title: "order_confirmed",
                              status: value,
                              docId: widget.data.id);
                        },
                        title: boldText(text: "Confirmed", color: fontGrey),
                      ),

                      //order on delivery
                      SwitchListTile(
                        activeColor: green,
                        value: controller.ondelivery.value,
                        onChanged: (value) {
                          controller.ondelivery.value = value;
                          controller.changeStatus(
                              title: "order_on_delivery",
                              status: value,
                              docId: widget.data.id);
                        },
                        title: boldText(text: "On Delivery", color: fontGrey),
                      ),

                      //order delivered
                      SwitchListTile(
                        activeColor: green,
                        value: controller.delivered.value,
                        onChanged: (value) {
                          controller.delivered.value = value;
                          controller.changeStatus(
                              title: "order_delivered",
                              status: value,
                              docId: widget.data.id);
                        },
                        title: boldText(text: "Delivered", color: fontGrey),
                      ),

                      //order payment status
                      SwitchListTile(
                        activeColor: green,
                        value: controller.paymentstatus.value,
                        onChanged: (value) {
                          controller.paymentstatus.value = value;
                          controller.changeStatus(
                              title: "payment_status",
                              status: value,
                              docId: widget.data.id);
                        },
                        title: boldText(text: "Payment Done", color: fontGrey),
                      ),

                      //order delivery status
                      SwitchListTile(
                        activeColor: green,
                        value: controller.deliverystatus.value,
                        onChanged: (value) {
                          controller.deliverystatus.value = value;
                          controller.changeStatus(
                              title: "delivery_status",
                              status: value,
                              docId: widget.data.id);
                        },
                        title: boldText(text: "Delivery Done", color: fontGrey),
                      ),
                    ],
                  )
                      .box
                      .padding(EdgeInsets.all(8))
                      .outerShadowMd
                      .border(color: lightGrey)
                      .roundedSM
                      .white
                      .make(),
                ),

                //order details section
                Column(
                  children: [
                    orderPlaceDetails(
                      d1: "${widget.data['order_code']}",
                      d2: "${widget.data['shipping_method']}",
                      title1: "Order Code",
                      title2: "Shipping Method",
                    ),
                    orderPlaceDetails(
                      d1: intl.DateFormat()
                          .add_yMd()
                          .format((widget.data['order_date'].toDate())),
                      d2: "${widget.data['payment_method']}",
                      title1: "Order Date",
                      title2: "Payment Method",
                    ),
                    // orderPlaceDetails2(
                    //   title1: "Payment Status",
                    //   showDone: "${widget.data['payment_status']..toString()}",
                    //   title2: "Delivery Status",
                    //   showDone2: "${widget.data['payment_status'].toString()}",
                    // ),
                    orderPlaceDetails(
                      d1: /*"Unpaid"*/ "${widget.data['payment_status'] == true ? "Paid" : "Unpaid"}",
                      d2: /*"Order Placed"*/ "${widget.data['delivery_status'] == true ? "Delivered" : "Order Placed"}",
                      title1: "Payment Status",
                      title2: "Delivery Status",
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //"Shipping Address".text.fontFamily(semibold).make(),
                              boldText(
                                  text: "Shipping Address", color: purpleColor),
                              "name: "
                                      "${widget.data['order_by_name']}"
                                  .text
                                  .make(),
                              "email: "
                                      "${widget.data['order_by_email']}"
                                  .text
                                  .make(),
                              "address: "
                                      "${widget.data['order_by_address']}"
                                  .text
                                  .make(),
                              "city: "
                                      "${widget.data['order_by_city']}"
                                  .text
                                  .make(),
                              "state: "
                                      "${widget.data['order_by_state']}"
                                  .text
                                  .make(),
                              "pin-code: "
                                      "${widget.data['order_by_postalcode']}"
                                  .text
                                  .make(),
                              "contact: "
                                      "${widget.data['order_by_phone']}"
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
                                boldText(
                                    text: "total amount", color: purpleColor),
                                boldText(
                                    text: "${widget.data['total_amount']}",
                                    color: red,
                                    size: 16.0),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
                    .box
                    .outerShadowMd
                    .border(color: lightGrey)
                    .roundedSM
                    .white
                    .make(),
                10.heightBox,
                const Divider(
                  thickness: 2,
                ),
                10.heightBox,
                boldText(text: "Ordered Products", color: fontGrey, size: 16.0),
                10.heightBox,
                ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(controller.orders.length, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        orderPlaceDetails(
                          title1: "${controller.orders[index]['title']}",
                          title2: "${controller.orders[index]['tprice']}",
                          d1: "${controller.orders[index]['qty']}x ",
                          d2: "Refundable",
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            width: 30,
                            height: 20,
                            color: Color(controller.orders[index]['colors']),
                          ),
                        ),
                        Divider(
                          thickness: 2,
                        ),
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
            ),
          ),
        ),
      ),
    );
  }
}
