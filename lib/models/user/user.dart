import 'package:test_app/models/user/user_name.dart';
import 'package:test_app/models/user/user_picture.dart';

class User {
  final String gender;
  final UserName name;
  final String email;
  final String phone;
  final UserPicture picture;
  User(
      {required this.gender,
      required this.name,
      required this.email,
      required this.phone,
      required this.picture});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        gender: json['gender'],
        name: UserName.fromJson(json['name']),
        email: json['email'],
        phone: json['phone'],
        picture: UserPicture.fromJson(json['picture']));
  }
}
