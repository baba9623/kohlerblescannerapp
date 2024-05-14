
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:kohlerblescannerapp/Utils/extra.dart';


import '../Colors/Hex_Color.dart';
import '../Constants/app_constants.dart';
import '../Utils/snackbar.dart';
import '../models/service_model.dart';
import '../services/service_services.dart';
import 'Dialogs/hours_dialog_screen.dart';
import 'Dialogs/incOrdec_dialog_screen.dart';
import 'Dialogs/radio_dialog_screen.dart';
import 'Tabs/information_tab_screen.dart';
import 'Tabs/monitor_tab_screen.dart';
import 'Tabs/setting_tab_screen.dart';

class DeviceDetailScreen extends StatefulWidget {
  final BluetoothDevice device;
   const DeviceDetailScreen({super.key,required this.device});

  @override
  State<DeviceDetailScreen> createState() => _DeviceDetailScreenState();
}

class _DeviceDetailScreenState extends State<DeviceDetailScreen> with SingleTickerProviderStateMixin {
  int? _rssi;
  int? _mtuSize;
  BluetoothConnectionState _connectionState = BluetoothConnectionState.disconnected;
  List<BluetoothService> _services = [];
  bool _isDiscoveringServices = false;
  bool _isConnecting = false;
  bool _isDisconnecting = false;

  late StreamSubscription<BluetoothConnectionState> _connectionStateSubscription;
  late StreamSubscription<bool> _isConnectingSubscription;
  late StreamSubscription<bool> _isDisconnectingSubscription;
  late StreamSubscription<int> _mtuSubscription;

  late ServicesList servicesList;
  List<BluetoothCharacteristic> _informationServiceCharacteristics=[];
  List<BluetoothCharacteristic> _monitorServiceCharacteristics=[];
  List<BluetoothCharacteristic> _basicServiceCharacteristics=[];
  List<BluetoothCharacteristic> _advancedServiceCharacteristics=[];
  bool isChecked = false;



  late TabController mtabcontroller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _connectionStateSubscription = widget.device.connectionState.listen((state) async {
      _connectionState = state;
      if (state == BluetoothConnectionState.connected) {
        _services = []; // must rediscover services
      }
      if (state == BluetoothConnectionState.connected && _rssi == null) {
        _rssi = await widget.device.readRssi();
      }
      if (mounted) {
        setState(() {});
      }
    });

    _mtuSubscription = widget.device.mtu.listen((value) {
      _mtuSize = value;
      if (mounted) {
        setState(() {});
      }
    });

    _isConnectingSubscription = widget.device.isConnecting.listen((value) {
      _isConnecting = value;
      if (mounted) {
        setState(() {});
      }
    });

    _isDisconnectingSubscription = widget.device.isDisconnecting.listen((value) {
      _isDisconnecting = value;
      if (mounted) {
        setState(() {});
      }
    });
    mtabcontroller=TabController(length: 3, vsync: this);
    mtabcontroller.addListener(() {

    });
    getAllServices();
    onDiscoverServicesPressed();
    print("_informationServiceCharacteristics services is $_informationServiceCharacteristics");
    print("_monitorServiceCharacteristics services is $_monitorServiceCharacteristics");

