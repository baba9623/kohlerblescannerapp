import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:kohlerblescannerapp/Constants/app_constants.dart';

import '../../Colors/Hex_Color.dart';
import '../../bluetooth_bloc/characteristics_bloc.dart';
import '../../services/service_services.dart';

class IncOrDecDialogBottomSheet extends StatefulWidget {
  BluetoothCharacteristic characteristics;
  String value;
  BluetoothDevice device;

  IncOrDecDialogBottomSheet({super.key, required this.characteristics, required this.value, required this.device});

  @override
  State<IncOrDecDialogBottomSheet> createState() => _IncOrDecDialogBottomSheetState();
}

class _IncOrDecDialogBottomSheetState extends State<IncOrDecDialogBottomSheet> {
  var CounterController =TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CounterController.text=widget.value!;
  }


  Widget _buildTitle() {
    if(widget.characteristics.characteristicUuid.toString().toLowerCase() == AppConstants.DualFlushTimeThresholdCharacteristicsUuid.toString().toLowerCase())
    {
      return Text("Dual Flush Time Threshold",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),);

    }
    if(widget.characteristics.characteristicUuid.toString().toLowerCase() == AppConstants.SensorDistanceCharacteristicsUuid.toString().toLowerCase())
    {
      return Text("Sensor Distance",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),);

    }
    if(widget.characteristics.characteristicUuid.toString().toLowerCase() == AppConstants.FlushDelayOutTimeCharacteristicsUuid.toString().toLowerCase())
    {
      return Text("Flush Delay Out time",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),);

    }
    if(widget.characteristics.characteristicUuid.toString().toLowerCase() == AppConstants.SensorIdleTimingCharacteristicsUuid.toString().toLowerCase())
    {
      return Text("Sensor Idle Inter-Measurement",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),);

    }
    if(widget.characteristics.characteristicUuid.toString().toLowerCase() == AppConstants.SensorLatchTimingCharacteristicsUuid.toString().toLowerCase())
    {
      return Text("Sensor Latch Inter-Measurement",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),);

    }
    else
    {
      return Text("Arming Delay In Time",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),);
    }

  }

  Widget _buildSubTitle() {
    if(widget.characteristics.characteristicUuid.toString().toLowerCase() == AppConstants.DualFlushTimeThresholdCharacteristicsUuid.toString().toLowerCase())
    {
      return Text("Recommended dual flush threshold time is 60000 ms ",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w400),);

    }
    if(widget.characteristics.characteristicUuid.toString().toLowerCase() == AppConstants.SensorDistanceCharacteristicsUuid.toString().toLowerCase())
    {
      return Text("Recommended sensor distance is 24 inch",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w400),);

    }
    if(widget.characteristics.characteristicUuid.toString().toLowerCase() == AppConstants.FlushDelayOutTimeCharacteristicsUuid.toString().toLowerCase())
    {
      return Text("Recommended flush delay out time is 500 ms ",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w400),);

    }
    if(widget.characteristics.characteristicUuid.toString().toLowerCase() == AppConstants.SensorIdleTimingCharacteristicsUuid.toString().toLowerCase())
    {
      return Text("Recommended sensor idle timing is 7000 ms",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w400),);

    }
    if(widget.characteristics.characteristicUuid.toString().toLowerCase() == AppConstants.SensorLatchTimingCharacteristicsUuid.toString().toLowerCase())
    {
      return Text("Recommended sensor latch timing is 2000 ms",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w400),);

    }
    else
    {
      return Text("Recommended arming delay in time is 2400 ms ",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w400),);
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
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.remove_circle,size: 50,),
                  color:HexColor("#424550"),
                  onPressed: ()
                  {
                    int index = CounterController.text.indexOf(' ');
                    var result = CounterController.text.substring(0, index);
                    int currentValue = int.parse(result);

                        if(widget.characteristics.characteristicUuid.toString().toLowerCase() ==AppConstants.FlushDelayOutTimeCharacteristicsUuid.toString().toLowerCase())
                        {
                          if(currentValue > 500)
                            {
                              currentValue -= 100;
                            }

                        }

                        if(widget.characteristics.characteristicUuid.toString().toLowerCase() ==AppConstants.ArmingDelayInTimeCharacteristicsUuid.toString().toLowerCase())
                         {
                           if(currentValue > 1800)
                         {
                            currentValue -= 100;
                         }

                       }
                    if(widget.characteristics.characteristicUuid.toString().toLowerCase() ==AppConstants.SensorIdleTimingCharacteristicsUuid.toString().toLowerCase())
                    {
                      if(currentValue > 100)
                      {
                        currentValue -= 100;
                      }

                    }
                    if(widget.characteristics.characteristicUuid.toString().toLowerCase() ==AppConstants.SensorLatchTimingCharacteristicsUuid.toString().toLowerCase())
                    {
                      if(currentValue > 100)
                      {
                        currentValue -= 100;
                      }

                    }

                        if(widget.characteristics.characteristicUuid.toString().toLowerCase() ==AppConstants.SensorDistanceCharacteristicsUuid.toString().toLowerCase())
                        {
                          if(currentValue > 24)
                          {
                            currentValue -= 1;
                          }
                        }
                        if(widget.characteristics.characteristicUuid.toString().toLowerCase() ==AppConstants.DualFlushTimeThresholdCharacteristicsUuid.toString().toLowerCase())
                        {
                          if(currentValue > 60000)
                            {
                              currentValue -= 1000;
                            }

                        }

                    String value =(currentValue).toString();
                    if(widget.characteristics.characteristicUuid.toString().toLowerCase() ==AppConstants.SensorDistanceCharacteristicsUuid.toString().toLowerCase())
                      {
                        CounterController.text = "$value inch";
                      }
                    else
                      {
                        CounterController.text = "$value ms";
                      }

                    setState(() {

                    });
                  },
                  ),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: TextField(
                    controller:CounterController ,

                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,

                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#424550"),

                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50)
                      ),
                    ),
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.add_circle,size: 50,),
                    color:HexColor("#039597"),
                  onPressed: () {
                    int index = CounterController.text.indexOf(' ');
                    var result = CounterController.text.substring(0, index);
                    int currentValue = int.parse(result);
                    if(widget.characteristics.characteristicUuid.toString().toLowerCase() ==AppConstants.FlushDelayOutTimeCharacteristicsUuid.toString().toLowerCase())
                      {
                        if(currentValue < 3000)
                        {
                          currentValue += 100;
                        }

                      }
                    if(widget.characteristics.characteristicUuid.toString().toLowerCase() ==AppConstants.ArmingDelayInTimeCharacteristicsUuid.toString().toLowerCase())
                    {
                      if(currentValue < 3000)
                      {
                        currentValue += 100;
                      }

                    }
                    if(widget.characteristics.characteristicUuid.toString().toLowerCase() ==AppConstants.SensorIdleTimingCharacteristicsUuid.toString().toLowerCase())
                    {
                      if(currentValue < 7000)
                      {
                        currentValue += 100;
                      }

                    }
                    if(widget.characteristics.characteristicUuid.toString().toLowerCase() ==AppConstants.SensorLatchTimingCharacteristicsUuid.toString().toLowerCase())
                    {
                      if(currentValue < 2000)
                      {
                        currentValue += 100;
                      }

                    }
                    if(widget.characteristics.characteristicUuid.toString().toLowerCase() ==AppConstants.SensorDistanceCharacteristicsUuid.toString().toLowerCase())
                      {
                        if(currentValue < 36)
                          {
                            currentValue += 1;
                          }

                      }
                    if(widget.characteristics.characteristicUuid.toString().toLowerCase() ==AppConstants.DualFlushTimeThresholdCharacteristicsUuid.toString().toLowerCase())
                      {
                        if(currentValue < 120000)
                        {
                          currentValue += 1000;
                        }

                      }

                    String value =(currentValue).toString();
                    if(widget.characteristics.characteristicUuid.toString().toLowerCase() ==AppConstants.SensorDistanceCharacteristicsUuid.toString().toLowerCase())
                    {
                      CounterController.text = "$value inch";
                    }
                    else
                    {
                      CounterController.text = "$value ms";
                    }
                    setState(() {

                    });
                  },
                    ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top:30 ),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: (){
                      List<int> rowdata =[];
                      int index = CounterController.text.indexOf(' ');
                      var result = CounterController.text.substring(0, index);
                      BlocProvider.of<CharacteristicsBloc>(context).add(WriteCharacteristicsEvent(bluetoothCharacteristic: widget.characteristics, value: result,device: widget.device));
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
