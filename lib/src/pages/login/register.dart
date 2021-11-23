import 'package:FlutterApp/src/configs/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("สร้างบัญชีผู้ใช้ใหม่"),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage('assets/images/b1.jpg')),
          )),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "กรุณาป้อนอีเมล"),
                        EmailValidator(errorText: "รูปแบบอีเมลไม่ถูกต้อง")
                      ]),
                      onSaved: (String email) {
                        profile.email = email;
                      },
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
                        validator:
                        RequiredValidator(errorText: "กรุณาป้อนรหัสผ่าน"),
                        obscureText: true,
                        onSaved: (String password) {
                          profile.password = password;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white70,
                          border: InputBorder.none,
                          labelText: 'รหัสผ่าน',
                          labelStyle: TextStyle(fontSize: 15),
                          prefixIcon: Icon(Icons.vpn_key),

                        )),

                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            onPressed: () async {
                              //Navigator.pushNamed(context, AppRoute.homeRoute);
                              if (formKey.currentState.validate()) {
                                formKey.currentState.save();
                                try {
                                  await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: profile.email,
                                          password: profile.password);
                                  formKey.currentState.reset();
                                } on FirebaseAuthException catch (e) {
                                  print(e.message);
                                }
                              }
                            },
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Text(
                              "ลงทะเบียน",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
