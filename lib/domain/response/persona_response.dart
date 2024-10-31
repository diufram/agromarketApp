// To parse this JSON data, do
//
//     final persona = personaFromJson(jsonString);

import 'dart:convert';

import 'package:agromarket_app/domain/response/produccion_response.dart';

Persona personaFromJson(String str) => Persona.fromJson(json.decode(str));

String personaToJson(Persona data) => json.encode(data.toJson());

class Persona {
  final int id;
  final int ci;
  final String nombre;
  final int tipo;
  final List<Propiedad> propiedades;
  final DateTime fechaNacimiento;

  Persona({
    required this.id,
    required this.ci,
    required this.nombre,
    required this.tipo,
    required this.propiedades,
    required this.fechaNacimiento,
  });

  factory Persona.fromJson(Map<String, dynamic> json) => Persona(
        id: json["id"],
        ci: json["ci"],
        nombre: json["nombre"],
        tipo: json["tipo"],
        propiedades: List<Propiedad>.from(
            json["propiedades"].map((x) => Propiedad.fromJson(x))),
        fechaNacimiento: DateTime.parse(json["fechaNacimiento"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ci": ci,
        "nombre": nombre,
        "tipo": tipo,
        "propiedades": List<dynamic>.from(propiedades.map((x) => x.toJson())),
        "fechaNacimiento":
            "${fechaNacimiento.year.toString().padLeft(4, '0')}-${fechaNacimiento.month.toString().padLeft(2, '0')}-${fechaNacimiento.day.toString().padLeft(2, '0')}",
      };
}
