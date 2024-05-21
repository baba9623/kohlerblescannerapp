
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:kohlerblescannerapp/Constants/app_constants.dart';

import '../../Colors/Hex_Color.dart';
import '../../bluetooth_bloc/characteristics_bloc.dart';

class RadioDialogBottomSheet extends StatefulWidget {
  BluetoothCharacteristic characteristics;
  String value;
  BluetoothDevice device;
   RadioDialogBottomSheet({super.key, required this.characteristics,required this.value,required this.device});

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

  Widget _buildTitle() {
    if(widget.characteristics.characteristicUuid.toString().toLowerCase() == AppConstants.DualFlushCharacteristicsUuid.toString().toLowerCase())
    {
      return Text("Dual Flush Mode",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),);

    }
    else
    {
      return Text("Sentinel Flush",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),);
    }

  }
  Widget _buildSubTitle() {
    if(widget.characteristics.characteristicUuid.toString().toLowerCase() == AppConstants.DualFlushCharacteristicsUuid.toString().toLowerCase())
    {
      return Text("Recommended dual flush mode is Enabled",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w400),);

    }
    else
    {
      return Text("Recommended duty flush status is Enabled",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w400),);
    }

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
            _buildTitle(),
            SizedBox(
              height: 15,
            ),
            _buildSubTitle(),
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

                      BlocProvider.of<CharacteristicsBloc>(context).add(WriteCharacteristicsEvent(bluetoothCharacteristic: widget.characteristics, value: selectedradio,device: widget.device));
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
