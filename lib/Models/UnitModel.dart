import 'package:villastore_app/Models/ImageModel.dart';
import 'package:villastore_app/Models/LocationModel.dart';
import 'package:villastore_app/Models/PostedByModel.dart';

import 'UnitTypeModel.dart';

class Unit {
////  LocationModel location;
  var ID;
  var carpetArea;
  var dateOfPosting;
  var hasCarpet;
  var isActive;
  var isAirconitioned;
  var isCenteralFanCooling;
  var numOfAssignedCarParking;
  var numberOfBalcony;
  var numberOfBathroom;
  var numberOfBedroom;
  var unitDescription;
  var unitFloorNumber;
  String unit_heading;
  UnitType unit_type;
  PostedBy postedBy;
  final List<Image> images;

  Unit({this.ID,
    this.carpetArea,
    this.dateOfPosting,
    this.hasCarpet,
    this.isActive,
    this.isAirconitioned,
    this.isCenteralFanCooling,
    this.numOfAssignedCarParking,
    this.numberOfBalcony,
    this.numberOfBathroom,
    this.numberOfBedroom,
    this.unitDescription,
    this.unitFloorNumber,
    this.unit_heading,
    this.unit_type,
    this.postedBy,
    this.images});

  factory Unit.fromJson(Map<String, dynamic> json) {
    var list = json['images'] as List;
    print(list.runtimeType);
    List<Image> imagesList = list.map((i) => Image.fromJson(i)).toList();
    return new Unit(
        ID: json['id'],
        carpetArea: json['carpet_area'],
        dateOfPosting: json['date_of_posting'],
        hasCarpet: json['has_carpet'],
        isActive: json['is_active'],
        isAirconitioned: json['is_airconitioned'],
        isCenteralFanCooling: json['is_centeral_fancooling'],
        numOfAssignedCarParking: json['num_of_assigned_car_parking'],
        numberOfBalcony: json['number_of_balcony'],
        numberOfBathroom: json['number_of_bathroom'],
        numberOfBedroom: json['number_of_bedroom'],
        unitDescription: json['unit_description'],
        unitFloorNumber: json['unit_floor_number'],
        unit_heading: json['unit_heading'] as String,
        unit_type: UnitType.fromJson(json['unit_type']),
        postedBy: PostedBy.fromJson(json['posted_by']),
        images: imagesList);
  }
}
