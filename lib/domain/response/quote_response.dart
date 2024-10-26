import 'dart:convert';

QuoteResponse quoteResponseFromJson(String str) =>
    QuoteResponse.fromJson(json.decode(str));

String quoteResponseToJson(QuoteResponse data) => json.encode(data.toJson());

class QuoteResponse {
  int id;
  double subTotal;
  int discount;
  double total;
  DateTime date;

  QuoteResponse({
    required this.id,
    required this.subTotal,
    required this.discount,
    required this.total,
    required this.date,
  });

  factory QuoteResponse.fromJson(Map<String, dynamic> json) => QuoteResponse(
        id: json["id"],
        subTotal: json["sub_total"]?.toDouble(),
        discount: json["discount"],
        total: json["total"]?.toDouble(),
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sub_total": subTotal,
        "discount": discount,
        "total": total,
        "date": date.toIso8601String(),
      };
}
