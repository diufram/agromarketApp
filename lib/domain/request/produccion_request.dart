// To parse this JSON data, do
//
//     final produccionRequest = produccionRequestFromJson(jsonString);

import 'dart:convert';

ProduccionRequest produccionRequestFromJson(String str) =>
    ProduccionRequest.fromJson(json.decode(str));

String produccionRequestToJson(ProduccionRequest data) =>
    json.encode(data.toJson());

class ProduccionRequest {
  double cantidad;
  DateTime fechaSiembra;
  DateTime fechaCosecha;
  int propiedadId;
  int temporadaId;
  int productoId;
  int uniMedidaId;

  ProduccionRequest({
    required this.cantidad,
    required this.fechaSiembra,
    required this.fechaCosecha,
    required this.propiedadId,
    required this.temporadaId,
    required this.productoId,
    required this.uniMedidaId,
  });

  factory ProduccionRequest.fromJson(Map<String, dynamic> json) =>
      ProduccionRequest(
        cantidad: json["cantidad"]?.toDouble(),
        fechaSiembra: DateTime.parse(json["fecha_siembra"]),
        fechaCosecha: DateTime.parse(json["fecha_cosecha"]),
        propiedadId: json["propiedad_id"],
        temporadaId: json["temporada_id"],
        productoId: json["producto_id"],
        uniMedidaId: json["uni_medida_id"],
      );

  Map<String, dynamic> toJson() => {
        "cantidad": cantidad.toDouble(),
        "fecha_siembra":
            "${fechaSiembra.year.toString().padLeft(4, '0')}-${fechaSiembra.month.toString().padLeft(2, '0')}-${fechaSiembra.day.toString().padLeft(2, '0')}",
        "fecha_cosecha":
            "${fechaCosecha.year.toString().padLeft(4, '0')}-${fechaCosecha.month.toString().padLeft(2, '0')}-${fechaCosecha.day.toString().padLeft(2, '0')}",
        "propiedad_id": propiedadId,
        "temporada_id": temporadaId,
        "producto_id": productoId,
        "uni_medida_id": uniMedidaId,
      };
}
