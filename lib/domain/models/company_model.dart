import 'dart:convert';

Company companyFromJson(String str) => Company.fromJson(json.decode(str));

String companyToJson(Company data) => json.encode(data.toJson());

class Company {
  int id;
  String name;
  String address;
  String telephone;
  String image;
  int userId;

  Company({
    required this.id,
    required this.name,
    required this.address,
    required this.telephone,
    required this.image,
    required this.userId,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        telephone: json["telephone"],
        image: json["image"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "telephone": telephone,
        "image": image,
        "user_id": userId,
      };
}
