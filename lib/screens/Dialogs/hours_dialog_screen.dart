import 'package:flutter/material.dart';

import '../../Colors/Hex_Color.dart';

class HoursDialogBottonSheet extends StatefulWidget {
  String? name;
  String? value;
   HoursDialogBottonSheet({super.key,this.name,this.value});

  @override
  State<HoursDialogBottonSheet> createState() => _HoursDialogBottonSheetState();
}

class _HoursDialogBottonSheetState extends State<HoursDialogBottonSheet> {

  String selectedhours ="24 Hrs";
  var ListHoursRadioOption =[
    "04 Hrs",
    "12 Hrs",
    "24 Hrs",
    "36 Hrs",
    "48 Hrs"
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
            Text(widget.name!,style: Theme.of(context).textTheme.labelSmall),
            SizedBox(
              height: 15,
            ),
            Text("Recommanded ${widget.name!} mode is ${widget.value!}",style: Theme.of(context).textTheme.labelMedium),
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
