import 'package:FlutterApp/src/configs/app_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          title: Text('ประเภทห้องเช่า'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, AppRoute.condoRoute);
                },
                child:  Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage('assets/images/hotel.png'),
                        scale: 1,alignment: Alignment.topLeft),
                  ),

                  child: Row(
                    children: [
                      Expanded(
                        child: Text('คอนโด',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                        ),
                      )

                    ],
                  ),
                ),),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, AppRoute.apartmentRoute);
                },
                child:  Container(
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                        image: AssetImage('assets/images/h3.png'),
                        scale: 1,alignment: Alignment.topLeft),
                  ),

                  child: Row(
                    children: [
                      Expanded(
                        child: Text('อพาร์ทเมนท์',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                        ),
                      )

                    ],
                  ),
                ),),

              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, AppRoute.mantionRoute);
                },
                child:  Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage('assets/images/h1.png'),
                        scale:1,alignment: Alignment.topLeft),
                  ),

                  child: Row(
                    children: [
                      Expanded(
                        child: Text('แมนชั่น',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      )

                    ],
                  ),
                ),),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, AppRoute.dormitoryRoute);
                },
                child:  Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage('assets/images/h4.png'),
                        scale: 1,alignment: Alignment.topLeft),
                  ),

                  child: Row(
                    children: [
                      Expanded(
                        child: Text('หอพัก',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      )

                    ],
                  ),
                ),),
            ],
          ),
        ));
  }
}//ประเภทห้องเช่า
