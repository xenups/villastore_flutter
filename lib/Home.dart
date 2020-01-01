import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:http/http.dart' as http;
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:loadmore/loadmore.dart';
import 'package:villastore_app/Models/PaginatedUnit.dart';
import 'dart:convert';

import 'Models/UnitModel.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

  Home();
}

class _HomeState extends State<Home> {
//  Map<String, dynamic> unitLists = new Map<String, dynamic>();
//  Map<String, dynamic> unitLists = {'result': 0};
  var unitLists;
  List<dynamic> units = new List<dynamic>();
  int itemCount = 0;
  int pageNumber = 1;
  bool isLoad = false;
  final numberOfItem = 2;///number of item that exist into paginated
  List<dynamic> list = new List();
  ScrollController _scrollController = ScrollController();

  Future<Map<String, dynamic>> _handleRefresh() async {
    var update = await getUnitLists(1);
    setState(() {
      unitLists = update;
      itemCount = 2;
      pageNumber = 1;
      isLoad = false;
    });
    return unitLists;
  }

  Future<Map<String, dynamic>> loadMore() async {
    print('load more called ');
    setState(() {
      isLoad = true;
    });
    var totalItemCount = 1;
    if (unitLists != null) {
      totalItemCount = PaginatedUnit.fromJson(unitLists).count;
    }
    if (itemCount < totalItemCount) {
      int page = pageNumber++;
      unitLists = await getUnitLists(page);
      setState(() {
        itemCount = itemCount + numberOfItem;
        units.addAll(unitLists['results']);
        isLoad = false;
      });
      return unitLists;
    } else {
      setState(() {
        isLoad = false;
      });
    }
    return unitLists;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });
    setState(() {
      loadMore();
    });
  }

  String _getImage(index) {
    if (Unit.fromJson(units[index]).images.isNotEmpty) {
      return Unit.fromJson(units[index]).images[0].image;
    } else {
      return 'tumb.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height - 20,
        child: Column(
          children: <Widget>[
            Flexible(
              child: FutureBuilder<dynamic>(
                  future: getUnitLists(1), //returns bool
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      return SafeArea(
                          child: LiquidPullToRefresh(
                            showChildOpacityTransition: false,
                            onRefresh: _handleRefresh,
                            scrollController: _scrollController,
                            color: Colors.indigo,
                            child: ListView.builder(
                                itemCount: itemCount,
//                      controller: _scrollController,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    child: Container(
                                      height: 300,
                                      width: MediaQuery.of(context).size.width - 10,
                                      margin: const EdgeInsets.only(
                                          top: 10.0,
                                          bottom: 10.0,
                                          left: 15.0,
                                          right: 15.0),
                                      child: Card(
                                          elevation: 10.0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20.0)),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                              ///ghesmate bala
                                              Stack(
                                                fit: StackFit.passthrough,
                                                children: <Widget>[
                                                  ///axe bala
                                                  Container(
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.vertical(
                                                          top: Radius.circular(20.0)),
                                                      child: FittedBox(
                                                        child: Container(
                                                          child: ClipRRect(
                                                            borderRadius:
                                                            BorderRadius.vertical(
                                                                top: Radius.circular(
                                                                    20.0)),
                                                            child:
                                                            FadeInImage.assetNetwork(
//                                              alignment: Alignment.,
                                                              fit: BoxFit.cover,
                                                              width:
                                                              MediaQuery.of(context)
                                                                  .size
                                                                  .width,
// add this
                                                              placeholder:
                                                              ('resources/tumb.png'),

                                                              image: _getImage(index),
                                                            ),
                                                          ),
                                                        ),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    height: 155,
//                              width: MediaQuery.of(context).size.width,
                                                  ),

                                                  ///axe bala
                                                  ///matne roo ax
                                                  Positioned(
                                                    child: new Container(
                                                        child: new Text(
                                                            Unit.fromJson(units[index])
                                                                .unit_heading,
                                                            style: new TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 20.0,
                                                            )),
                                                        decoration: new BoxDecoration(
                                                            color: Color.fromRGBO(
                                                                0, 0, 0, 0.70),
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                20.0)),
                                                        padding: new EdgeInsets.only(
                                                            left: 20, right: 20)),
                                                    left: 5.0,
                                                    bottom: 5.0,
                                                  )

                                                  ///matne roo ax
                                                ],
                                              ),

                                              ///ghesmate bala
                                              SizedBox(
                                                height: 5,
                                              ),

                                              properties(units[index]),

                                              ///ghesmate payeen
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 10,
                                                    top: 80,
                                                    left: 20,
                                                    right: 20),
                                                alignment: AlignmentDirectional.topStart,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Text(
                                                      Unit.fromJson(units[index])
                                                          .postedBy
                                                          .user
                                                          .username
                                                          .toString(),
                                                      style: TextStyle(fontSize: 12),
                                                    ),
                                                    Text(
                                                        Unit.fromJson(units[index])
                                                            .dateOfPosting
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontFamily: 'farsifont')),
                                                  ],
                                                ),
                                              )

//ghesmate payeen
                                            ],
                                          )),
                                    ),
                                    onTap: () {
                                      print(Unit.fromJson(units[index]).unit_heading);
                                    },
                                  );
                                }),
                          ));
                    } else if (snapshot.hasError) {
                      return Text('error');
                    }
                    return Center(
                      child: SpinKitPulse(
                        color: Colors.black38,
                        size: 50.0,
                      ),
                    );
                  })),
            ),
            Container(
              height: isLoad ? 50.0 : 0,
              color: Colors.transparent,
              child: Center(
                child: new CircularProgressIndicator(),
              ),
            ),

          ],
        ));
  }

  _HomeState();
}

