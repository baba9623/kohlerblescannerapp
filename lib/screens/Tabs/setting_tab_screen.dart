import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../../Colors/Hex_Color.dart';
import '../../models/service_model.dart';
import '../Dialogs/copyfrompreset_dialog_screen.dart';
import '../Dialogs/hours_dialog_screen.dart';
import '../Dialogs/incOrdec_dialog_screen.dart';
import '../Dialogs/radio_dialog_screen.dart';
import '../Dialogs/savetopresets_dialog_screen.dart';

class SettingTabScreen extends StatefulWidget {
  const SettingTabScreen({super.key,required this.basicservice,required this.advancedservice,required this.selectedbasicservice,required this.selectedadvancedservice});
  final BluetoothService basicservice;
  final BluetoothService advancedservice;
  final ServiceModel selectedbasicservice;
  final ServiceModel selectedadvancedservice;



  @override
  State<SettingTabScreen> createState() => _SettingTabScreenState();
}

class _SettingTabScreenState extends State<SettingTabScreen> {

  List<Map<String, dynamic>>  BasicParameters=[
    {
      "name":"Dual Flush",
      "value":"Enabled",
    },
    {
      "name":"Dual Flush Time Threshold",
      "value":"60000 ms"
    },
    {
      "name":"Sential Flush",
      "value":"Disabled"
    },
    {
      "name":"Sensor Distance",
      "value":"24 inch"
    },
    {
      "name":"Flush Delay Out Time",
      "value":"500ms"
    }

  ];


  List<Map<String, dynamic>>  AdvanceParameters=[
    {
      "name":"Sentinal Flush Interval",
      "value":"24 hrs"
    },
    {
      "name":"Sensor Idel Measurement",
      "value":"7000 ms"
    },
    {
      "name":"Sensor Latch Measurement",
      "value":"6000 ms"
    },
    {
      "name":"Arming Delay In Time",
      "value":"1800 ms"
    },


  ];

  bool isChecked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20,top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Basic Parameters",style: Theme.of(context).textTheme.displayLarge,),
                  Row(
                    children: [
                      TextButton(
                        onPressed: (){

                        },
                        child: Text("Show Advance"),
                        style: TextButton.styleFrom(foregroundColor:Color(0xff039597)),),
                      Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          side: MaterialStateBorderSide.resolveWith(
                                (states) => BorderSide(width: 2.0, color: HexColor("#039597")),
                          ),
                          checkColor: Colors.white,
                          activeColor: HexColor("#039597"),
                          value: isChecked,
                          onChanged: (bool? value){
                        setState(() {
                          isChecked = value!;
                        });
                      })
                    ],
                  ),


                ],
              ),
            ),
            ListView.builder(
                itemCount: BasicParameters.length,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 11),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.white24,
                                width: 0.7
                            )
                        )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.info,size: 20,color: Colors.white,),
                            SizedBox(width: 10,),
                            Text(BasicParameters[index]["name"],style: Theme.of(context).textTheme.displayMedium),
                            SizedBox(width: 5,),
                            Icon(Icons.info,color: Colors.white, size: 16,),
                          ],
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: (){
                                  showModalBottomSheet(

                                      context: context,
                                      builder: (_) {

                                         if(BasicParameters[index]["name"] == "Dual Flush" || BasicParameters[index]["name"] == "Sential Flush") {
                                           return RadioDialogBottomSheet(
                                             name: BasicParameters[index]["name"],
                                             value: BasicParameters[index]["value"],);
                                         }
                                         else
                                           {
                                             return IncOrDecDialogBottomSheet(
                                               name: BasicParameters[index]["name"],
                                               value: BasicParameters[index]["value"],);
                                           }
                                      }
                                  );
                              },
                              child: Text(BasicParameters[index]["value"]),
                              style: TextButton.styleFrom(foregroundColor:Color(0xff039597) ),),
                            Icon(Icons.arrow_forward_ios_outlined,color: Colors.white, size: 16,),

                          ],
                        ),
                      ],
                    ),
                  );
                }),

            //Advance Parameters
            Visibility(
              visible: isChecked,
              child: Padding(
                padding: const EdgeInsets.only(left: 20,top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Advance Parameters",style: Theme.of(context).textTheme.displayLarge,),

                  ],
                ),
              ),
            ),
            Visibility(
              visible: isChecked,
              child: ListView.builder(
                  itemCount: AdvanceParameters.length,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 11),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.white24,
                                  width: 0.7
                              )
                          )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.info,size: 20,color: Colors.white,),
                              SizedBox(width: 10,),
                              Text(AdvanceParameters[index]["name"],style: Theme.of(context).textTheme.displayMedium),
                              SizedBox(width: 5,),
                              Icon(Icons.info,color: Colors.white, size: 16,),
                            ],
                          ),
                          Row(
                            children: [
                              TextButton(
                                onPressed: (){
                                  showModalBottomSheet(

                                      context: context,
                                      builder: (_) {

                                        if(AdvanceParameters[index]["name"] == "Sentinal Flush Interval") {
                                          return HoursDialogBottonSheet(
                                            name: AdvanceParameters[index]["name"],
                                            value: AdvanceParameters[index]["value"],);
                                        }
                                        else
                                        {
                                          return IncOrDecDialogBottomSheet(
                                            name: AdvanceParameters[index]["name"],
                                            value: AdvanceParameters[index]["value"],);
                                        }
                                      }
                                  );
                                },
                                child: Text(AdvanceParameters[index]["value"]),
                                style: TextButton.styleFrom(foregroundColor:Color(0xff039597) ),),
                              Icon(Icons.arrow_forward_ios_outlined,color: Colors.white, size: 16,),

                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ),

          ],
        ),
      ),
      bottomNavigationBar: BuildBottomNavBar(context),
    );
  }
}