    setState(() {

    });

  }

  @override
  void dispose() {
    _connectionStateSubscription.cancel();
    _mtuSubscription.cancel();
    _isConnectingSubscription.cancel();
    _isDisconnectingSubscription.cancel();
    super.dispose();
  }

  bool get isConnected {
    return _connectionState == BluetoothConnectionState.connected;
  }

  Future onConnectPressed() async {
    try {
      await widget.device.connectAndUpdateStream();
      Snackbar.show(ABC.c, "Connect: Success", success: true);
    } catch (e) {
      if (e is FlutterBluePlusException && e.code == FbpErrorCode.connectionCanceled.index) {
        // ignore connections canceled by the user
      } else {
        Snackbar.show(ABC.c, prettyException("Connect Error:", e), success: false);
      }
    }
  }

  Future onCancelPressed() async {
    try {
      await widget.device.disconnectAndUpdateStream(queue: false);
      Snackbar.show(ABC.c, "Cancel: Success", success: true);
    } catch (e) {
      Snackbar.show(ABC.c, prettyException("Cancel Error:", e), success: false);
    }
  }

  Future onDisconnectPressed() async {
    try {
      await widget.device.disconnectAndUpdateStream();
      Snackbar.show(ABC.c, "Disconnect: Success", success: true);
    } catch (e) {
      Snackbar.show(ABC.c, prettyException("Disconnect Error:", e), success: false);
    }
  }

  void onDiscoverServicesPressed() async {
    if (mounted) {
      setState(() {
        _isDiscoveringServices = true;
      });
    }
    try {
      _services = await widget.device.discoverServices();
      if(_services.isNotEmpty || servicesList != null ||servicesList.services.isNotEmpty)
      {
           for(BluetoothService service in _services)
           {
             if(service.serviceUuid.toString().toLowerCase() == AppConstants.InformationServiceUuid.toString().toLowerCase())
               {
                 ServiceModel informationserviceModel=  servicesList.services.firstWhere((element) => element.serviceUuid.toString().toLowerCase() == AppConstants.InformationServiceUuid.toString().toLowerCase());
                 if(informationserviceModel != null ||informationserviceModel.characteristics.isNotEmpty) {
                   for (var aElement in informationserviceModel.characteristics) {
                     BluetoothCharacteristic value = service.characteristics.firstWhere((bElement) => bElement.characteristicUuid.toString().toLowerCase() == aElement.characteristicUuid.toString().toLowerCase());
                     if (value != null)
                     {
                       _informationServiceCharacteristics.add(value);
                     }
                   }
                 }

               }
             if(service.serviceUuid.toString().toLowerCase() == AppConstants.MonitorServiceUuid.toString().toLowerCase())
             {
               ServiceModel monitorserviceModel=  servicesList.services.firstWhere((element) => element.serviceUuid.toString().toLowerCase() == AppConstants.MonitorServiceUuid.toString().toLowerCase());
               if(monitorserviceModel != null ||monitorserviceModel.characteristics.isNotEmpty) {
                 monitorserviceModel.characteristics.forEach((aElement)
                 {
                   BluetoothCharacteristic value = service.characteristics.firstWhere((bElement) => bElement.characteristicUuid.toString().toLowerCase() == aElement.characteristicUuid.toString().toLowerCase());
                   if (value != null)
                   {
                     _monitorServiceCharacteristics.add(value);
                   }
                 });
               }
             }
             if(service.serviceUuid.toString().toLowerCase() == AppConstants.BasicServiceUuid.toString().toLowerCase())
             {
               ServiceModel basicservice=  servicesList.services.firstWhere((element) => element.serviceUuid.toString().toLowerCase() == AppConstants.BasicServiceUuid.toString().toLowerCase());
               if(basicservice != null ||basicservice.characteristics.isNotEmpty)
               {
                 for (var aElement in basicservice.characteristics)
                 {
                   BluetoothCharacteristic value = service.characteristics.firstWhere((bElement) => bElement.characteristicUuid.toString().toLowerCase() == aElement.characteristicUuid.toString().toLowerCase());
                   if (value != null)
                   {
                     _basicServiceCharacteristics.add(value);
                   }
                 }
               }
             }
             if(service.serviceUuid.toString().toLowerCase() == AppConstants.AdvancedServiceUuid.toString().toLowerCase())
             {
               ServiceModel advanceservice=  servicesList.services.firstWhere((element) => element.serviceUuid.toString().toLowerCase() == AppConstants.AdvancedServiceUuid.toString().toLowerCase());
               if(advanceservice != null ||advanceservice.characteristics.isNotEmpty)
               {
                 for (var aElement in advanceservice.characteristics)
                 {
                   BluetoothCharacteristic value = service.characteristics.firstWhere((bElement) => bElement.characteristicUuid.toString().toLowerCase() == aElement.characteristicUuid.toString().toLowerCase());
                   if (value != null)
                   {
                     _advancedServiceCharacteristics.add(value);
                   }
                 }
               }
             }
           }

      }

      Snackbar.show(ABC.c, "Discover Services: Success", success: true);
    } catch (e) {
      Snackbar.show(ABC.c, prettyException("Discover Services Error:", e), success: false);
    }
    if (mounted) {
      setState(() {
        _isDiscoveringServices = false;
      });
    }
  }

  Future onRequestMtuPressed() async {
    try {
      await widget.device.requestMtu(223, predelay: 0);
      Snackbar.show(ABC.c, "Request Mtu: Success", success: true);
    } catch (e) {
      Snackbar.show(ABC.c, prettyException("Change Mtu Error:", e), success: false);
    }
  }

  void getAllServices()async{
    servicesList = await loadService();
    setState(() {

    });
  }

  TabBar get _tabBar => TabBar(
    indicatorColor: Color(0xff039597),
    indicatorSize: TabBarIndicatorSize.label,
    indicatorWeight: 5,
    labelColor: Color(0xffbdbdc1),
    labelStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
    controller: mtabcontroller,

    tabs:[
      const Tab(text: "Info",),
      const Tab(text: "Monitor",),
      const Tab(text: "Settings",)
    ],
  );

  Widget _buildTitle(BuildContext context,String characteristicUuid,String serviceUuid) {
    ServiceModel service=  servicesList.services.firstWhere((element) => element.serviceUuid.toString().toLowerCase() == serviceUuid.toString().toLowerCase());

    CharacteristicModel selectedcharacteristic = service.characteristics.firstWhere((element) => element.characteristicUuid.toString().toLowerCase() ==characteristicUuid.toString().toLowerCase());
    return Text(
        selectedcharacteristic.name,
        overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.labelMedium
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff272931),
        foregroundColor: Colors.white,
        title: Center(child: Text("Device Details",style: Theme.of(context).textTheme.displayLarge,)),
        bottom: PreferredSize(
          preferredSize: _tabBar.preferredSize,
          child: Material(
            color: Color(0xff272931),
            child: Theme( //<-- SEE HERE
                data: ThemeData(
                  splashColor: Color(0xff039597),

                ),
                child: _tabBar),
          ),
        ),

      ),
      body: TabBarView(
        controller: mtabcontroller,
        children: [
          Scaffold(
          body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20,top: 20),
            child: Text("Device Information",style: Theme.of(context).textTheme.displayLarge,),
          ),
          Expanded(
              child:  ListView.builder(
                  itemCount: _informationServiceCharacteristics.length,
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
                              future: ReadData(_informationServiceCharacteristics[index]),
                              builder: (context, snapshot)  {
                                if (snapshot.hasData && snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                                  return Text(snapshot.data!,style: Theme.of(context).textTheme.displayMedium);
                                }
                                return Text('No Data',style: Theme.of(context).textTheme.displayMedium);
                              }),
                          title: _buildTitle(context,_informationServiceCharacteristics[index].characteristicUuid.toString(),_informationServiceCharacteristics[index].serviceUuid.toString())
                      ),
                    );
                  }))
        ],
      ),
    ),
          Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 20,bottom: 10),
                  child: Text("Monitoring Parameters",style: Theme.of(context).textTheme.displayLarge,),
                ),
                Expanded(
                    child:  ListView.builder(
                        itemCount: _monitorServiceCharacteristics.length,
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
                                    future: ReadData(_monitorServiceCharacteristics[index]),
                                    builder: (context, snapshot)  {
                                      if (snapshot.hasData && snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                                        return Text(snapshot.data!,style: Theme.of(context).textTheme.displayMedium);
                                      }
                                      return Text('No Data',style: Theme.of(context).textTheme.displayMedium);
                                    }),
                                title: _buildTitle(context,_monitorServiceCharacteristics[index].characteristicUuid.toString(),_monitorServiceCharacteristics[index].serviceUuid.toString())
                            ),
                          );
                        }))
              ],
            ),
          ),
          Scaffold(
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
                      itemCount: _basicServiceCharacteristics.length,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      itemBuilder: (BuildContext context, int index)
                      {
                        var value ="";
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 11),
                          decoration: const BoxDecoration(
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
                                  const Icon(Icons.info,size: 20,color: Colors.white,),
                                  const SizedBox(width: 10,),
                                  _buildTitle(context,_basicServiceCharacteristics[index].characteristicUuid.toString(),_basicServiceCharacteristics[index].serviceUuid.toString()),
                                  const SizedBox(width: 5,),
                                  const Icon(Icons.info,color: Colors.white, size: 16,),
                                ],
                              ),
                              Row(
                                children: [
                                  TextButton(
                                    style: TextButton.styleFrom(foregroundColor:Color(0xff039597) ),
                                    child: FutureBuilder(
                                        future: ReadData(_basicServiceCharacteristics[index]),
                                        builder: (context, snapshot)  {
                                          if (snapshot.hasData && snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                                             value = snapshot.data!;
                                            return Text(snapshot.data!,style: Theme.of(context).textTheme.displayMedium);
                                          }
                                          return Text('No Data',style: Theme.of(context).textTheme.displayMedium);
                                        }),
                                    onPressed: ()
                                    {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (_) {
                                            if(_basicServiceCharacteristics[index].characteristicUuid.toString().toLowerCase() == AppConstants.DualFlushCharacteristicsUuid.toString().toLowerCase() || _basicServiceCharacteristics[index].characteristicUuid.toString().toLowerCase() == AppConstants.SentinelFlushCharacteristicsUuid.toString().toLowerCase()) {
                                              return RadioDialogBottomSheet(
                                                characteristics: _basicServiceCharacteristics[index],
                                                value: value);
                                            }

                                            if(_basicServiceCharacteristics[index].characteristicUuid.toString().toLowerCase() == AppConstants.SentinelFlushIntervalCharacteristicsUuid.toString().toLowerCase()) {
                                              return HoursDialogBottonSheet(
                                                  characteristics: _basicServiceCharacteristics[index],
                                                  value: value);
                                            }

                                            else
                                            {
                                              return IncOrDecDialogBottomSheet(
                                                characteristics: _basicServiceCharacteristics[index],
                                                value: value,);
                                            }
                                          }
                                      );
                                    },
                                  ),
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
                        itemCount: _advancedServiceCharacteristics.length,
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
                                    _buildTitle(context,_advancedServiceCharacteristics[index].characteristicUuid.toString(),_advancedServiceCharacteristics[index].serviceUuid.toString()),
                                    SizedBox(width: 5,),
                                    Icon(Icons.info,color: Colors.white, size: 16,),
                                  ],
                                ),
                                Row(
                                  children: [
                                    TextButton(
                                      onPressed: (){

                                      },
                                      style: TextButton.styleFrom(foregroundColor:Color(0xff039597) ),
                                      child: FutureBuilder(
                                          future: ReadData(_advancedServiceCharacteristics[index]),
                                          builder: (context, snapshot)  {
                                            if (snapshot.hasData && snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                                              return Text(snapshot.data!,style: Theme.of(context).textTheme.displayMedium);
                                            }
                                            return Text('No Data',style: Theme.of(context).textTheme.displayMedium);
                                          }),),
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
          )

        ],
      ),
    );
  }
}


