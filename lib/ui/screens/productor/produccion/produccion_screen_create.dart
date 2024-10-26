/* import 'package:agromarket_app/services/globals.dart';
import 'package:agromarket_app/ui/screens/widget/custom_dropdownmenu.dart';
import 'package:agromarket_app/ui/screens/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProduccionScreenCreate extends StatelessWidget {
  ProduccionScreenCreate({super.key});
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Produccion",
              style: Theme.of(context).textTheme.headlineSmall),
          centerTitle: true,
          backgroundColor: backgroundPrimary,
        ),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 10.sp,
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
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomDropDownMenu(
                    textController: controller,
                    width: MediaQuery.sizeOf(context).width * 0.48,
                    height: 50.h,
                    label: 'Propiedad',
                  ),
                  CustomDropDownMenu(
                    textController: controller,
                    width: MediaQuery.sizeOf(context).width * 0.48,
                    height: 50.h,
                    label: 'Producto',
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomDropDownMenu(
                    textController: controller,
                    width: MediaQuery.sizeOf(context).width * 0.48,
                    height: 50.h,
                    label: 'Unidad Medida',
                  ),
                  CustomDropDownMenu(
                    textController: controller,
                    width: MediaQuery.sizeOf(context).width * 0.48,
                    height: 50.h,
                    label: 'Temporada',
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomDropDownMenu(
                    textController: controller,
                    width: MediaQuery.sizeOf(context).width * 0.48,
                    height: 50.h,
                    label: 'Fecha Siembra',
                  ),
                  CustomDropDownMenu(
                    textController: controller,
                    width: MediaQuery.sizeOf(context).width * 0.48,
                    height: 50.h,
                    label: 'Fecha Cosecha',
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
 */