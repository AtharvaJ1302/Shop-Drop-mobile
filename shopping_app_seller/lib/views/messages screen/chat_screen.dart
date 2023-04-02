// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../const/firebase_const.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/text_style.dart';
import 'components/chat_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

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
        title: boldText(text: chats, size: 16.0, color: fontGrey),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 20,
                itemBuilder: ((context, index) {
                  return chatBubble();
                }),
              ),
            ),
            10.heightBox,
            SizedBox(
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          isDense: true,
                          hintText: "enter message",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: purpleColor,
                          )),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: purpleColor,
                          )),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.send,
                          color: purpleColor,
                        ))
                  ],
                ) //.box.padding(const EdgeInsets.all(12)).make(),
                ),
          ],
        ),
      ),
    );
  }
}
