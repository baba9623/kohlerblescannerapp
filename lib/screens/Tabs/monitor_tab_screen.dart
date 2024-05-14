import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../../models/service_model.dart';
import '../../services/service_services.dart';

class MonitorTabScreen extends StatefulWidget {
  const MonitorTabScreen({super.key});


  @override
  State<MonitorTabScreen> createState() => _MonitorTabScreenState();
}

class _MonitorTabScreenState extends State<MonitorTabScreen> {


  List<Map<String, dynamic>>  MonitoringParameters=[
    {
      "name":"Battery Status",
      "value":"Normal"
    },
    {
      "name":"Flush Count",
      "value":"146"
    },
    {
      "name":"Low Flush Count",
      "value":"40"
    }

  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10,top: 20,bottom: 10),
            child: Text("Monitoring Parameters",style: Theme.of(context).textTheme.displayLarge,),
          ),
          Expanded(
              child:  ListView.builder(
                  itemCount: MonitoringParameters.length,
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
                          trailing:  Text(MonitoringParameters[index]["value"],style: Theme.of(context).textTheme.displayMedium,),
                          title: Text(MonitoringParameters[index]["name"],style: Theme.of(context).textTheme.displayMedium)
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
