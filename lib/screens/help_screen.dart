import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_constants.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Help",style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold,fontSize: 16.sp))),
        backgroundColor:  AppConstants.appbarbackgroundcolor,
        foregroundColor: Colors.white,

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Icon(Icons.card_giftcard_rounded,size: 100,color: Colors.white54,)),
          SizedBox(height: 25,),
          Center(child: Text("No Data Available",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),)),
          SizedBox(height: 8,),
          Center(child: Text("Please check after sometime",style: TextStyle(color: Colors.white54,fontSize: 20,fontWeight: FontWeight.w500),))
        ],
      ),
    );
  }
}
