import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:agromarket_app/domain/request/oferta_request.dart';
import 'package:agromarket_app/domain/response/produccion_response.dart';
import 'package:agromarket_app/domain/response/moneda_response.dart';
import 'package:agromarket_app/domain/response/oferta_response.dart';
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

class OfertaScreen extends StatefulWidget {
  const OfertaScreen({super.key});

  @override
  State<OfertaScreen> createState() => _ProduccionScreenState();
}

class _ProduccionScreenState extends State<OfertaScreen> {
  TextEditingController fechaExpPController = TextEditingController();
  TextEditingController descripcionPController = TextEditingController();

  Stream<List<Oferta>> get ofertaStream async* {
    while (true) {
      try {
        // Realiza la solicitud con un timeout de 3 segundos
        final response = await http
            .get(Uri.parse('$baseURL/ofertas'))
            .timeout(const Duration(seconds: 3));

        if (response.statusCode == 200) {
          // Parsear JSON y convertirlo en List<Oferta>
          List<Oferta> ofertas = ofertaFromJson(response.body);
          print("Ofertas: ${ofertas.length}");
          yield ofertas; // Envía la lista de ofertas al Stream
        } else {
          print("Error al cargar ofertas: Código ${response.statusCode}");
          throw Exception('Error al cargar ofertas');
        }
      } on TimeoutException catch (_) {
        print('Error: Tiempo de espera agotado');
        yield []; // Devuelve una lista vacía o maneja el error como prefieras
      } on SocketException catch (_) {
        print('Error: No se pudo conectar al servidor');
        yield []; // Devuelve una lista vacía para manejar el error en el Stream
      } catch (e) {
        print('Error específico: $e');
        yield []; // Envía una lista vacía en caso de error general
      }

      // Espera 5 segundos antes de realizar la siguiente solicitud
      await Future.delayed(const Duration(seconds: 5));
    }
  }

  DateTime? fechaExpP;
  List<OfertaDetalleRequest> ofertaDetalles = [];

  Future<void> createOferta() async {
    OfertaRequest request = OfertaRequest(
        descripcion: descripcionPController.text,
        fechaExpiracion: fechaExpP!,
        ofertaDetalle: ofertaDetalles);

    await http.post(Uri.parse('$baseURL/ofertas'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()));

    descripcionPController.clear();
    fechaExpPController.clear();
  }

  Future<void> _selectDateFechaExpP(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Fecha inicial
      firstDate: DateTime(2000), // Fecha mínima
      lastDate: DateTime(2100), // Fecha máxima
    );
    if (picked != null && picked != fechaExpP) {
      setState(() {
        fechaExpP = picked;

        fechaExpPController.text = picked.toString().split(" ")[0];
      });
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
          title: Text("Ofertas",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.white)),
          centerTitle: true,
          backgroundColor: backgroundPrimary,
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      if (ofertaDetalles.isEmpty) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.sp)),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: 150.h,
                              maxWidth: 550.w,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.sp),
                              child: Center(
                                child: Text(
                                  "No hay ofertas aun añadidas",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.sp)),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: 700.h,
                              maxWidth: 550.w,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: ofertaDetalles.length,
                                    itemBuilder: (context, index) {
                                      return CustomCard(
                                        color: backgroundOptional1,
                                        height: 95.sp,
                                        child: DetalleOferta(
                                            ofertaDetalle:
                                                ofertaDetalles[index]),
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.sp),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomTextField(
                                        textController: descripcionPController,
                                        isObscureText: false,
                                        hintText: "Descripcion",
                                        type: TextInputType.text,
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.97,
                                        maxLines: 3,
                                      ),
                                      SizedBox(
                                        height: 10.sp,
                                      ),
                                      CustomTextField(
                                        textController: fechaExpPController,
                                        isObscureText: false,
                                        hintText: "Fecha Expiracion",
                                        type: TextInputType.datetime,
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.97,
                                        onTap: () =>
                                            _selectDateFechaExpP(context),
                                      ),
                                      SizedBox(
                                        height: 10.sp,
                                      ),
                                      CustomButton(
                                        onPressed: () async {
                                          await createOferta();
                                          Navigator.pop(context);
                                        },
                                        title: "Guardar",
                                        height: 50.h,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  );
                },
                icon: Icon(
                  Icons.date_range_rounded,
                  color: Colors.white,
                  size: 30.sp,
                ))
          ],
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Center(
                child: StreamBuilder<List<Oferta>>(
                  stream: ofertaStream, // Cambia a tu stream actualizado
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Oferta>> snapshot) {
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
                      return Text("Error: ${snapshot.error}");
                    } else if (!snapshot.hasData) {
                      return const Text("No se encontraron datos");
                    } else if (snapshot.data!.isNotEmpty) {
                      // Mostrar la lista de producciones obtenida
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final oferta = snapshot.data![index];
                          return CustomCard(
                            color: backgroundOptional1,
                            height: 120.sp,
                            child: Detail(
                              oferta: oferta,
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Text(
                          "No se agregaron Ofertas aun",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    }
                  },
                ),
              ),
              Positioned(
                right: 15.sp,
                bottom: 15.sp,
                child: ButtonAdd(
                  height: 490.h,
                  ofertaDetalles: ofertaDetalles,
                ),
              ),
            ],
          ),
        ));
  }
}

