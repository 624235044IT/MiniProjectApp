import 'package:FlutterApp/src/configs/api.dart';
import 'package:FlutterApp/src/model/mation_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MntDetailPage extends StatefulWidget {
  @override
  _MntDetailPageState createState() => _MntDetailPageState();
}

class _MntDetailPageState extends State<MntDetailPage> {

  Mantion _mantionModel;
  @override
  void initState() {
    _mantionModel = Mantion();
    super.initState();
  }

  Widget build(BuildContext context) {
    Object arguments = ModalRoute.of(context).settings.arguments;
    if (arguments is Mantion) {
      _mantionModel = arguments;
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
                    API.MANTION_IMAGE + _mantionModel.mantionImg),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 150, 10),
                child: Text('รายละเอียดเพิ่มเติม', style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,),

                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 100, 30),
                child: Text(_mantionModel.mantionDetail,textAlign: TextAlign.start,),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 180, 0),
                child: Text(
                  'คะแนนความชอบใจ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 100, 0),
                child: SizedBox(
                  child: Center(
                    child: RatingBar.builder(
                      minRating: 1,
                      itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
                      onRatingUpdate: (rating) {},
                    ),
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