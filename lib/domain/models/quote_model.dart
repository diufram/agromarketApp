import 'dart:convert';

Quote quoteFromJson(String str) => Quote.fromJson(json.decode(str));

String quoteToJson(Quote data) => json.encode(data.toJson());

class Quote {
  int discount;
  double subtotal;
  double total;
  DateTime date;
  int companyId;
  int id;

  Quote({
    required this.discount,
    required this.subtotal,
    required this.total,
    required this.date,
    required this.companyId,
    required this.id,
  });

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        discount: json["discount"],
        subtotal: json["subtotal"]?.toDouble(),
        total: json["total"]?.toDouble(),
        date: DateTime.parse(json["date"]),
        companyId: json["company_id"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "discount": discount,
        "subtotal": subtotal,
        "total": total,
        "date": date.toIso8601String(),
        "company_id": companyId,
        "id": id,
      };
}
