import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:villastore_app/CustomCard.dart';
import 'package:villastore_app/Models/PaginatedUnit.dart';
import 'dart:convert';

import 'Models/UnitModel.dart';

class Home_test extends StatefulWidget {
  @override
  _Home_testState createState() => _Home_testState();

  Home_test();
}

class _Home_testState extends State<Home_test> {
  var unitLists;
  List<dynamic> units = new List<dynamic>();
  int pageNumber=1;
  bool isLoad = false;
  final numberOfItem = 2;
  List<dynamic> list = new List();
  ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent && !isLoad) {
        loadMore();
      }
    });
    setState(() {
      loadMore();
    });
  }

  Future<bool> loadMore() async {
    setState(() {
      isLoad = true;
    });
    var totalItemCount = 1;
    if (unitLists != null) {
      totalItemCount = PaginatedUnit.fromJson(unitLists).count;
    }
    if (units.length < totalItemCount && isLoad) {
      int page = pageNumber++;
      unitLists = await getUnitLists(page);
      setState(() {
        units.addAll(unitLists['results']);
        isLoad = false;
      });
      return true;
    } else {
      setState(() {
        isLoad = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: <Widget>[
            Flexible(
                child: FutureBuilder<dynamic>(
                    future: getUnitLists(1), //returns bool
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          child: ListView.builder(
                              itemCount: units.length,
                              controller: _scrollController,
                              itemBuilder: (context, index) {
                                return (Center(
                                  child: CustomCard(units[index]),
                                ));
                              }),
                        );
                      } else if (snapshot.hasError) {
                        return Text('errorrrrrr');
                      }
                      return Text('daste bile talayee');
                    }))),
            Container(
              height: isLoad ? 50.0 : 0,
              color: Colors.transparent,
              child: Center(
                child: new CircularProgressIndicator(),
              ),
            ),
            RaisedButton(
                onPressed: loadMore,
                textColor: Colors.white,
                color: Colors.red,
                padding: const EdgeInsets.all(8.0),
                child: new Text(
                  "get",
                )),
          ],
        ));
  }

  _Home_testState();

}

Future<Map<String, dynamic>> getUnitLists(int page) async {
  print('page is $page');
    await Future.delayed(Duration(seconds: 0, milliseconds: 1000));

  var url = 'http://192.168.1.101:3000/api/units/?page=$page';
  final http.Response response = await http.get(url);
  if (response.statusCode == 200) {
    return json.decode(utf8.decode(response.bodyBytes));
  } else {
    throw Exception('Failed to load post');
  }
}
