// To parse this JSON data, do
//
//     final temporada = temporadaFromJson(jsonString);

import 'dart:convert';

import 'package:agromarket_app/domain/response/produccion_response.dart';

List<Temporada> temporadaFromJson(String str) =>
    List<Temporada>.from(json.decode(str).map((x) => Temporada.fromJson(x)));

String temporadaToJson(List<Temporada> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
