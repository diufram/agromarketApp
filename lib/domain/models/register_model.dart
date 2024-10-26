import 'dart:convert';

import 'package:agromarket_app/domain/models/user_model.dart';

Register registerFromJson(String str) => Register.fromJson(json.decode(str));

String registerToJson(Register data) => json.encode(data.toJson());

class Register {
  User user;
  String token;

  Register({
    required this.user,
    required this.token,
  });

  factory Register.fromJson(Map<String, dynamic> json) => Register(
        user: User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
      };
}
