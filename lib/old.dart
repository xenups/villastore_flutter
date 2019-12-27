import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:http/http.dart' as http;
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
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

  _getUnits() async {
    print('hiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii');
    unitLists = await getUnitLists();
    print('salam');
    print(Unit.fromJson(unitLists['results'][0]).unit_heading);
    print(PaginatedUnit.fromJson(unitLists).count);
//    print(PaginatedUnit.fromJson(unitLists[1]).count);
    print('khodafez');
    return unitLists;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _getUnits();
    });
  }

  String _getImage(index) {
    if (Unit.fromJson(unitLists[index]).images.isNotEmpty) {
      return Unit.fromJson(unitLists[index]).images[0].image;
    } else {
      return ' ';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<dynamic>(
            future: getUnitLists(), //returns bool
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return Text('hiiiiiiiiiiiii');
              } else if (snapshot.hasError) {
                return  Text('dasdadadasdas');
              };
              return Text('daste bile talayee');
            })));
  }

  _Home_testState();
}

Future<Map<String, dynamic>> getUnitLists() async {
  print('1');
  var url = 'http://192.168.1.107:8000/api/units/?page=2';
  print('2');

  final http.Response response = await http.get(url);
  print('3');
  if (response.statusCode == 200) {
    return json.decode(utf8.decode(response.bodyBytes));
  } else {
    throw Exception('Failed to load post');
  }

//  return json.decode(response.body);
}
