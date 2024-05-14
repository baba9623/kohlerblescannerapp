import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../../models/service_model.dart';

class InformationTabScreen extends StatefulWidget {
  const  InformationTabScreen({super.key});

  @override
  State<InformationTabScreen> createState() => _InformationTabScreenState();
}

class _InformationTabScreenState extends State<InformationTabScreen> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  List<Map<String, dynamic>>  DeviceInfo=[
    {
      "name":"Advertise Name",
      "value":"IOTFV"
    },
    {
      "name":"Sku Number",
      "value":"XYZ1234"
    },
    {
      "name":"Date Of Configured",
      "value":"Week of 36, 2022"
    },

    {
      "name":"MCU Firmware Version",
      "value":"V 5.2.1"
    },
    {
      "name":"BLE Firmware Version",
      "value":"V 4.4.1"
    },
    {
      "name":"Date Of Production",
      "value":"Week 40 2022"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20,top: 20),
            child: Text("Device Information",style: Theme.of(context).textTheme.displayLarge,),
          ),
          Expanded(
              child:  ListView.builder(
                  itemCount: DeviceInfo.length,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 11),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.white24,
                                  width: 0.6
                              )
                          )
                      ),
                      child: ListTile(
                          trailing:  Text(DeviceInfo[index]["value"],style: Theme.of(context).textTheme.displayMedium,),
                          title: Text(DeviceInfo[index]["name"],style: Theme.of(context).textTheme.displayMedium)
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}


