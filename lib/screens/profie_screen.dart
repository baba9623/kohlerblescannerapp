
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Colors/Hex_Color.dart';
import '../constants/app_constants.dart';

enum FormData {
  Name,
  Email,
  PhoneNumber,
  Companyname
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var companynameController = TextEditingController();

  Color enabled = const Color.fromARGB(255, 63, 56, 89);
  Color enabledtxt = Colors.white;
  Color deaible = Colors.grey;
  Color backgroundColor = const Color(0xFF424550);
  Color forcolor =const Color(0xFFFDFDFE);
  bool ispasswordev = true;
  bool _isenable = false;
  bool _isvisible =true;
  FormData? selected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = "David Willy";
    emailController.text = "DavidWilly_123";
    phoneController.text = "234 345 4321";
    companynameController.text = "Kohler";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: AppConstants.appbarbackgroundcolor,
          foregroundColor: Colors.white,
          title: Center(child: Text("My Profile",style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold,fontSize: 16.sp))),
          actions: [
            Visibility(
              visible: _isvisible,
              child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    icon: Icon(Icons.edit,color: HexColor("#039597"),),
                    onPressed: (){
                      _isenable=true;
                      _isvisible =false;
                      setState(() {

                      });
                    },
                  )
              ),
            )
          ],
        ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(11),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Center(
               child: Stack(
                 children: [
                   CircleAvatar(
                     radius: 60.0,
                     backgroundImage: AssetImage("assets/images/Profile.png"),
                   ),
                   Visibility(
                     visible: _isenable,
                     child: Positioned(
                       bottom: 5,
                         right: 10,
                         child: CircleAvatar(
                           radius: 17,
                           backgroundColor: HexColor("#272931"),
                             child: Icon(Icons.edit,color: Colors.white,size: 28,))),
                   )
                 ],
               ),
             ),
              Text("Name",style: Theme.of(context).textTheme.labelMedium),
              SizedBox(height: 11,),
              Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: selected == FormData.Name
                      ? enabled
                      : backgroundColor,
                ),
                padding: const EdgeInsets.all(5.0),
                child: TextField(
                  controller: nameController,
                  enabled: _isenable,
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,

                    hintText: 'Please enter name',
                    hintStyle: TextStyle(
                        color: selected == FormData.Email
                            ? enabledtxt
                            : deaible,
                        fontSize: 12),
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ),
              SizedBox(height: 15,),
              Text("UserName",style: Theme.of(context).textTheme.labelMedium),
              SizedBox(height: 11,),
              Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: selected == FormData.Email
                      ? enabled
                      : backgroundColor,
                ),
                padding: const EdgeInsets.all(5.0),
                child: TextField(
                  controller: emailController,
                  enabled: _isenable,
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,

                    hintText: 'Please enter username',
                    hintStyle: TextStyle(
                        color: selected == FormData.Email
                            ? enabledtxt
                            : deaible,
                        fontSize: 12),
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ),
              SizedBox(height: 15,),
              Text("Phone Number",style: Theme.of(context).textTheme.labelMedium),
              SizedBox(height: 11,),
              Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: selected == FormData.Name
                      ? enabled
                      : backgroundColor,
                ),
                padding: const EdgeInsets.all(5.0),
                child: TextField(
                  controller: phoneController,
                  enabled: _isenable,
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,

                    hintText: 'Please enter phone number',
                    hintStyle: TextStyle(
                        color: selected == FormData.PhoneNumber
                            ? enabledtxt
                            : deaible,
                        fontSize: 12),
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ),
              SizedBox(height: 15,),
              Text("Company Name",style: Theme.of(context).textTheme.labelMedium),
              SizedBox(height: 11,),
              Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: selected == FormData.Name
                      ? enabled
                      : backgroundColor,
                ),
                padding: const EdgeInsets.all(5.0),
                child: TextField(
                  controller: companynameController,
                  enabled: _isenable,
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,

                    hintText: 'Please enter company name',
                    hintStyle: TextStyle(
                        color: selected == FormData.Companyname
                            ? enabledtxt
                            : deaible,
                        fontSize: 12),
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ),
              SizedBox(height: 30,),
              Visibility(
                visible: _isenable,
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: (){

                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: HexColor("#039597"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11),
                        ),
                      ),
                      child: Text("UPDATE PROFILE")),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
