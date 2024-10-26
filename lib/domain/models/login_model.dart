import 'dart:convert';


import 'package:agromarket_app/domain/models/user_model.dart';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  User user;
  String token;
  int companyId;

  Login({
    required this.user,
    required this.token,
    required this.companyId,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        user: User.fromJson(json["user"]),
        token: json["token"],
        companyId: json["company_id"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
        "company_id": companyId,
      };
}
