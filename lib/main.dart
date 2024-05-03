import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kohlerblescannerapp/constants/app_constants.dart';
import 'package:kohlerblescannerapp/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: AppConstants.backgroundcolor,
          useMaterial3: true,
          textTheme: TextTheme(
            displayLarge: TextStyle(
              color: Colors.white,

              fontWeight: FontWeight.bold
            ),
            displayMedium: TextStyle(
                color: Colors.white,

            ),

          )
        ),
        initialRoute:AppRoute.splashscreen,
        routes: AppRoute.AppRoutes(),
      ),
      designSize: const Size(360, 690),
    );
  }
}



