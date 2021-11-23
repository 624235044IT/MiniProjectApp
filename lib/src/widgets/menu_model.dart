import 'package:FlutterApp/src/configs/app_route.dart';
import 'package:flutter/material.dart';
class Menu {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Function(BuildContext context) onTap;


  const Menu({
    this.title,
    this.icon,
    this.iconColor = Colors.grey,
    this.onTap,
  });
}

class MenuViewModel {
  MenuViewModel();


  List<Menu> get items => <Menu>[
    Menu(
      title: 'ประเภทห้องเช่า',
      //icon: Icons.person,
      //iconColor: Colors.lime,
      onTap: (context) {
        Navigator.pushNamed(context, AppRoute.infoRoute);
        //todo
      },
    ),
    Menu(
      title: 'เปรียบเทียบราคาห้องเช่า',
      //icon: Icons.map,
     //iconColor: Colors.blueGrey,
      onTap: (context) {
        Navigator.pushNamed(context, AppRoute.homeRoute);

      },
    ),
    Menu(
      title: 'แผนที่',
      //icon: Icons.map,
     //iconColor: Colors.blueGrey,
      onTap: (context) {
        Navigator.pushNamed(context, AppRoute.googleMapRoute);

      },
    ),

    //Menu(
     // title: 'ลงชื่อเข้าใช้',
      //icon: Icons.map,
      //iconColor: Colors.blueGrey,
    //  onTap: (context) {
     //   Navigator.pushNamed(context, AppRoute.loginRoute);
  //},

    //),





  ];
}