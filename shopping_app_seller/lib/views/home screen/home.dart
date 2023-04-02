// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:get/get.dart';
import '../../const/const.dart';
import '../../const/images.dart';
import '../../controllers/home_controller.dart';
import '../orders screen/orders_screen.dart';
import '../products screen/products_screen.dart';
import '../profile screen/profile_screen.dart';
import 'home_screen.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var bottomNavbar = [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: dashboard),
      BottomNavigationBarItem(
          icon: Image.asset(icProducts, color: darkGrey, width: 24),
          label: products),
      BottomNavigationBarItem(
          icon: Image.asset(icOrders, color: darkGrey, width: 24),
          label: orders),
      BottomNavigationBarItem(
          icon: Image.asset(icGeneralSettings, color: darkGrey, width: 24),
          label: settings),
    ];

    var navScreens = [
      HomeScreen(),
      ProductsScreen(),
      OrdersScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: whiteColor,
          onTap: (index) {
            controller.navIndex.value = index;
          },
          currentIndex: controller.navIndex.value,
          type: BottomNavigationBarType.fixed,
          items: bottomNavbar,
          selectedItemColor: purpleColor,
          unselectedItemColor: darkGrey,
        ),
      ),
      body: Obx(
        () => Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Expanded(
              child: navScreens.elementAt(controller.navIndex.value),
            ),
          ],
        ),
      ),
    );
  }
}
