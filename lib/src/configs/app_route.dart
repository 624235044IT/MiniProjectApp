import 'package:FlutterApp/src/map/google_map.dart';
import 'package:FlutterApp/src/pages/apartment/apartment_detail.dart';
import 'package:FlutterApp/src/pages/apartment/apartment_page.dart';
import 'package:FlutterApp/src/pages/condo/condo_detail.dart';
import 'package:FlutterApp/src/pages/condo/condo_page.dart';
import 'package:FlutterApp/src/pages/dormitory/dormitory_detail.dart';
import 'package:FlutterApp/src/pages/dormitory/dormitory_page.dart';
import 'package:FlutterApp/src/pages/home/home_page.dart';
import 'package:FlutterApp/src/pages/login/register.dart';
import 'package:FlutterApp/src/pages/manange_resluf.dart';
import 'package:FlutterApp/src/pages/mantion/mantion_detail.dart';
import 'package:FlutterApp/src/pages/mantion/mantion_page.dart';


import 'package:FlutterApp/src/pages/pages.dart';
import 'package:flutter/material.dart';

class AppRoute{
  static const homeRoute = "home";
  static const infoRoute = "info";
  static const loginRoute = "login";
  static const RegisterScreenRout = "register";
  static const condoRoute = "condo";
  static const apartmentRoute = "apartment";
  static const mantionRoute = "mantion";
  static const dormitoryRoute = "dormitory";
  static const CondoDetailRoute = "condoDetail";
  static const ApartmentDetailRoute = "apartmentDetail";
  static const MantionDetailRoute = "mantionDetail";
  static const DormitoryDetailRoute = "dormitoryDetail";
  //static const condoManagRoute = "condoManag";
  static const ManageRoute = "Manage";
  static const googleMapRoute = "googlemap";
  //static const videoRoute = "video";





  final _route = <String,WidgetBuilder>{
    homeRoute:(context) => Homepage(),
    infoRoute:(context) => InfoPage(),
    googleMapRoute:(context) => GoogleMapPage(),
    loginRoute:(context) => LoginPage(),
    RegisterScreenRout:(context) => RegisterPage(),
    condoRoute:(context) => CondoPage(),
    ManageRoute:(context) => ManagementPage(),
    CondoDetailRoute:(context) => CondoDetailPage(),
    apartmentRoute:(context) => ApmPage(),
    ApartmentDetailRoute:(context) => ApartmentDetailPage(),
    mantionRoute:(context) => MantionPage(),
    MantionDetailRoute:(context) => MntDetailPage(),
    dormitoryRoute:(context) => DrmPage(),
    DormitoryDetailRoute:(context) => DrmDetailPage(),



  };



  get getAll => _route;
}//end class