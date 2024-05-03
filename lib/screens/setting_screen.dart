import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_constants.dart';
import '../routes/app_routes.dart';


class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Settings",style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold,fontSize: 16.sp))),
        backgroundColor:  AppConstants.appbarbackgroundcolor,
        foregroundColor: Colors.white,

      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 11,vertical: 25),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white24,
                  width: 0.5
                )
              )
            ),
            child: InkWell(
              onTap: (){
                Navigator.pushNamed(context, AppRoute.profilescreen);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person,color: Colors.white,),
                      SizedBox(
                        width: 11,
                      ),
                      Text("My Profile",style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold,fontSize: 16.sp))
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,)
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 11,vertical: 25),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.white24,
                        width: 0.5
                    )
                )
            ),
            child: InkWell(
              onTap: (){
                  Navigator.pushNamed(context, AppRoute.helpscreen);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.help,color: Colors.white,),
                      SizedBox(
                        width: 11,
                      ),
                      Text("Help",style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold,fontSize: 16.sp))
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,)
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 11,vertical: 25),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.white24,
                        width: 0.5
                    )
                )
            ),
            child: InkWell(
              onTap: (){
                 Navigator.pushReplacementNamed(context, AppRoute.splashscreen);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.logout_outlined,color: Colors.white,),
                      SizedBox(
                        width: 11,
                      ),
                      Text("Sign Out",style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold,fontSize: 14.sp))
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,)
                ],
              ),
            ),
          )
        ],
      ),
    );

  }
}
