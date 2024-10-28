import 'dart:convert';

List<Produccion> produccionFromJson(String str) =>
    List<Produccion>.from(json.decode(str).map((x) => Produccion.fromJson(x)));

String produccionToJson(List<Produccion> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Produccion {
  final int id;
  final double area;
  final double cantidad;
  final bool estado;
  final DateTime fechaCosecha;
  final DateTime fechaCreacion;
  final DateTime fechaSiembra;
  final Propiedad propiedad;
  final Producto producto;
  final Temporada temporada;
  final Producto uniMedida;

  Produccion({
    required this.id,
    required this.area,
    required this.cantidad,
    required this.estado,
    required this.fechaCosecha,
    required this.fechaCreacion,
    required this.fechaSiembra,
    required this.propiedad,
    required this.producto,
    required this.temporada,
    required this.uniMedida,
  });

  factory Produccion.fromJson(Map<String, dynamic> json) {
    return Produccion(
      id: json["id"] as int,
      area:
          (json["area"] as num).toDouble(), // Convertir a double usando as num
      cantidad: (json["cantidad"] as num)
          .toDouble(), // Convertir a double usando as num
      estado: json["estado"] as bool,
      fechaCosecha: DateTime.parse(json["fecha_cosecha"] as String),
      fechaCreacion: DateTime.parse(json["fecha_creacion"] as String),
      fechaSiembra: DateTime.parse(json["fecha_siembra"] as String),
      propiedad: Propiedad.fromJson(json["propiedad"] as Map<String, dynamic>),
      producto: Producto.fromJson(json["producto"] as Map<String, dynamic>),
      temporada: Temporada.fromJson(json["temporada"] as Map<String, dynamic>),
      uniMedida: Producto.fromJson(json["uni_medida"] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "area": area,
        "cantidad": cantidad,
        "estado": estado,
        "fecha_cosecha":
            "${fechaCosecha.year.toString().padLeft(4, '0')}-${fechaCosecha.month.toString().padLeft(2, '0')}-${fechaCosecha.day.toString().padLeft(2, '0')}",
        "fecha_creacion":
            "${fechaCreacion.year.toString().padLeft(4, '0')}-${fechaCreacion.month.toString().padLeft(2, '0')}-${fechaCreacion.day.toString().padLeft(2, '0')}",
        "fecha_siembra":
            "${fechaSiembra.year.toString().padLeft(4, '0')}-${fechaSiembra.month.toString().padLeft(2, '0')}-${fechaSiembra.day.toString().padLeft(2, '0')}",
        "propiedad": propiedad.toJson(),
        "producto": producto.toJson(),
        "temporada": temporada.toJson(),
        "uni_medida": uniMedida.toJson(),
      };
}

class Producto {
  final int id;
  final String nombre;

  Producto({
    required this.id,
    required this.nombre,
  });

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
      };
}

class Propiedad {
  final int id;
  final double area;
  final String descripcion;
  final double lat;
  final double lon;

  Propiedad({
    required this.id,
    required this.area,
    required this.descripcion,
    required this.lat,
    required this.lon,
  });

  factory Propiedad.fromJson(Map<String, dynamic> json) => Propiedad(
        id: json["id"],
        area: json["area"]?.toDouble(),
        descripcion: json['descripcion'],
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "area": area,
        "descripcion": descripcion,
        "lat": lat,
        "lon": lon,
      };
}

class Temporada {
  final int id;
  final DateTime fechaFin;
  final DateTime fechaInicio;

  Temporada({
    required this.id,
    required this.fechaFin,
    required this.fechaInicio,
  });

  factory Temporada.fromJson(Map<String, dynamic> json) => Temporada(
        id: json["id"],
        fechaFin: DateTime.parse(json["fecha_fin"]),
        fechaInicio: DateTime.parse(json["fecha_inicio"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fecha_fin":
            "${fechaFin.year.toString().padLeft(4, '0')}-${fechaFin.month.toString().padLeft(2, '0')}-${fechaFin.day.toString().padLeft(2, '0')}",
        "fecha_inicio":
            "${fechaInicio.year.toString().padLeft(4, '0')}-${fechaInicio.month.toString().padLeft(2, '0')}-${fechaInicio.day.toString().padLeft(2, '0')}",
      };
}
