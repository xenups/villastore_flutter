class UnitType {
  String unit_type;
  int id;

  UnitType(this.unit_type, this.id);

  factory UnitType.fromJson(dynamic json) {
    return UnitType(json['unit_type'] as String, json['id'] as int);
  }

  @override
  String toString() {
    return '{ ${this.unit_type}, ${this.id} }';
  }
}
