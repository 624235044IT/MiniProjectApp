import 'package:FlutterApp/src/configs/app_route.dart';
import 'package:FlutterApp/src/pages/login/login_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: AppRoute().getAll,
      theme: ThemeData(primaryColor: Colors.blueGrey),
      home: LoginPage(),
      //home: Homepage(),
     // home: FutureBuilder(
       // future: SharedPreferences.getInstance(),
       // builder: (context, snapshot) {
         // if(!snapshot.hasData){
           // return Container(color: Colors.white,);
          //}
        //  final token = snapshot.data.getString(AppSetting.userNameSetting ?? '');
        //  if(token != null){
          //  return Homepage();
         // }else
           // return LoginPage();
        //},
      //),

    );
  }
} //end class
