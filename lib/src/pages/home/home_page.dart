import 'package:FlutterApp/src/configs/app_route.dart';
import 'package:FlutterApp/src/configs/app_setting.dart';
import 'package:FlutterApp/src/widgets/menu_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _current = 0;
  final List<String> imgList = [
    'http://img.painaidii.com/images/20191015_3_1571112240_924495.jpg',
    'http://img.painaidii.com/images/20180215_3_1518665683_126040.jpg',
    'http://img.painaidii.com/images/20140602_3_1401695338_274488.jpg',
    'http://img.painaidii.com/images/20140603_3_1401759043_248345.jpg',
    'http://img.painaidii.com/images/20140603_3_1401759658_127879.jpg'
  ]; //ที่เที่ยว

  List<String> imgArray = [
    'https://img.kapook.com/u/2020/pattra/pattravel202008/phuket003.jpg',
    'https://img.kapook.com/u/2019/pattra/pattraveljuly2019/phuket13.jpg',
    'https://img.kapook.com/u/2019/pattra/pattraveljuly2019/phuket12.jpg',
    'https://img.kapook.com/u/2020/pattra/pattravel202008/phuket002.jpg',
    'https://img.kapook.com/u/2019/pattra/pattraveljuly2019/phuket07.jpg'
  ]; //ที่พัก
  List<String> imgView = [
    'https://img.wongnai.com/p/1920x0/2016/09/27/9759d173cd884f95a79271214fee33c3.jpg',
    'https://img.wongnai.com/p/1920x0/2021/11/14/a20bf4ad2fd846ee9efdf57b25b76b92.jpg',
    'https://img.wongnai.com/p/624x0/2020/12/30/8433c66335f44d949e04ed7582de84db.jpg',
    'https://img.wongnai.com/p/1920x0/2020/12/19/7eeafc159b9d46d7969e31cba567cd78.jpg',
    'https://img.wongnai.com/p/1920x0/2020/08/23/22c9c6d4816046dda301b3f868867174.jpg'
  ]; //อาหาร

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              const UserAccountsDrawerHeader(
                accountName: Text(
                  'หน้าเมนู',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                ),
              ),
              ...MenuViewModel()
                  .items
                  .map((e) => ListTile(
                title: Text(e.title),
                onTap: () {
                  e.onTap(context);
                },
              ))
                  .toList(),
              Spacer(),
              ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.black,
                ),
                title: const Text('ออกจากระบบ'),
                onTap: () async {
                  SharedPreferences prefs =
                  await SharedPreferences.getInstance();
                  prefs.remove(AppSetting.userNameSetting);
                  prefs.remove(AppSetting.passwordSetting);
                  Navigator.pushNamed(context, AppRoute.loginRoute);
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text("Hotel in Phuket"),
        ),

        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: size.height * 0.1 ,
                child: Stack(
                  children:<Widget> [
                    Container(
                      height: size.height * 0.1 - 10,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        )
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 20),
                                blurRadius: 40,
                                color: Colors.black12.withOpacity(0.40) ,
                              ),
                            ],
                          ),
                          child: TextField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "Search",
                              hintStyle: TextStyle(
                                color: Colors.blueGrey,
                              ),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              icon: Icon(Icons.search),
                            ),
                          ),
                        )),

                  ],
                ),
              ),
              SizedBox(height: 6),
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.all(20),
                elevation: 7,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Ink.image(
                        image: AssetImage('assets/images/m2.jfif'),
                        height: 200,
                        fit: BoxFit.fill,
                      ),
                      Text('ภูเก็ต เป็นจังหวัดหนึ่งทางภาคใต้ของประเทศไทย'
                          'และเป็นเกาะขนาดใหญ่ที่สุดในประเทศไทย '),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 9),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                leading: CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/images/bg1.jpg',
                  ),
                ),
                title: Text('สถานที่พักที่เเนะนำ'),
                subtitle: Text('ในภูเก็ต'),
              ),
              CarouselSlider.builder(
                itemCount: imgList.length,
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                ),
                itemBuilder: (context, index, realIdx) {
                  return Container(
                    child: Center(
                        child: Image.network(imgList[index],
                            fit: BoxFit.cover, width: 1000)),
                  );
                },
              ),
              SizedBox(height: 5),
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                leading: CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/images/bg3.jpg',
                  ),
                ),
                title: Text('สถานที่ท่องเที่ยว'),
                subtitle: Text('ในภูเก็ต'),
              ), //
              CarouselSlider.builder(
                itemCount: imgArray.length,
                options: CarouselOptions(

                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                ),
                itemBuilder: (context, index, realIdx) {
                  return Container(
                    child: Center(
                        child: Image.network(imgArray[index],
                            fit: BoxFit.cover, width: 1000)),
                  );
                },
              ), //
              SizedBox(height: 5),
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                leading: CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/images/bg2.jpg',
                  ),
                ),
                title: Text('อร่อยชวนชิม'),
                subtitle: Text('ในภูเก็ต'),
              ),
              CarouselSlider.builder(
                itemCount: imgView.length,
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                ),
                itemBuilder: (context, index, realIdx) {
                  return Container(
                    child: Center(
                        child: Image.network(imgView[index],
                            fit: BoxFit.cover, width: 1000)),
                  );
                },
              ),
              SizedBox(height: 20),
              //
              //
            ],
          ),
        ));
  }
}
