import 'package:villastore_app/Models/ImageModel.dart';
import 'package:villastore_app/Models/LocationModel.dart';
import 'package:villastore_app/Models/PostedByModel.dart';
import 'package:villastore_app/Models/UnitModel.dart';

import 'UnitTypeModel.dart';

class PaginatedUnit {
////  LocationModel location;
  var count;
  var next;
  var previous;
  var units;

  PaginatedUnit({this.count,
    this.next,
    this.previous,
    this.units});

  factory PaginatedUnit.fromJson(Map<String, dynamic> json) {

    return new PaginatedUnit(
        count: json['count'],
        next: json['next'],
        previous: json['previous']);
  }
}
