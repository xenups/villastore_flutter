class GeometryModel {
  var type, coordinate;

  GeometryModel(this.type, this.coordinate);

  GeometryModel.fromjson(Map json)
      : type = json['type'],
        coordinate = json['coordinate'];

  Map toJson() {
    return {
      'type': type,
      'coordinate': coordinate,
    };
  }
}

class Properties {
  var address, city, state;

  Properties(this.address, this.city, this.state);

  Properties.fromjson(Map json)
      : address = json['address'],
        city = json['city'],
        state = json['state'];

  Map toJson() {
    return {
      'address': address,
      'city': city,
      'state': state,
    };
  }
}

class LocationModel {
  var id, type;
  GeometryModel geometryModel;
  Properties properties;

  LocationModel(this.id, this.type, this.geometryModel, this.properties);

  LocationModel.fromjson(Map json)
      : id = json['id'],
        type = json['type'],
        geometryModel = json['geometryModel'],
        properties = json['properties'];

  Map toJson() {
    return {
      'id': id,
      'type': type,
      'geometryModel': geometryModel,
      'properties': properties,
    };
  }
}
