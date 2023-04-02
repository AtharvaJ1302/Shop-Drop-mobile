// ignore_for_file: prefer_const_constructors, unused_local_variable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../const/const.dart';
import '../../const/firebase_const.dart';
import '../../const/images.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/profile_controller.dart';
import '../../services/store_services.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/text_style.dart';
import '../auth_screen/login_screen.dart';
import '../messages screen/messages_screen.dart';
import '../shop screen/shop_settings_screen.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: boldText(text: settings, size: 16.0),
        actions: [
          //edit profile button
          IconButton(
              onPressed: () {
                Get.to(() => EditProfileScreen(
                      username: controller.snapshotData['vendor_name'],
                    ));
              },
              icon: Icon(Icons.edit)),

          //logout button
          TextButton(
              onPressed: () async {
                await Get.find<AuthController>()
                    .signoutMethod(context: context);
                Get.offAll(() => LoginScreen());
              },
              child: normalText(text: logout)),
        ],
      ),
      body: FutureBuilder(
        future: StoreServices.getProfile(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else {
            controller.snapshotData = snapshot.data!.docs[0];

            return Column(
              children: [
                ListTile(
                  leading: controller.snapshotData['imageUrl'] == ''
                      ? Image.asset(
                          imgProduct,
                          height: 100,
                          width: 80,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      : Image.network(
                          controller.snapshotData['imageUrl'],
                          height: 100,
                          width: 80,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
                  // leading: Image.asset(imgProduct)
                  //     .box
                  //     .roundedFull
                  //     .clip(Clip.antiAlias)
                  //     .make(),
                  title: boldText(
                      text: "${controller.snapshotData['vendor_name']}"),
                  subtitle:
                      normalText(text: "${controller.snapshotData['email']}"),
                ),
                Divider(),
                10.heightBox,
                /* Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: List.generate(
                      profileButtonsTitles.length,
                      (index) => ListTile(
                        onTap: () {
                          switch (index) {
                            case 0:
                              Get.to(() => ShopSettings());
                              break;

                            case 1:
                              Get.to(() => MessagesScreen());
                              break;
                          }
                        },
                        leading: Icon(
                          profileButtonsIcons[index],
                          color: whiteColor,
                        ),
                        title: normalText(text: profileButtonsTitles[index]),
                      ),
                    ),
                  ),
                ),*/
              ],
            );
          }
        },
      ),
    );
  }
}