class properties extends StatefulWidget {
  var unit;

  @override
  _propertiesState createState() => _propertiesState(this.unit);

  properties(this.unit);
}

class _propertiesState extends State<properties> {
  var unit;

  _propertiesState(this.unit);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Row(
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Expanded(
              child: PropertieText(
                  'پارکینگ:',
                  Unit.fromJson(unit).numOfAssignedCarParking.toString(),
                  Icon(
                    Icons.directions_car,
                    color: Colors.deepOrangeAccent,
                    size: 15,
                  )),
            ),
            Expanded(
              child: PropertieText(
                  'پارکت:',
                  Unit.fromJson(unit).carpetArea.toString(),
                  Icon(
                    Icons.center_focus_strong,
                    color: Colors.indigo,
                    size: 15,
                  )),
            ),
            Expanded(
              child: PropertieText(
                  'حمام:',
                  Unit.fromJson(unit).numberOfBathroom.toString(),
                  Icon(
                    Icons.theaters,
                    color: Colors.deepOrange,
                    size: 15,
                  )),
            ),
            Expanded(
              child: PropertieText(
                  'اتاق:',
                  Unit.fromJson(unit).numberOfBedroom.toString(),
                  Icon(
                    Icons.room,
                    color: Colors.black38,
                    size: 15,
                  )),
            ),
          ],
        ));
  }
}

class PropertieText extends StatefulWidget {
  String akey = '';
  String avalue = '';
  Icon icon;

  PropertieText(this.akey, this.avalue, this.icon);

  @override
  _PropertieTextState createState() =>
      _PropertieTextState(this.akey, this.avalue, this.icon);
}

class _PropertieTextState extends State<PropertieText> {
  String akey = '';
  String avalue = '';
  Icon icon;

  @override
  Widget build(BuildContext context) {
    initState() {
      setState(() {
        this.akey = akey;
        this.avalue = avalue;
        this.icon = icon;
      });
    }

    return Container(
//        margin: const EdgeInsets.all(5),
        child: Row(
//          crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          this.akey + ' ' + this.avalue,
          style: TextStyle(color: Colors.black87, fontFamily: 'farsifont'),
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
        ),
        SizedBox(
          width: 5.0,
        ),
        this.icon,
      ],
    ));
  }

  _PropertieTextState(this.akey, this.avalue, this.icon);
}

Future<Map<String, dynamic>> getUnitLists(int page) async {

  var url = 'http://192.168.1.101:3000/api/units/?page=$page';
  final http.Response response = await http.get(url);
  await Future.delayed(Duration(seconds: 0, milliseconds: 2000));

  if (response.statusCode == 200) {
    return json.decode(utf8.decode(response.bodyBytes));
  } else {
    throw Exception('Failed to load post');
  }
}
