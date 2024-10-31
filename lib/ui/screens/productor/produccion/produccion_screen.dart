import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:agromarket_app/domain/request/produccion_request.dart';
import 'package:agromarket_app/domain/response/persona_response.dart';
import 'package:agromarket_app/domain/response/produccion_response.dart';
import 'package:agromarket_app/domain/response/producto_response.dart';
import 'package:agromarket_app/domain/response/temporada_response.dart';
import 'package:agromarket_app/domain/response/uni_medida_response.dart';
import 'package:agromarket_app/services/globals.dart';
import 'package:agromarket_app/ui/screens/widget/custom_card.dart';
import 'package:agromarket_app/ui/screens/widget/custom_dropdownmenu.dart';
import 'package:agromarket_app/ui/screens/widget/custom_textfield.dart';
import 'package:agromarket_app/ui/screens/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class ProduccionScreen extends StatefulWidget {
  const ProduccionScreen({super.key});

  @override
  State<ProduccionScreen> createState() => _ProduccionScreenState();
}

class _ProduccionScreenState extends State<ProduccionScreen> {
  Stream<List<Produccion>> get produccionStream async* {
    while (true) {
      try {
        final response = await http
            .get(Uri.parse('$baseURL/produccions'))
            .timeout(const Duration(seconds: 3)); // Timeout de 3 segundos

        if (response.statusCode == 200) {
          if (response.body.isNotEmpty) {
            List<Produccion> producciones = produccionFromJson(response.body);
            yield producciones;
          } else {
            yield [];
          }
        } else {
          throw Exception(
              'Error al cargar producciones: Código ${response.statusCode}');
        }
      } on TimeoutException {
        print('Error: Tiempo de espera agotado');
        yield []; // Devuelve una lista vacía o maneja el error como prefieras
      } on SocketException {
        print('Error: No se pudo conectar al servidor');
        yield []; // Opcional: Devuelve una lista vacía para manejar el error en el Stream
      } catch (e) {
        print('Error específico: $e');
        yield [];
      }

      await Future.delayed(const Duration(seconds: 5));
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Produccion",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.white)),
          centerTitle: true,
          backgroundColor: backgroundPrimary,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              StreamBuilder<List<Produccion>>(
                stream: produccionStream, // Cambia a tu stream actualizado
                builder: (BuildContext context,
                    AsyncSnapshot<List<Produccion>> snapshot) {
                  // Mostrar un indicador de carga mientras se obtienen datos
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SizedBox(
                        height: 130.h,
                        width: 130.w,
                        child: Lottie.asset(
                          'assets/loading.json',
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text(
                      "Error: ${snapshot.error}",
                      textAlign: TextAlign.center,
                    ));
                  } else if (!snapshot.hasData) {
                    return const Text("No se encontraron datos");
                  } else if (snapshot.data!.isNotEmpty) {
                    // Mostrar la lista de producciones obtenida
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final produccion = snapshot.data![index];
                        return CustomCard(
                          color: backgroundOptional1,
                          height: 120.sp,
                          child: Detail(
                            produccion: produccion,
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text(
                        "No se agregaron Producciones aun",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
                  }
                },
              ),
              Positioned(
                right: 15.sp,
                bottom: 15.sp,
                child: ButtonAdd(
                  height: 500.h,
                ),
              )
            ],
          ),
        ));
  }
}

class ButtonAdd extends StatefulWidget {
  const ButtonAdd({
    super.key,
    required this.height,
  });
  final double height;

  @override
  State<ButtonAdd> createState() => _ButtonAddState();
}

class _ButtonAddState extends State<ButtonAdd> {
  List<Producto> listProductos = [];

  List<Temporada> listTemporadas = [];

  List<UniMedida> listUniMedidas = [];

  List<Propiedad> listPropiedades = [];

  TextEditingController cantidadController = TextEditingController();
  Producto? productoSelected;
  Propiedad? propiedadSelected;
  UniMedida? uniMedidaSelected;
  Temporada? temporadaSelected;

  Future<List<Propiedad>> getPropiedadesPersona() async {
    final response = await http.get(Uri.parse('$baseURL/personas/2'));

    if (response.statusCode == 200) {
      Persona persona = personaFromJson(response.body);
      List<Propiedad> propiedades = persona.propiedades;
      listPropiedades = propiedades;
      print("Propiedades ${propiedades.length}");
      setState(() {
        listPropiedades = propiedades;
      });
      return propiedades;
    } else {
      throw Exception('Error al cargar producciones');
    }
  }

  Future<List<UniMedida>> getUniMedidas() async {
    final response = await http.get(Uri.parse('$baseURL/uni-medidas'));

    if (response.statusCode == 200) {
      List<UniMedida> unidadMedidas = uniMedidaFromJson(response.body);

      print("Unidad Medidas ${unidadMedidas.length}");
      setState(() {
        listUniMedidas = unidadMedidas;
      });
      return unidadMedidas;
    } else {
      throw Exception('Error al cargar producciones');
    }
  }

  Future<List<Producto>> getProductos() async {
    final response = await http.get(Uri.parse('$baseURL/productos'));

    if (response.statusCode == 200) {
      List<Producto> productos = productoFromJson(response.body);
      setState(() {
        listProductos = productos;
      });
      print("Productos ${productos.length}");
      return productos;
    } else {
      throw Exception('Error al cargar producciones');
    }
  }

  Future<List<Temporada>> getTemporadas() async {
    final response = await http.get(Uri.parse('$baseURL/temporadas'));

    if (response.statusCode == 200) {
      List<Temporada> temporadas = temporadaFromJson(response.body);

      print("Temporadas ${temporadas.length}");
      setState(() {
        listTemporadas = temporadas;
      });
      return temporadas;
    } else {
      throw Exception('Error al cargar producciones');
    }
  }

