import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../../Colors/Hex_Color.dart';
import '../../services/service_services.dart';

class HoursDialogBottonSheet extends StatefulWidget {
  BluetoothCharacteristic characteristics;
  String value;
   HoursDialogBottonSheet({super.key,required this.characteristics,required this.value});

  @override
  State<HoursDialogBottonSheet> createState() => _HoursDialogBottonSheetState();
}

class _HoursDialogBottonSheetState extends State<HoursDialogBottonSheet> {

  String selectedhours = "";
  var ListHoursRadioOption =[
    "04 hrs",
    "12 hrs",
    "24 hrs",
    "36 hrs",
    "48 hrs"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedhours =widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      color: HexColor("#272931"),
      child: Padding(
        padding: const EdgeInsets.only(left: 11,top: 30,right: 11),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.value,style: Theme.of(context).textTheme.labelSmall),

            Text("Recommanded ${widget.value} mode is ${widget.value!}",style: Theme.of(context).textTheme.labelMedium),
            Transform.scale(
              scale: 1.1,
              child: RadioListTile(
                  title: Text(ListHoursRadioOption[0],style: Theme.of(context).textTheme.displayMedium),
                  value: ListHoursRadioOption[0],
                  groupValue: selectedhours,
                  activeColor: HexColor("#039597"),
                  fillColor:
                  MaterialStateColor.resolveWith((states) => HexColor("#039597")),
                  onChanged: (value){
                    selectedhours =value!;
                    setState(() {

                    });
                  }),
            ),
            Transform.scale(
              scale: 1.1,
              child: RadioListTile(
                  title: Text(ListHoursRadioOption[1],style: Theme.of(context).textTheme.displayMedium),
                  value: ListHoursRadioOption[1],
                  groupValue: selectedhours,
                  activeColor: HexColor("#039597"),
                  fillColor:
                  MaterialStateColor.resolveWith((states) => HexColor("#039597")),
                  onChanged: (value){
                    selectedhours =value!;
                    setState(() {

                    });
                  }),
            ),
            Transform.scale(
              scale: 1.1,
              child: RadioListTile(
                  title: Text(ListHoursRadioOption[2],style: Theme.of(context).textTheme.displayMedium),
                  value: ListHoursRadioOption[2],
                  groupValue: selectedhours,
                  activeColor: HexColor("#039597"),
                  fillColor:
                  MaterialStateColor.resolveWith((states) => HexColor("#039597")),
                  onChanged: (value){
                    selectedhours =value!;
                    setState(() {

                    });
                  }),
            ),
            Transform.scale(
              scale: 1.1,
              child: RadioListTile(
                  title: Text(ListHoursRadioOption[3],style: Theme.of(context).textTheme.displayMedium),
                  value: ListHoursRadioOption[3],
                  groupValue: selectedhours,
                  activeColor: HexColor("#039597"),
                  fillColor:
                  MaterialStateColor.resolveWith((states) => HexColor("#039597")),
                  onChanged: (value){
                    selectedhours =value!;
                    setState(() {

                    });
                  }),
            ),
            Transform.scale(
              scale: 1.1,
              child: RadioListTile(
                  title: Text(ListHoursRadioOption[4],style: Theme.of(context).textTheme.displayMedium),
                  value: ListHoursRadioOption[4],
                  groupValue: selectedhours,
                  activeColor: HexColor("#039597"),
                  fillColor:
                  MaterialStateColor.resolveWith((states) => HexColor("#039597")),
                  onChanged: (value){
                    selectedhours =value!;
                    setState(() {

                    });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: (){
                    List<int> rowdata =[];
                     var result = selectedhours.substring(0, 2);
                    rowdata.add(int.parse(result));
                    widget.characteristics.write(rowdata);
                    setState(() {

                    });
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
