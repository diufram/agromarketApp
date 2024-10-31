// To parse this JSON data, do
//
//     final oferta = ofertaFromJson(jsonString);

import 'dart:convert';

List<Oferta> ofertaFromJson(String str) =>
    List<Oferta>.from(json.decode(str).map((x) => Oferta.fromJson(x)));

String ofertaToJson(List<Oferta> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Oferta {
  int id;
  String descripcion;
  bool estado;
  List<OfertaDetalle> ofertaDetalle;
  DateTime fechaExpiracion;
  DateTime fechaCreacion;

  Oferta({
    required this.id,
    required this.descripcion,
    required this.estado,
    required this.ofertaDetalle,
    required this.fechaExpiracion,
    required this.fechaCreacion,
  });

  factory Oferta.fromJson(Map<String, dynamic> json) => Oferta(
        id: json["id"],
        descripcion: json["descripcion"],
        estado: json["estado"],
        ofertaDetalle: List<OfertaDetalle>.from(
            json["oferta_detalle"].map((x) => OfertaDetalle.fromJson(x))),
        fechaExpiracion: DateTime.parse(json["fechaExpiracion"]),
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": descripcion,
        "estado": estado,
        "oferta_detalle":
            List<dynamic>.from(ofertaDetalle.map((x) => x.toJson())),
        "fechaExpiracion":
            "${fechaExpiracion.year.toString().padLeft(4, '0')}-${fechaExpiracion.month.toString().padLeft(2, '0')}-${fechaExpiracion.day.toString().padLeft(2, '0')}",
        "fechaCreacion":
            "${fechaCreacion.year.toString().padLeft(4, '0')}-${fechaCreacion.month.toString().padLeft(2, '0')}-${fechaCreacion.day.toString().padLeft(2, '0')}",
      };
}

class OfertaDetalle {
  bool estado;
  String descripcion;
  double precio;
  DateTime fechaExpiracion;
  double cantidadInicial;
  double cantidadActual;
  DateTime fechaCreacion;

  OfertaDetalle({
    required this.estado,
    required this.descripcion,
    required this.precio,
    required this.fechaExpiracion,
    required this.cantidadInicial,
    required this.cantidadActual,
    required this.fechaCreacion,
  });

  factory OfertaDetalle.fromJson(Map<String, dynamic> json) => OfertaDetalle(
        estado: json["estado"],
        descripcion: json["descripcion"],
        precio: json["precio"]?.toDouble(),
        fechaExpiracion: DateTime.parse(json["fechaExpiracion"]),
        cantidadInicial: json["cantidadInicial"]?.toDouble(),
        cantidadActual: json["cantidadActual"]?.toDouble(),
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
      );

  Map<String, dynamic> toJson() => {
        "estado": estado,
        "descripcion": descripcion,
        "precio": precio,
        "fechaExpiracion":
            "${fechaExpiracion.year.toString().padLeft(4, '0')}-${fechaExpiracion.month.toString().padLeft(2, '0')}-${fechaExpiracion.day.toString().padLeft(2, '0')}",
        "cantidadInicial": cantidadInicial,
        "cantidadActual": cantidadActual,
        "fechaCreacion":
            "${fechaCreacion.year.toString().padLeft(4, '0')}-${fechaCreacion.month.toString().padLeft(2, '0')}-${fechaCreacion.day.toString().padLeft(2, '0')}",
      };
}