class DetalleOferta extends StatelessWidget {
  const DetalleOferta({
    super.key,
    required this.ofertaDetalle,
  });

  final OfertaDetalleRequest ofertaDetalle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(ofertaDetalle.produccion.producto.nombre,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Propiedad:",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.bold)),
            Text(ofertaDetalle.produccion.propiedad.descripcion,
                style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Cantidad:",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.bold)),
            Text(
                ofertaDetalle.cantidad.toString() +
                    ofertaDetalle.uniMedida.nombre,
                style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Fecha Expiracion:",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.bold)),
            Text(ofertaDetalle.fechaExpiracion.toString().split(" ")[0],
                style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ],
    );
  }
}

class ButtonAdd extends StatefulWidget {
  const ButtonAdd({
    super.key,
    required this.height,
    required this.ofertaDetalles,
  });
  final double height;

  final List<OfertaDetalleRequest> ofertaDetalles;

  @override
  State<ButtonAdd> createState() => _ButtonAddState();
}

class _ButtonAddState extends State<ButtonAdd> {
  List<Moneda> listMonedas = [];
  List<Produccion> listProducciones = [];
  List<UniMedida> listUniMedidas = [];
  TextEditingController descripcionController = TextEditingController();
  TextEditingController fechaExpiracionController = TextEditingController();
  TextEditingController cantidadController = TextEditingController();
  TextEditingController precioController = TextEditingController();

  Produccion? produccionSelected;
  UniMedida? uniMedidaSelected;
  Moneda? monedaSelected;

  void clearAll() {
    descripcionController.clear();
    fechaExpiracionController.clear();
    cantidadController.clear();
    precioController.clear();
  }

  void addCarrito() {
    widget.ofertaDetalles.add(
      OfertaDetalleRequest(
          produccionId: produccionSelected!.id,
          monedaId: monedaSelected!.id,
          uniMedidaId: uniMedidaSelected!.id,
          cantidad: double.parse(cantidadController.text),
          descripcion: descripcionController.text,
          fechaExpiracion: fechaExpiracionSelected!,
          precio: double.parse(
            precioController.text,
          ),
          produccion: produccionSelected!,
          moneda: monedaSelected!,
          uniMedida: uniMedidaSelected!),
    );
    clearAll();
    Navigator.pop(context);
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

  Future<List<Moneda>> getMonedas() async {
    final response = await http.get(Uri.parse('$baseURL/monedas'));

    if (response.statusCode == 200) {
      List<Moneda> monedas = monedaFromJson(response.body);

      print("Monedas ${monedas.length}");
      setState(() {
        listMonedas = monedas;
      });
      return monedas;
    } else {
      throw Exception('Error al cargar producciones');
    }
  }

  Future<List<Produccion>> getProducciones() async {
    final response = await http.get(Uri.parse('$baseURL/produccions'));

    if (response.statusCode == 200) {
      // Parsear el JSON y convertirlo en List<Produccion>
      if (response.body.isEmpty) {}
      List<Produccion> producciones = produccionFromJson(response.body);
      setState(() {
        listProducciones = producciones;
      });
      return producciones;
    } else {
      throw Exception('Error al cargar producciones');
    }
  }

  DateTime? fechaExpiracionSelected;
  // Método para mostrar el selector de calendario
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Fecha inicial
      firstDate: DateTime(2000), // Fecha mínima
      lastDate: DateTime(2100), // Fecha máxima
    );
    if (picked != null && picked != fechaExpiracionSelected) {
      setState(() {
        fechaExpiracionSelected = picked;
        fechaExpiracionController.text = picked.toString().split(" ")[0];
      });
    }
  }

