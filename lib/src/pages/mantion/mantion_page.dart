import 'package:FlutterApp/src/configs/api.dart';
import 'package:FlutterApp/src/configs/app_route.dart';
import 'package:FlutterApp/src/model/mation_model.dart';
import 'package:FlutterApp/src/sevices/network.dart';
import 'package:flutter/material.dart';

class MantionPage extends StatefulWidget {
  @override
  _MantionPageState createState() => _MantionPageState();
}

class _MantionPageState extends State<MantionPage> {
  Future<MantionModel> _mantionModel;
  bool isSearching = false;
  bool check = false;
  bool check2 = false;
  bool check3 = false;
  bool check4 = false;
  bool _checkboxValue = false;
  bool _checkboxValue2 = false;
  bool _checkboxValue3 = false;
  bool _checkboxValue4 = false;

  String _searchText = "";
  _MantionPageState() {
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

    _mantionModel = NetworkService().getAllMantionDio();
    if (_mantionModel.toString().isNotEmpty) {
      await _mantionModel.then((value) => {
        for (int i = 0; i < value.mantion.length; i++)
          {
            tempList.add(value.mantion[i]),
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
        Mantion mantion = filteredNames[i];
        if(mantion.mantionName.toLowerCase().contains(_searchText.toLowerCase())){
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
        child: FutureBuilder<MantionModel>(
            future: NetworkService().getAllMantionDio(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: names == null ? 0 : filteredNames.length,
                  itemBuilder: (context, index) {
                    Mantion mantion = filteredNames[index];
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
                                      mantion.mantionImg != ""
                                          ? Image.network(
                                        API.MANTION_IMAGE + mantion.mantionImg,
                                        height: 250,
                                      )
                                          : Image.asset(
                                        'assets/images/no_photo.png',
                                        height: 160,
                                      ),
                                      SizedBox(height: 10,),
                                      Text(
                                        mantion.mantionName,
                                        textAlign: TextAlign.center,
                                      ),
                                      mantion.mantionDetail == '0'
                                          ? Text(
                                        '฿' +
                                            mantion.mantionPrice +
                                            ' ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                      )
                                          : Text('' +
                                          mantion.mantionPrice +
                                          '  '),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
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
                                                    AppRoute.MantionDetailRoute,
                                                    arguments: mantion);
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