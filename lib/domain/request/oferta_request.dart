// To parse this JSON data, do
//
//     final ofertaRequest = ofertaRequestFromJson(jsonString);

import 'dart:convert';

import 'package:agromarket_app/domain/response/moneda_response.dart';
import 'package:agromarket_app/domain/response/produccion_response.dart';
import 'package:agromarket_app/domain/response/uni_medida_response.dart';

String ofertaRequestToJson(OfertaRequest data) => json.encode(data.toJson());

class OfertaRequest {
  String descripcion;
  DateTime fechaExpiracion;
  List<OfertaDetalleRequest> ofertaDetalle;

  OfertaRequest({
    required this.descripcion,
    required this.fechaExpiracion,
    required this.ofertaDetalle,
  });

  Map<String, dynamic> toJson() => {
        "descripcion": descripcion,
        "fecha_expiracion":
            "${fechaExpiracion.year.toString().padLeft(4, '0')}-${fechaExpiracion.month.toString().padLeft(2, '0')}-${fechaExpiracion.day.toString().padLeft(2, '0')}",
        "oferta_detalle":
            List<dynamic>.from(ofertaDetalle.map((x) => x.toJson())),
      };
}

class OfertaDetalleRequest {
  int produccionId;
  int monedaId;
  int uniMedidaId;
  double cantidad;
  String descripcion;
  DateTime fechaExpiracion;
  double precio;
  Produccion produccion;
  Moneda moneda;
  UniMedida uniMedida;

  OfertaDetalleRequest({
    required this.produccionId,
    required this.monedaId,
    required this.uniMedidaId,
    required this.cantidad,
    required this.descripcion,
    required this.fechaExpiracion,
    required this.precio,
    required this.produccion,
    required this.moneda,
    required this.uniMedida,
  });

  Map<String, dynamic> toJson() => {
        "produccion_id": produccionId,
        "moneda_id": monedaId,
        "uni_medida_id": uniMedidaId,
        "cantidad": cantidad,
        "descripcion": descripcion,
        "fecha_expiracion":
            "${fechaExpiracion.year.toString().padLeft(4, '0')}-${fechaExpiracion.month.toString().padLeft(2, '0')}-${fechaExpiracion.day.toString().padLeft(2, '0')}",
        "precio": precio,
      };
}
