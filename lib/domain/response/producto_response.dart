// To parse this JSON data, do
//
//     final producto = productoFromJson(jsonString);

import 'dart:convert';

import 'package:agromarket_app/domain/response/produccion_response.dart';

List<Producto> productoFromJson(String str) =>
    List<Producto>.from(json.decode(str).map((x) => Producto.fromJson(x)));

String productoToJson(List<Producto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

