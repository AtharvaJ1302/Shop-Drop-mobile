// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/controllers/orders_controller.dart';
import 'package:emart_seller/widgets/loading_indicator.dart';
import 'package:intl/intl.dart' as intl;
import '../../const/const.dart';
import 'package:get/get.dart';
import '../../const/firebase_const.dart';
import '../../services/store_services.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/text_style.dart';
import 'order_details.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OrdersController());

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: appbarWidget(orders),
      body: StreamBuilder(
          stream: StoreServices.getOrders(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else {
              var data = snapshot.data!.docs;

              return Padding(
                padding: EdgeInsets.all(8),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(data.length, (index) {
                      var time = data[index]['order_date'].toDate();

                      return ListTile(
                        onTap: () {
                          Get.to(() => OrderDetails(
                                data: data[index],
                              ));
                        },
                        tileColor: textfieldGrey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),

                        //order code
                        title: boldText(
                          text: "${data[index]['order_code']}",
                          color: purpleColor,
                        ),
                        subtitle: Column(
                          children: [
                            //date of order
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  color: fontGrey,
                                ),
                                10.widthBox,
                                boldText(
                                    text: intl.DateFormat()
                                        .add_yMd()
                                        .format(time),
                                    color: Colors.black),
                              ],
                            ),

                            //payment status
                            Row(
                              children: [
                                Icon(
                                  Icons.payment,
                                  color: fontGrey,
                                ),
                                10.widthBox,
                                boldText(
                                    text: data[index]['payment_status'] == true
                                        ? paid
                                        : unpaid,
                                    color: red),
                              ],
                            ),
                          ],
                        ),
                        trailing: boldText(
                            text: "${data[index]['total_amount']}",
                            color: purpleColor,
                            size: 16.0),
                      ).box.margin(EdgeInsets.only(bottom: 5)).make();
                    }),
                  ),
                ),
              );
            }
          }),
    );
  }
}
