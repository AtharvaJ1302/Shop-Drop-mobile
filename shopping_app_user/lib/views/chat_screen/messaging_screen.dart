import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/chat_screen/chat_screen.dart';
import 'package:emart_app/widgets%20common/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: "My Messages".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllMessages(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(child: loadingIndicator(),);
          }else if(snapshot.data!.docs.isEmpty){
            return
              "No messages yet".text.color(darkFontGrey).makeCentered();
          }else{
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                        itemBuilder:(BuildContext context,int index){
                        return Card(
                          child: ListTile(
                            onTap: (){
                              Get.to(()=>ChatScreen(),
                                arguments: [
                                  data[index]['friend_name'],data[index]['toId']
                                ],
                              );
                            },
                            leading: const CircleAvatar(
                              backgroundColor: Vx.fuchsia900,
                              child: Icon(Icons.person,color: whiteColor,),
                            ),
                            title: "${data[index]['friend_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                            subtitle: "${data[index]['last_msg']}".text.make(),
                          ),
                        );
                        }
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
