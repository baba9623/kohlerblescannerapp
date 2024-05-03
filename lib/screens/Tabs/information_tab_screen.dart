import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../../models/service_model.dart';

class InformationTabScreen extends StatefulWidget {
  const  InformationTabScreen({super.key,required this.informationservice,required this.selectedservice});
  final BluetoothService informationservice;
  final ServiceModel selectedservice;

  @override
  State<InformationTabScreen> createState() => _InformationTabScreenState();
}

class _InformationTabScreenState extends State<InformationTabScreen> {
  List<BluetoothCharacteristic> selectedcharacteristics=[];



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.selectedservice != null ||widget.selectedservice.characteristics.isNotEmpty) {
      widget.selectedservice.characteristics.forEach((aElement)
      {
        BluetoothCharacteristic value = widget.informationservice.characteristics.firstWhere((bElement) => bElement.characteristicUuid.toString().toLowerCase() == aElement.characteristicUuid.toString().toLowerCase());
        if (value != null)
        {
          value.read();
          selectedcharacteristics.add(value);
        }
      });
    }

  }

  Widget _buildTitle(BuildContext context,String characteristicUuid) {
    CharacteristicModel selectedcharacteristic = widget.selectedservice.characteristics.firstWhere((element) => element.characteristicUuid.toString().toLowerCase() ==characteristicUuid.toString().toLowerCase());
    return Text(
        selectedcharacteristic.name,
        overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.displayMedium
    );
  }
  Future<String> ReadDate (BluetoothCharacteristic characteristics) async
  {
     List<int> rawdata= await characteristics.read();
    ///List<int> rawdata = [78, 111, 105, 115, 101, 32, 71, 114, 97, 110, 100, 95, 68, 66, 50, 49, 0];
    String str = String.fromCharCodes(rawdata);
    return str;

  }

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
                  itemCount: selectedcharacteristics.length,
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
                           trailing: FutureBuilder(
                      future: ReadDate(selectedcharacteristics[index]),
                     builder: (context, snapshot)  {
                     if (snapshot.hasData && snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                     return Text(snapshot.data!,style: Theme.of(context).textTheme.displayMedium);
                    }
                    return Text('No Data',style: Theme.of(context).textTheme.displayMedium);
                    }),
                          title: _buildTitle(context,selectedcharacteristics[index].characteristicUuid.toString())
                      ),
                    );
                  }))
        ],
      ),
    );
  }


}


