import 'package:FlutterApp/src/configs/app_route.dart';
import 'package:FlutterApp/src/configs/app_setting.dart';
import 'package:FlutterApp/src/sevices/network.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isHidden = false;

  var _usernameController = TextEditingController();
  var _passwordController = TextEditingController();
  
  //final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController?.dispose();
    _passwordController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                    image: AssetImage ('assets/images/b1.jpg')),
          )
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 200, 10, 10),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Welcome to Hotel in Phuket',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontFamily: 'SourceSansPro'),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _usernameController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                        fillColor: Colors.white70,
                        border: InputBorder.none,
                        labelText: 'อีเมล',
                        // hintText: 'nirachawanchitnai@gmail.com',
                       prefixIcon: Icon(Icons.email)),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white70,
                        border: InputBorder.none,
                        labelText: 'รหัสผ่าน',
                        labelStyle: TextStyle(fontSize: 15),
                        prefixIcon: Icon(Icons.vpn_key),
                        suffixIcon: IconButton(
                            icon: isHidden
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                            onPressed: togglePasswordVisibility),
                      )),
                  SizedBox(
                    height: 30,

                  ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)
                            ),
                            onPressed: () async {
                              final username = _usernameController.text;
                              final password = _passwordController.text;
                              final message = await NetworkService()
                                  .validateUserLoginDio(username, password);
                              print(message);
                              print(username + "  " + password);
                              if (message == 'pass') {
                                print('longin success');
                                SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                                prefs.setString(AppSetting.userNameSetting, username);
                                prefs.setString(AppSetting.passwordSetting, password);

                                Navigator.pushNamed(context, AppRoute.homeRoute);
                              } else {
                                print('longin failed');
                                Flushbar(
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Colors.green,
                                  ),
                                  backgroundColor: Colors.black,
                                  title: "Failed",
                                  message: "Login failed, try again!!",
                                  duration: Duration(seconds: 5),
                                )..show(context);
                              }
                            },

                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Text(
                                "เข้าสู่ระบบ",
                                style: TextStyle(color: Colors.black, fontSize: 15),
                              ),
                              color: Colors.white,

                          ),
                        ),
                        SizedBox(width: 15,),
                        Expanded(
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)
                            ),
                            color: Colors.blueGrey,
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoute.RegisterScreenRout);
                            },
                            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                            child: Text(
                              "สร้างบัญชีผู้ใช้",
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),

                          ),
                        ),
                      ],
                    ),
                ],
              ),

          ),


      ],),
    );
  }

  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);
}
