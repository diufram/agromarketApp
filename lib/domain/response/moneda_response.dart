// To parse this JSON data, do
//
//     final moneda = monedaFromJson(jsonString);

import 'dart:convert';

List<Moneda> monedaFromJson(String str) => List<Moneda>.from(json.decode(str).map((x) => Moneda.fromJson(x)));

String monedaToJson(List<Moneda> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Moneda {
    int id;
    String nombre;

    Moneda({
        required this.id,
        required this.nombre,
    });

    factory Moneda.fromJson(Map<String, dynamic> json) => Moneda(
        id: json["id"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
    };
}
