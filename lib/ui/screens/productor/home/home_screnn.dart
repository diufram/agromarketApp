import 'package:agromarket_app/services/globals.dart';
import 'package:agromarket_app/ui/screens/productor/oferta/oferta_screen.dart';
import 'package:agromarket_app/ui/screens/productor/produccion/produccion_screen.dart';
import 'package:agromarket_app/ui/screens/widget/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Productor",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.white)),
          centerTitle: true,
          backgroundColor: backgroundPrimary,
        ),
        body: SafeArea(
            child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProduccionScreen()));
              },
              child: CustomCard(
                color: backgroundOptional1,
                height: 150.h,
                width: MediaQuery.sizeOf(context).width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Producciones",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                    Lottie.asset('assets/production.json',
                        width: 100.w, height: 100.h),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OfertaScreen()));
              },
              child: CustomCard(
                color: backgroundOptional1,
                height: 150.h,
                width: MediaQuery.sizeOf(context).width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Ofertas",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                    Lottie.asset('assets/production.json',
                        width: 100.w, height: 100.h),
                  ],
                ),
              ),
            )
          ],
        )));
  }
}
