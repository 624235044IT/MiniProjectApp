import 'package:FlutterApp/src/configs/api.dart';
import 'package:FlutterApp/src/model/apartment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ApartmentDetailPage extends StatefulWidget {
  @override
  _ApartmentDetailPageState createState() => _ApartmentDetailPageState();
}

class _ApartmentDetailPageState extends State<ApartmentDetailPage> {
  Apartment _apartmentModel;
  @override
  void initState() {
    _apartmentModel = Apartment();
    super.initState();
  }

  Widget build(BuildContext context) {
    Object arguments = ModalRoute.of(context).settings.arguments;
    if (arguments is Apartment) {
      _apartmentModel = arguments;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('อาพาร์ทเม้นท์'),
      ),
      body: SingleChildScrollView(
        child: Card(
          color: Colors.white,
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            children: [
              SizedBox(
                width: 300,
                height: 300,
                child: Image.network(
                    API.APARTMENT_IMAGE + _apartmentModel.apartmentImg),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 150, 10),
                child: Text('รายละเอียดเพิ่มเติม', style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,),

                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 80, 30),
                child: Text(_apartmentModel.apartmentDetail,textAlign: TextAlign.start,),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 160, 0),
                child: Text(
                  'คะแนนความชอบใจ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                child: Center(
                  child: RatingBar.builder(
                    minRating: 1,
                    itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
                    onRatingUpdate: (rating) {},
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'ความคิดเห็น',
                    prefixIcon: Icon(Icons.send),
                    hintStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.white70,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      borderSide: BorderSide(color: Colors.blueGrey,),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      borderSide: BorderSide(color: Colors.blueGrey, ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}