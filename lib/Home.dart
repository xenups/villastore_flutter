import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:http/http.dart' as http;
import 'package:villastore_app/Models/PaginatedUnit.dart';
import 'package:villastore_app/Unit.dart';
import 'dart:convert';

import 'CustomCard.dart';
import 'Models/UnitModel.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

  Home();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  var unitLists;
  List<dynamic> units = new List<dynamic>();
  int pageNumber = 1;
  bool isLoad = false;
  ScrollController _scrollController = ScrollController();

  Future<Map<String, dynamic>> _handleRefresh() async {
//    units.clear();
    setState(() {
      pageNumber = 1;
      isLoad = false;
      units = [];
//      unitLists =[];
    });
//
//    unitLists = await getUnitLists(1);
//    units = unitLists['results'];
    return loadMore();
  }

  Future<Map<String, dynamic>> loadMore() async {
    setState(() {
      this.isLoad = true;
    });
    var totalItemCount = 1;
    if (unitLists != null) {
      totalItemCount = PaginatedUnit.fromJson(unitLists).count;
    }
    if (units.length < totalItemCount && isLoad) {
      unitLists = await getUnitLists(pageNumber++);
      setState(() {
        print('page number is $pageNumber');
        print('unit lentgh is ${units.length}');
        units.addAll(unitLists['results']);
        this.isLoad = false;
      });
      return unitLists;
    } else {
      setState(() {
        this.isLoad = false;
      });
      return unitLists;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !isLoad) {
        loadMore();
        ///delegate load more to scrolcontoroller
      }
    });
    setState(() {
      loadMore();
      ///load data in initializing
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
                            itemCount: units.length,
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
                                  child: CustomCard(units[index]),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                          new UnitView(units[index])));

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
              height: isLoad ? 22.0 : 0,
              color: Colors.transparent,
              child: Center(
                child: new SpinKitSpinningCircle(size: 20,
                  color: Colors.indigo,
                ),
              ),
            ),
          ],
        ));
  }

  _HomeState();
}

Future<Map<String, dynamic>> getUnitLists(int page) async {
//  await Future.delayed(Duration(seconds: 0, milliseconds: 1000));

  var url = 'http://192.168.1.101:3000/api/units/?page=$page';
  final http.Response response = await http.get(url);
  if (response.statusCode == 200) {
    return json.decode(utf8.decode(response.bodyBytes));
  } else {
    throw Exception('Failed to load post');
  }
}
