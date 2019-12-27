import 'package:villastore_app/Models/UserTypeModel.dart';

class User {
  var id, username, first_name, last_name, email;

  User(this.id, this.username, this.first_name, this.last_name, this.email);

  factory User.fromJson(dynamic json) {
    return User(
      json['id'],
      json['username'],
      json['first_name'],
      json['last_name'],
      json['email'],
    );
  }
}

class PostedBy {
  var bio;
  User user;
  UserType userType;

  PostedBy(this.bio, this.user, this.userType);

  factory PostedBy.fromJson(dynamic json) {
    return PostedBy(
      json['bio'] as String,
      User.fromJson(json['user']),
      UserType.fromJson(json['user_type']),
    );
  }

//  Map toJson() {
//    return {
//      'bio': bio,
//      'user': user,
//      'userType': userType,
//    };
//  }
}
