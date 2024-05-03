

import 'package:flutter/material.dart';
import 'package:kohlerblescannerapp/screens/bluetooth_off_screen.dart';
import 'package:kohlerblescannerapp/screens/flutter_connect_ble_devices.dart';
import 'package:kohlerblescannerapp/screens/scan_screen.dart';

import '../screens/help_screen.dart';
import '../screens/home_screen.dart';
import '../screens/profie_screen.dart';
import '../screens/setting_screen.dart';
import '../screens/splash_screen.dart';

class AppRoute{
  static const String splashscreen= '/splash';
  static const String homescreen= '/home';
  static const String devicedetailscreen= '/devicedetail';
  static const String settingscreen = '/setting';
  static const String helpscreen = '/help';
  static const String profilescreen = '/profile';
  static const String scanscreen = '/scanscreen';
  static const String bluetoothoffscreen = '/bluetoothoffscreen';
  static const String flutterapp = '/flutterapp';



  static Map<String,Widget Function(BuildContext)> AppRoutes(){
    return {
      splashscreen: (context) => SplashScreen(),
      homescreen: (context) => HomeScreen(),
     /// devicedetailscreen: (context) => DeviceDetailScreen(),
      settingscreen : (context) => SettingScreen(),
      helpscreen : (context) => HelpScreen(),
      profilescreen : (context) => ProfileScreen(),
      scanscreen : (context) => ScanScreen(),
      bluetoothoffscreen : (context) => BluetoothOffScreen(),
      flutterapp : (context) => FlutterBlueApp(),
    };
  }
}