Container BuildBottomNavBar(BuildContext context)
{
  return Container(
    height: 200,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11,vertical: 5),
          child: SizedBox(
            width: double.infinity,
            height: 50,

            child: ElevatedButton(
                onPressed: (){
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (_){
                    return AlertDialog(
                       title: Center(child: Text("Resttings to defaults removes all of your custome settings.Do you really want to reset to factory defaults")),
                       titleTextStyle: Theme.of(context).textTheme.displayMedium,
                       backgroundColor: HexColor("#424550"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                      actions: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            decoration:BoxDecoration(
                                border: Border(
                                    top: BorderSide(width: 0.8,color: Colors.black)
                                )
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration:BoxDecoration(
                                        border: Border(
                                            right: BorderSide(width: 0.8,color: Colors.black)
                                        )
                                    ),
                                    child: TextButton(onPressed: (){
                                      Navigator.pop(context);
                                    }, child: Text("Cancel", style: TextStyle(color: Colors.white70,fontSize:19 ),),),
                                  ),
                                ),
                                Expanded(
                                  child: TextButton(onPressed: (){
                                    Navigator.pop(context);
                                  }, child: Text("Yes",style: TextStyle(color: HexColor("#039597"),fontSize:19 ),),),
                                ),
                              ],
                            ),
                          ),

                        )
                      ],
                    );
                  });

                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: HexColor("#039597"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
                child: Text("FACTORY RESET")),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11,vertical: 5),
          child: SizedBox(
            width: double.infinity,
            height: 50,

            child: ElevatedButton(
                onPressed: (){
                  showModalBottomSheet(context: context,
                      builder: (_){
                           return SaveToPresetDialogScreen();
                      });
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: HexColor("#039597"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
                child: Text("SAVE TO PRESET")),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11,vertical: 5),
          child: SizedBox(
            width: double.infinity,
            height: 50,

            child: ElevatedButton(
                onPressed: (){
                    showModalBottomSheet(
                        context: context,
                        builder: (_){
                          return CopyFromPresetDialogScreen();
                        });
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: HexColor("#039597"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
                child: Text("COPY FROM PRESET")),
          ),
        )
      ],
    ),
  );
}



