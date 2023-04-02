// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/const/firebase_const.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/widgets/loading_indicator.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import '../../widgets/text_style.dart';
import 'chat_screen.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: darkGrey,
            ),
          ),
          title: boldText(text: messages, size: 16.0, color: fontGrey),
        ),
        body: StreamBuilder(
            stream: StoreServices.getMessages(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return loadingIndicator();
              } else {
                var data = snapshot.data!.docs;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: List.generate(data.length, (index) {
                        var t = data[index]['created_on'] == null
                            ? DateTime.now()
                            : data[index]['created_on'].toDate();
                        var time = intl.DateFormat("h:mma").format(t);
                        return ListTile(
                          onTap: () {
                            Get.to(
                              () => ChatScreen(),
                              //new
                              arguments: [
                                data[index]['toId'],
                                data[index]['friend_name'],
                              ],
                            );
                          },
                          leading: CircleAvatar(
                            backgroundColor: purpleColor,
                            child: Icon(
                              Icons.person,
                              color: whiteColor,
                            ),
                          ),
                          title: boldText(
                              text: "${data[index]['sender_name']}",
                              color: fontGrey),
                          subtitle: normalText(
                              text: "${data[index]['last_msg']}",
                              color: darkGrey),
                          trailing: normalText(text: time, color: darkGrey),
                        );
                      }),
                    ),
                  ),
                );
              }
            }));
  }
}
