import 'package:flutter/material.dart';

import '../../Colors/Hex_Color.dart';

class CopyFromPresetDialogScreen extends StatefulWidget {
  const CopyFromPresetDialogScreen({super.key});

  @override
  State<CopyFromPresetDialogScreen> createState() => _CopyFromPresetDialogScreenState();
}

class _CopyFromPresetDialogScreenState extends State<CopyFromPresetDialogScreen> {

  String selectedradio ="Enabled";
  List<Map<String, dynamic>>  ListRadioOption=[
    {
      "name":"Cold Shower",
    },
    {
      "name":"Aqua Turbo 360"
    },
    {
      "name":"Rock shower Cloned"
    },

    {
      "name":"Cloned Device 01"
    },
    {
      "name":"Cloned Device 02"
    },





  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      color: HexColor("#272931"),
      child: Padding(
        padding: const EdgeInsets.only(left: 11,top: 30,right: 11,bottom: 11),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("My Presets",style: Theme.of(context).textTheme.labelSmall),
            SizedBox(
              height: 15,
            ),
            Text("Select preset to apply the same settings for another device",style: Theme.of(context).textTheme.labelMedium),
            Expanded(
              child: ListView.builder(
                  itemCount: ListRadioOption.length,
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
                        child:  RadioListTile(
                            title: Text(ListRadioOption[index]["name"],style: Theme.of(context).textTheme.displayMedium),
                            value: ListRadioOption[index]["name"],
                            groupValue: selectedradio,
                            activeColor: HexColor("#039597"),
                            fillColor:
                            MaterialStateColor.resolveWith((states) => HexColor("#039597")),
                            onChanged: (value){
                              selectedradio =value!;
                              setState(() {

                              });
                            }),
                      ),
                    );
                  }),
            ),


            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: HexColor("#039597"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                    child: Text("SAVE",style: TextStyle(color: Colors.white,fontSize: 21))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