  @override
  void initState() {
    getProducciones();
    getMonedas();
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
                      "Crear Oferta",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    CustomDropDownMenu<Produccion>(
                      width: MediaQuery.sizeOf(context).width * 0.97,
                      label: 'Produccion',
                      uk: UniqueKey(),
                      list: listProducciones,
                      onSelected: (Produccion selected) {
                        produccionSelected = selected;
                        print('Producto seleccionado: ${selected.id}');
                      },
                      displayFieldExtractor: (Produccion produccion) =>
                          "${produccion.producto.nombre} - ${produccion.propiedad.descripcion}",
                    ),
                    CustomTextField(
                      maxLines: 3,
                      width: MediaQuery.sizeOf(context).width * 0.97,
                      textController: descripcionController,
                      isObscureText: false,
                      hintText: "Descripcion",
                      type: TextInputType.text,
                    ),
                    CustomTextField(
                      width: MediaQuery.sizeOf(context).width * 0.97,
                      textController: fechaExpiracionController,
                      isObscureText: false,
                      hintText: "Fecha Expiracion",
                      type: TextInputType.datetime,
                      onTap: () => _selectDate(context),
                      readOnly: true,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomTextField(
                          width: MediaQuery.sizeOf(context).width * 0.48,
                          textController: cantidadController,
                          isObscureText: false,
                          hintText: "Cantidad",
                          type: TextInputType.number,
                        ),
                        CustomDropDownMenu<UniMedida>(
                          width: MediaQuery.sizeOf(context).width * 0.48,
                          label: 'Unidad Medida',
                          uk: UniqueKey(),
                          list: listUniMedidas,
                          onSelected: (UniMedida selected) {
                            uniMedidaSelected = selected;
                            print('Producto seleccionado: ${selected.id}');
                          },
                          displayFieldExtractor: (UniMedida producto) =>
                              producto.nombre,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomTextField(
                          width: MediaQuery.sizeOf(context).width * 0.48,
                          textController: precioController,
                          isObscureText: false,
                          hintText: "Precio",
                          type: TextInputType.number,
                        ),
                        CustomDropDownMenu<Moneda>(
                          width: MediaQuery.sizeOf(context).width * 0.48,
                          label: 'Moneda',
                          uk: UniqueKey(),
                          list: listMonedas,
                          onSelected: (Moneda selected) {
                            monedaSelected = selected;
                            print('Uni Medida seleccionado: ${selected.id}');
                          },
                          displayFieldExtractor: (Moneda producto) =>
                              producto.nombre,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.sp),
                      child: CustomButton(
                        onPressed: addCarrito,
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
    required this.oferta,
  });
  final Oferta oferta;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(oferta.id.toString(),
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.white)),
        RichText(
          text: TextSpan(
            style: Theme.of(context)
                .textTheme
                .bodyMedium, // Estilo general del texto
            children: [
              TextSpan(
                text: "Descripcion: ",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              TextSpan(
                  text: oferta.descripcion,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium // Texto de la descripción
                  ),
            ],
          ),
          maxLines: 1, // Limita a una línea
          overflow:
              TextOverflow.ellipsis, // Muestra "..." si el texto es muy largo
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Fecha de Expiracion:",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold)),
            Text(
              oferta.fechaExpiracion.toString().split(" ")[0],
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ],
    );
  }
}
