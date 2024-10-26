import 'package:agromarket_app/services/globals.dart';
import 'package:agromarket_app/ui/screens/productor/produccion/produccion_screen_create.dart';
import 'package:agromarket_app/ui/screens/widget/custom_card.dart';
import 'package:agromarket_app/ui/screens/widget/custom_dropdownmenu.dart';
import 'package:agromarket_app/ui/screens/widget/custom_textfield.dart';
import 'package:agromarket_app/ui/screens/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProduccionScreen extends StatelessWidget {
  ProduccionScreen({super.key});
  final TextEditingController controller = TextEditingController();
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
              Column(
                children: [
                  CustomCard(
                    color: backgroundOptional1,
                    height: 120.sp,
                    child: const Detail(),
                  )
                ],
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
  final TextEditingController controller = TextEditingController();

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
                          type: TextInputType.text,
                        ),
                        CustomTextField(
                            width: MediaQuery.sizeOf(context).width * 0.48,
                            height: 50.h,
                            textController: controller,
                            isObscureText: false,
                            hintText: "Cantidad ",
                            type: TextInputType.text)
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
                        ),
                        CustomDropDownMenu(
                          textController: controller,
                          width: MediaQuery.sizeOf(context).width * 0.48,
                          height: 50.h,
                          label: 'Producto',
                          uk: UniqueKey(),
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
                        ),
                        CustomDropDownMenu(
                          textController: controller,
                          width: MediaQuery.sizeOf(context).width * 0.48,
                          height: 50.h,
                          label: 'Temporada',
                          uk: UniqueKey(),
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
                        ),
                        CustomDropDownMenu(
                          textController: controller,
                          width: MediaQuery.sizeOf(context).width * 0.48,
                          height: 50.h,
                          label: 'Fecha Cosecha',
                          uk: UniqueKey(),
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
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Piña",
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
            Text("Rancho San Simon",
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
            Text("10 t", style: Theme.of(context).textTheme.bodyMedium),
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
            Text("2024-07-04", style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ],
    );
  }
}
