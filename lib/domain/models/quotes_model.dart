import 'dart:convert';

List<Quotes> quotesFromJson(String str) =>
    List<Quotes>.from(json.decode(str).map((x) => Quotes.fromJson(x)));

String quotesToJson(List<Quotes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Quotes {
  int id;
  String discount;
  String subtotal;
  String total;
  DateTime date;
  int companyId;
  DateTime createdAt;
  DateTime updatedAt;

  Quotes({
    required this.id,
    required this.discount,
    required this.subtotal,
    required this.total,
    required this.date,
    required this.companyId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Quotes.fromJson(Map<String, dynamic> json) => Quotes(
        id: json["id"],
        discount: json["discount"],
        subtotal: json["subtotal"],
        total: json["total"],
        date: DateTime.parse(json["date"]),
        companyId: json["company_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "discount": discount,
        "subtotal": subtotal,
        "total": total,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "company_id": companyId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
