class UserType {
  var user_type;

  UserType(this.user_type,);

  factory UserType.fromJson(dynamic json) {
    return UserType(
      json['user_type'],
    );
  }
}