  TextEditingController fechaCosechaController = TextEditingController();
  TextEditingController fechaSiembraController = TextEditingController();
  DateTime? fechaCosechaSelected;
  DateTime? fechaSiembraSelected;
  // Método para mostrar el selector de calendario
  Future<void> _selectDateSiembra(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Fecha inicial
      firstDate: DateTime(2000), // Fecha mínima
      lastDate: DateTime(2100), // Fecha máxima
    );
    if (picked != null && picked != fechaSiembraSelected) {
      setState(() {
        fechaSiembraSelected = picked;

        fechaSiembraController.text = picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> _selectDateCosecha(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Fecha inicial
      firstDate: DateTime(2000), // Fecha mínima
      lastDate: DateTime(2100), // Fecha máxima
    );
    if (picked != null && picked != fechaCosechaSelected) {
      setState(() {
        fechaCosechaSelected = picked;

        fechaCosechaController.text = picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> createProduccion() async {
    ProduccionRequest request = ProduccionRequest(
        cantidad: double.parse(cantidadController.text),
        fechaCosecha: fechaCosechaSelected!,
        fechaSiembra: fechaSiembraSelected!,
        propiedadId: propiedadSelected!.id,
        temporadaId: temporadaSelected!.id,
        productoId: productoSelected!.id,
        uniMedidaId: uniMedidaSelected!.id);

    await http.post(Uri.parse('$baseURL/produccions'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()));
  }

  @override
  void initState() {
    getProductos();
    getTemporadas();
    getPropiedadesPersona();
    getUniMedidas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context)
                    .viewInsets
                    .bottom, // Ajuste para el teclado
              ),
              child: SizedBox(
                height: widget.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Crear Produccion",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    CustomDropDownMenu<Propiedad>(
                      width: MediaQuery.sizeOf(context).width * 0.97,
                      label: 'Propiedad',
                      uk: UniqueKey(),
                      list: listPropiedades,
                      onSelected: (Propiedad selected) {
                        propiedadSelected = selected;
                        print('Propiedad seleccionado: ${selected.id}');
                      },
                      displayFieldExtractor: (Propiedad producto) =>
                          producto.descripcion,
                    ),
                    CustomDropDownMenu<Temporada>(
                      width: MediaQuery.sizeOf(context).width * 0.97,
                      label: 'Temporada',
                      uk: UniqueKey(),
                      list: listTemporadas,
                      onSelected: (Temporada selected) {
                        temporadaSelected = selected;
                        print('Temporada seleccionado: ${selected.id}');
                      },
                      displayFieldExtractor: (Temporada producto) =>
                          "${producto.fechaFin.toString().split(" ")[0]} ${producto.fechaFin.toString().split(" ")[0]}",
                    ),
                    CustomTextField(
                      width: MediaQuery.sizeOf(context).width * 0.97,
                      textController: fechaSiembraController,
                      isObscureText: false,
                      hintText: "Fecha de Siembra",
                      type: TextInputType.datetime,
                      onTap: () => _selectDateSiembra(context),
                      readOnly: true,
                    ),
                    CustomTextField(
                      width: MediaQuery.sizeOf(context).width * 0.97,
                      textController: fechaCosechaController,
                      isObscureText: false,
                      hintText: "Fecha de Cosecha",
                      type: TextInputType.datetime,
                      onTap: () => _selectDateCosecha(context),
                      readOnly: true,
                    ),
                    CustomDropDownMenu<Producto>(
                      width: MediaQuery.sizeOf(context).width * 0.97,
                      label: 'Producto',
                      uk: UniqueKey(),
                      list: listProductos,
                      onSelected: (Producto selected) {
                        productoSelected = selected;
                        print('Producto seleccionado: ${selected.id}');
                      },
                      displayFieldExtractor: (Producto producto) =>
                          producto.nombre,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomTextField(
                            width: MediaQuery.sizeOf(context).width * 0.48,
                            textController: cantidadController,
                            isObscureText: false,
                            hintText: "Cantidad ",
                            type: TextInputType.number),
                        CustomDropDownMenu<UniMedida>(
                          width: MediaQuery.sizeOf(context).width * 0.48,
                          label: 'Unidad Medida',
                          uk: UniqueKey(),
                          list: listUniMedidas,
                          onSelected: (UniMedida selected) {
                            uniMedidaSelected = selected;
                            print('Uni Medida seleccionado: ${selected.id}');
                          },
                          displayFieldExtractor: (UniMedida producto) =>
                              producto.nombre,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.sp),
                      child: CustomButton(
                        onPressed: () async {
                          await createProduccion();
                          Navigator.pop(context);
                        },
                        title: "Agregar",
                        height: 50.sp,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: EdgeInsets.all(20.sp), // Ajusta el tamaño del botón
        backgroundColor:
            backgroundPrimary, // Cambia el color de fondo si lo deseas
      ),
      child: const Icon(
        Icons.add,
        color: Colors.white, // Cambia el color del ícono si lo deseas
      ),
    );
  }
}

class Detail extends StatelessWidget {
  const Detail({
    super.key,
    required this.produccion,
  });
  final Produccion produccion;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(produccion.producto.nombre,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.white)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Propiedad:",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold)),
            Text(produccion.propiedad.descripcion,
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Cantidad:",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold)),
            Text(produccion.cantidad.toString() + produccion.uniMedida.nombre,
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Fecha Cosecha:",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold)),
            Text(produccion.fechaCosecha.toString().split(" ")[0],
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ],
    );
  }
}
