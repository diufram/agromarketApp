import 'package:agromarket_app/data/datasource/auth_repository_impl.dart';
import 'package:agromarket_app/data/datasource/local_repository_impl.dart';
import 'package:agromarket_app/domain/repository/auth_repository_intr.dart';
import 'package:agromarket_app/domain/repository/local_repository_intr.dart';
import 'package:agromarket_app/services/globals.dart';
import 'package:agromarket_app/ui/screens/productor/produccion/produccion_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRepositoryInterface>(
          create: (_) => AuthRepositoryImpl(),
        ),
        Provider<LocalRepositoryInterface>(
          create: (_) => LocalRepositoryImpl(),
        ),
        /*        Provider<QuoteRepositoryInterface>(
          create: (_) => QuoteRepositoryImpl(),
        ),
        Provider<CompanyRepositoryInterface>(
          create: (_) => CompanyRepositoryImpl(),
        ),
        Provider<SubscriptionRepositoryInterface>(
          create: (_) => SubscriptionRepositoryImpl(),
        ),
        ChangeNotifierProvider(
            create: (_) => HomeBloc(
                localRepositoryInterface:
                    context.read<LocalRepositoryInterface>())),
        ChangeNotifierProvider(
            create: (_) => QuoteBloc(
                  quoteRepositoryInterface:
                      context.read<QuoteRepositoryInterface>(),
                  localRepositoryInterface:
                      context.read<LocalRepositoryInterface>(),
                )),
        ChangeNotifierProvider(
            create: (_) => CompanyBloc(
                  companyRepositoryInterface:
                      context.read<CompanyRepositoryInterface>(),
                  localRepositoryInterface:
                      context.read<LocalRepositoryInterface>(),
                )), */
      ],
      child: Builder(builder: (newContext) {
        return ScreenUtilInit(
          designSize: const Size(360, 900),
          minTextAdapt: true,
          builder: (_, __) {
            return MaterialApp(
              builder: FToastBuilder(),
              title: 'QUOTE',
              theme: poppins,
              debugShowCheckedModeBanner: false,
              home: ProduccionScreen(),
            );
          },
        );
      }),
    );
  }
}
