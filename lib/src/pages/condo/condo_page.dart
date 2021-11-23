

import 'package:FlutterApp/src/configs/api.dart';
import 'package:FlutterApp/src/configs/app_route.dart';
import 'package:FlutterApp/src/model/condo_model.dart';
import 'package:FlutterApp/src/sevices/network.dart';
import 'package:flutter/material.dart';

class CondoPage extends StatefulWidget {
  @override
  _CondoPageState createState() => _CondoPageState();
}

class _CondoPageState extends State<CondoPage> {
  Future<CondoModel> _condoModel;
  bool isSearching = false;
  bool check = false;
  bool check2 = false;
  bool check3 = false;
  bool check4 = false;


  String _searchText = "";
  _CondoPageState() {
    _filter.addListener(() {
      if(_filter.text.isEmpty){
        setState(() {
          _searchText = "";
          filteredNames = names;
        });

      }else{
        setState(() {
          _searchText = _filter.text;
        });

      }
    });

  }

  @override
  void initState() {
    _getNames();
    super.initState();
  }

  List names = new List();
  List filteredNames = new List();

  Future<void> _getNames() async {
    List tempList = new List();

    _condoModel = NetworkService().getAllCondoDio();
    if (_condoModel.toString().isNotEmpty) {
      await _condoModel.then((value) => {
        for (int i = 0; i < value.condo.length; i++)
          {
            tempList.add(value.condo[i]),
          }
      });
    } //end if
    setState(() {
      names = tempList;
      names.shuffle();
      filteredNames = names;
    });
  } //end method

  @override
  Widget build(BuildContext context) {
    if(!_searchText.isEmpty){
      List tempList = new List();
      for(int i = 0; i < filteredNames.length; i++){
        Condo condo = filteredNames[i];
        if(condo.condoName.toLowerCase().contains(_searchText.toLowerCase())){
          tempList.add(filteredNames[i]);

        }

      }
      filteredNames = tempList;

    }else{
      filteredNames = names;
    }
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Container(
        child: FutureBuilder<CondoModel>(
            future: NetworkService().getAllCondoDio(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: names == null ? 0 : filteredNames.length,
                  itemBuilder: (context, index) {
                    Condo condo = filteredNames[index];
                    return Material(
                      child: InkWell(
                        child: Column(
                          children: [
                            Card(
                              child: Container(
                                color: Colors.white70,
                                child: ListTile(
                                  title: Column(
                                    children: [
                                      condo.condoImg != ""
                                          ? Image.network(
                                        API.CONDO_IMAGE + condo.condoImg,
                                        height: 250,
                                      )
                                          : Image.asset(
                                        'assets/images/no_photo.png',
                                        height: 160,
                                      ),
                                      SizedBox(height: 10,),
                                      Text(
                                        condo.condoName,
                                        textAlign: TextAlign.center,
                                      ),
                                      condo.condoDetail == '0'
                                          ? Text(
                                        '฿' +
                                            condo.condoPrice +
                                            ' ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                      )
                                          : Text('' +
                                          condo.condoPrice +
                                          '  '),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                            child: SizedBox(height: 20),
                                          ),
                                          Expanded(
                                            child: RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(25)
                                              ),
                                              color:Colors.blueGrey ,
                                              onPressed: () {
                                                Navigator.pushNamed(context,
                                                    AppRoute.CondoDetailRoute,
                                                    arguments: condo);
                                              },
                                              child: Text('รายละเอียด',style: TextStyle(color: Colors.white),
                                              ),
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
                      ),
                    );
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        tooltip: 'Add',
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, AppRoute.ManageRoute);
        },
      ),
    );
  }

  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('ค้นหาห้องพัก');

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blueGrey,
      centerTitle: true,
      title: _appBarTitle,
      actions: [
        IconButton(
            onPressed: () {
              _searchPressed();
            },
            icon: _searchIcon)
      ],
    );
  }

  final TextEditingController _filter = new TextEditingController();

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        print('IF search icon');
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          style: TextStyle(color: Colors.white60, fontSize: 10),
          controller: _filter,
          decoration: new InputDecoration(
              suffixIcon: Icon(Icons.search),
              hintText: 'ค้นหา'
          ),
        );
      } else {
        print('ELSE search icon');
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('');
        filteredNames = names;
        _filter.clear();
      }
    });
  }
}