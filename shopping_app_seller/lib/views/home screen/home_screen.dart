// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/firebase_const.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/views/products%20screen/product_details.dart';
import 'package:emart_seller/widgets/loading_indicator.dart';
import 'package:get/get.dart';

import '../../const/const.dart';
import 'package:intl/intl.dart' as intl;

import '../../const/images.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/dashboard_button.dart';
import '../../widgets/text_style.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: appbarWidget(dashboard),
      body: StreamBuilder(
        stream: StoreServices.getProducts(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else {
            var data = snapshot.data!.docs;
            data = data.sortedBy((a, b) =>
                b['p_wishlist'].length.compareTo(a['p_wishlist'].length));
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //products and order button row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      dashboardButton(context,
                          title: products,
                          count: "${data.length}",
                          icon: icProducts),
                      dashboardButton(context,
                          title: orders, count: "15", icon: icOrders),
                    ],
                  ),

                  10.heightBox,

                  //products and order button row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      dashboardButton(context,
                          title: rating, count: "55", icon: icStar),
                      dashboardButton(context,
                          title: totalSales, count: "15", icon: icOrders),
                    ],
                  ),

                  10.heightBox,
                  Divider(),
                  10.heightBox,
                  boldText(text: popular, color: fontGrey, size: 16.0),
                  20.heightBox,

                  Expanded(
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                          data.length,
                          (index) => data[index]['p_wishlist'].length == 0
                              ? SizedBox()
                              : ListTile(
                                  onTap: () {
                                    Get.to(() => ProductDetails(
                                          data: data[index],
                                        ));
                                  },
                                  leading: Image.network(
                                    data[index]['p_images'][0],
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  title: boldText(
                                      text: "${data[index]['p_name']}",
                                      color: fontGrey),
                                  subtitle: normalText(
                                      text: "${data[index]['p_price']}",
                                      color: darkGrey),
                                )),
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       //products and order button row
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
      //         children: [
      //           dashboardButton(context,
      //               title: products, count: "55", icon: icProducts),
      //           dashboardButton(context,
      //               title: orders, count: "15", icon: icOrders),
      //         ],
      //       ),

      //       10.heightBox,

      //       //products and order button row
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
      //         children: [
      //           dashboardButton(context,
      //               title: rating, count: "55", icon: icStar),
      //           dashboardButton(context,
      //               title: totalSales, count: "15", icon: icOrders),
      //         ],
      //       ),

      //       10.heightBox,
      //       Divider(),
      //       10.heightBox,
      //       boldText(text: popular, color: fontGrey, size: 16.0),
      //       20.heightBox,

      //       Expanded(
      //         child: ListView(
      //           physics: BouncingScrollPhysics(),
      //           shrinkWrap: true,
      //           children: List.generate(
      //               3,
      //               (index) => ListTile(
      //                     onTap: () {},
      //                     leading: Image.asset(
      //                       imgProduct,
      //                       width: 100,
      //                       height: 100,
      //                       fit: BoxFit.cover,
      //                     ),
      //                     title:
      //                         boldText(text: "Product title", color: fontGrey),
      //                     subtitle: normalText(text: "\$25.0", color: darkGrey),
      //                   )),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
