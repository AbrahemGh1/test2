import 'package:flareline_crm/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/theme/global_theme.dart';

void main() {
  //GoogleFonts.config.allowRuntimeFetching = false;
  runApp(const MyApp());
  SemanticsBinding.instance.ensureSemantics();
  RendererBinding.instance.ensureSemantics();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'المعتمد',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: CrmColors.primary),
      //   useMaterial3: true,
      // ),
      theme: GlobalTheme.lightThemeData,
      // theme: ThemeData(
      //   textTheme: GoogleFonts.almaraiTextTheme(),
      // ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/signIn',
      onGenerateRoute: (settings) =>
          RouteConfiguration.onGenerateRoute(settings),
      builder: (context, widget) {
        return MediaQuery(
          data:
              MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
          child: widget!,
        );
      },
      locale: const Locale('ar', 'SA'),
      // Set locale to Arabic (Saudi Arabia)
      supportedLocales: const [
        Locale('en', 'US'), // English locale
        Locale('ar', 'SA'), // Arabic locale
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
