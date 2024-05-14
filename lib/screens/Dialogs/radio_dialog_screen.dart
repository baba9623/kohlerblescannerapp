import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../../Colors/Hex_Color.dart';

class RadioDialogBottomSheet extends StatefulWidget {
  BluetoothCharacteristic characteristics;
  String value;
   RadioDialogBottomSheet({super.key, required this.characteristics,required this.value});

  @override
  State<RadioDialogBottomSheet> createState() => _RadioDialogBottomSheetState();
}

class _RadioDialogBottomSheetState extends State<RadioDialogBottomSheet> {
  String selectedradio = "";
  var ListRadioOption =[
    "Enabled",
    "Disabled"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.selectedradio =widget.value;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      color: HexColor("#272931"),
      child: Padding(
        padding: const EdgeInsets.only(left: 11,top: 30,right: 11,bottom: 11),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.value,style: Theme.of(context).textTheme.labelSmall),
            SizedBox(
              height: 15,
            ),
            Text("Recommanded ${widget.value!} mode is ${widget.value!}",style: Theme.of(context).textTheme.labelMedium),
            Transform.scale(
              scale: 1.1,
              child: RadioListTile(
                title: Text(ListRadioOption[0],style: Theme.of(context).textTheme.displayMedium),
                  value: ListRadioOption[0],
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
            Transform.scale(
              scale: 1.1,
              child: RadioListTile(
                  title: Text(ListRadioOption[1],style: Theme.of(context).textTheme.displayMedium),
                  value: ListRadioOption[1],
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: (){
                      List<int> rowdata =[];
                      if(selectedradio == "Disabled")
                      {
                        rowdata=[00];
                       }
                      else
                      {
                        rowdata=[01];
                      }
                      print(rowdata);
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
