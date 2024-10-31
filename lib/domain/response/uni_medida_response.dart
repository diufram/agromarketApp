// To parse this JSON data, do
//
//     final uniMedida = uniMedidaFromJson(jsonString);

import 'dart:convert';

List<UniMedida> uniMedidaFromJson(String str) =>
    List<UniMedida>.from(json.decode(str).map((x) => UniMedida.fromJson(x)));

String uniMedidaToJson(List<UniMedida> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UniMedida {
  int id;
  String nombre;

  UniMedida({
    required this.id,
    required this.nombre,
  });

  factory UniMedida.fromJson(Map<String, dynamic> json) => UniMedida(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
      };
}
