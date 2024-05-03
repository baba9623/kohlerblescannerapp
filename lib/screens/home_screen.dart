
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kohlerblescannerapp/constants/app_constants.dart';
import 'package:kohlerblescannerapp/screens/scan_screen.dart';

import '../colors/hex_color.dart';
import '../routes/app_routes.dart';
import 'bluetooth_off_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   List<Map<String, dynamic>>  Presets=[
    {
      "name":"Cold Shower",
      "icon":Icons.delete_outline_outlined
    },
    {
      "name":"Aqua Turbo 360",
      "icon":Icons.delete_outline_outlined
    },
    {
      "name":"Rock shower Cloned",
      "icon":Icons.delete_outline_outlined
    },

    {
      "name":"Cloned Device 01",
      "icon":Icons.delete_outline_outlined
    },
    {
      "name":"Cloned Device 02",
      "icon":Icons.delete_outline_outlined
    },

  ];

   BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;
   late StreamSubscription<BluetoothAdapterState> _adapterStateStateSubscription;

   @override
   void initState() {
     super.initState();
     _adapterStateStateSubscription =
         FlutterBluePlus.adapterState.listen((state) {
           _adapterState = state;
           if (mounted) {
             setState(() {});
           }
         });
   }

   @override
   void dispose() {
     _adapterStateStateSubscription.cancel();
     super.dispose();
   }

   @override
  Widget build(BuildContext context) {
     Widget screen = _adapterState == BluetoothAdapterState.on
         ? const ScanScreen()
         : BluetoothOffScreen(adapterState: _adapterState);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.appbarbackgroundcolor,
        foregroundColor: Colors.white,
        toolbarHeight: 100,
        leading: Padding(
          padding:  EdgeInsets.only(left: 8),
          child: Image.asset("assets/images/Profile.png"),
        ),
        title: Text("Hi, David",style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 18.sp),),
        actions: [
          Padding(
            padding:  EdgeInsets.only(right: 11),
            child: IconButton(
              icon: Icon(Icons.settings),
              onPressed: (){
                Navigator.pushNamed(context, AppRoute.settingscreen);
              },
            )
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("My Presets",style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 18.sp)),
            SizedBox(
              height: 11,
            ),
            Text("Copy & apply same settings for another devices",style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w200,fontSize: 14.sp)),
            SizedBox(
              height: 11,
            ),
            Expanded(
            child: ListView.builder(
                itemCount: Presets.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 11),
                    child: Container(
                      padding: EdgeInsets.only(left: 11),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: HexColor("#424550"),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(Presets[index]["name"],style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w400,fontSize: 14.sp)),
                          IconButton(onPressed: (){

                          }, icon: Icon(Presets[index]["icon"],color: AppConstants.buttonbacgroundcolor,))
                        ],
                      ),
                    ),
                  );
                }),
          ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                      onPressed: (){
                        Navigator.pushNamed(context, AppRoute.flutterapp);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor("#039597"),
                        foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                11,
                              ))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.qr_code_scanner),
                            SizedBox(width: 11,),
                            Text("SCAN DEVICE")
                          ],
                        ),
                      )),
                )
              ],
            )

          ],
        ),
      ),
    );
  }
}



