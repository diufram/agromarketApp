import 'package:agromarket_app/domain/request/produccion_request.dart';
import 'package:agromarket_app/services/globals.dart';
import 'package:agromarket_app/ui/screens/widget/custom_card.dart';
import 'package:agromarket_app/ui/screens/widget/custom_dropdownmenu.dart';
import 'package:agromarket_app/ui/screens/widget/custom_textfield.dart';
import 'package:agromarket_app/ui/screens/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

class ProduccionScreen extends StatelessWidget {
  ProduccionScreen({super.key});
  final TextEditingController controller = TextEditingController();
  Stream<List<Produccion>> get produccionStream async* {
    while (true) {
      final response = await http.get(Uri.parse('$baseURL/produccions'));

      if (response.statusCode == 200) {
        // Parsear el JSON y convertirlo en List<Produccion>
        List<Produccion> producciones = produccionFromJson(response.body);
        yield producciones;
      } else {
        throw Exception('Error al cargar producciones');
      }
    }
  }

  Stream<List<Produccion>> get getAllProduccionCreate async* {
    while (true) {
      final response = await http.get(Uri.parse('$baseURL/produccions'));

      if (response.statusCode == 200) {
        // Parsear el JSON y convertirlo en List<Produccion>
        List<Produccion> producciones = produccionFromJson(response.body);
        yield producciones;
      } else {
        throw Exception('Error al cargar producciones');
      }
    }
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
              Center(
                child: StreamBuilder<List<Produccion>>(
                  stream: produccionStream, // Cambia a tu stream actualizado
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Produccion>> snapshot) {
                    // Mostrar un indicador de carga mientras se obtienen datos
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else if (!snapshot.hasData) {
                      return const Text("No se encontraron datos");
                    } else {
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
                    }
                  },
                ),
              ),
              Positioned(
                right: 15.sp,
                bottom: 15.sp,
                child: ButtonAdd(
                  height: 400.h,
                ),
              )
            ],
          ),
        ));
  }
}

class ButtonAdd extends StatelessWidget {
  ButtonAdd({
    super.key,
    required this.height,
  });
  final double height;

  TextEditingController controller = TextEditingController();
  List<Producto> list = [
    Producto(id: 1, nombre: "papa"),
    Producto(id: 2, nombre: "azzoz"),
  ];

  String selectedValue = '';

  void handleSelection(String value) {
    selectedValue = value;
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
                height: height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Selected Value: $selectedValue'),
                    Text(
                      "Crear Produccion",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomTextField(
                          width: MediaQuery.sizeOf(context).width * 0.48,
                          height: 50.h,
                          textController: controller,
                          isObscureText: false,
                          hintText: "Area",
                          type: TextInputType.number,
                        ),
                        CustomTextField(
                            width: MediaQuery.sizeOf(context).width * 0.48,
                            height: 50.h,
                            textController: controller,
                            isObscureText: false,
                            hintText: "Cantidad ",
                            type: TextInputType.number)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomDropDownMenu(
                          textController: controller,
                          width: MediaQuery.sizeOf(context).width * 0.48,
                          height: 50.h,
                          label: 'Propiedad',
                          uk: UniqueKey(),
                          list: list,
                          onSelected: handleSelection,
                        ),
                        CustomDropDownMenu(
                          textController: controller,
                          width: MediaQuery.sizeOf(context).width * 0.48,
                          height: 50.h,
                          label: 'Producto',
                          uk: UniqueKey(),
                          list: list,
                          onSelected: handleSelection,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomDropDownMenu(
                          textController: controller,
                          width: MediaQuery.sizeOf(context).width * 0.48,
                          height: 50.h,
                          label: 'Unidad Medida',
                          uk: UniqueKey(),
                          list: list,
                          onSelected: handleSelection,
                        ),
                        CustomDropDownMenu(
                          textController: controller,
                          width: MediaQuery.sizeOf(context).width * 0.48,
                          height: 50.h,
                          label: 'Temporada',
                          uk: UniqueKey(),
                          onSelected: handleSelection,
                          list: list,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomDropDownMenu(
                          textController: controller,
                          width: MediaQuery.sizeOf(context).width * 0.48,
                          height: 50.h,
                          label: 'Fecha Siembra',
                          uk: UniqueKey(),
                          onSelected: handleSelection,
                          list: list,
                        ),
                        CustomDropDownMenu(
                          textController: controller,
                          width: MediaQuery.sizeOf(context).width * 0.48,
                          height: 50.h,
                          label: 'Fecha Cosecha',
                          uk: UniqueKey(),
                          onSelected: handleSelection,
                          list: list,
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.sp),
                      child: CustomButton(
                        onPressed: () {},
                        title: "agregar",
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
