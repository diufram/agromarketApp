import 'package:agromarket_app/services/globals.dart';
import 'package:agromarket_app/ui/screens/widget/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            CustomCard(
                color: backgroundOptional1,
                height: 200.h,
                width: MediaQuery.sizeOf(context).width,
                child: Text("data"))
          ],
        )));
  }
}
