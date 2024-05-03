import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:kohlerblescannerapp/Utils/extra.dart';


import '../Constants/app_constants.dart';
import '../Utils/snackbar.dart';
import '../models/service_model.dart';
import '../services/service_services.dart';
import 'Tabs/information_tab_screen.dart';
import 'Tabs/monitor_tab_screen.dart';
import 'Tabs/setting_tab_screen.dart';

class DeviceDetailScreen extends StatefulWidget {
  final BluetoothDevice device;
   DeviceDetailScreen({super.key,required this.device});

  @override
  State<DeviceDetailScreen> createState() => _DeviceDetailScreenState();
}

class _DeviceDetailScreenState extends State<DeviceDetailScreen> with SingleTickerProviderStateMixin {


  late TabController mtabcontroller;
  int? _rssi;
  int? _mtuSize;
  BluetoothConnectionState _connectionState = BluetoothConnectionState.disconnected;
  List<BluetoothService> _services = [];
  List<BluetoothService> _selectedservices = [];
   late ServicesList servicesList;
  bool _isDiscoveringServices = false;
  bool _isConnecting = false;
  bool _isDisconnecting = false;
  late StreamSubscription<BluetoothConnectionState> _connectionStateSubscription;
  late StreamSubscription<bool> _isConnectingSubscription;
  late StreamSubscription<bool> _isDisconnectingSubscription;
  late StreamSubscription<int> _mtuSubscription;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mtabcontroller=TabController(length: 3, vsync: this);
    mtabcontroller.addListener(() {

    });
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

      onDiscoverServicesPressed();

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





  Future onDiscoverServicesPressed() async {
    if (mounted) {
      setState(() {
        _isDiscoveringServices = true;
      });
    }
    try {
      _services = await widget.device.discoverServices();
      if(_services.isNotEmpty)
        {
          servicesList =await loadService();
          if(servicesList != null ||servicesList.services.isNotEmpty) {
            servicesList.services.forEach((aElement)
            {
            BluetoothService value = _services.firstWhere((bElement) => bElement.serviceUuid.toString().toLowerCase() == aElement.serviceUuid.toString().toLowerCase());
            if (value != null)
            {
              _selectedservices.add(value);
            }
          });
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


  TabBar get _tabBar => TabBar(
    indicatorColor: Color(0xff039597),
    indicatorSize: TabBarIndicatorSize.label,
    indicatorWeight: 5,
    labelColor: Color(0xffbdbdc1),
    labelStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
    controller: mtabcontroller,

    tabs:[
      const Tab(text: "Info",),
      const Tab(text: "Monitor",),
      const Tab(text: "Settings",)
    ],
  );

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
          InformationTabScreen(
            informationservice : _selectedservices.firstWhere((element) => element.serviceUuid.toString().toLowerCase() == AppConstants.InformationServiceUuid.toString().toLowerCase()),
            selectedservice:servicesList.services.firstWhere((element) => element.serviceUuid.toString().toLowerCase() == AppConstants.InformationServiceUuid.toString().toLowerCase())

          ),
          MonitorTabScreen(
              monitorservice : _selectedservices.firstWhere((element) => element.serviceUuid.toString().toLowerCase() == AppConstants.MonitorServiceUuid.toString().toLowerCase()),
              selectedservice:servicesList.services.firstWhere((element) => element.serviceUuid.toString().toLowerCase() == AppConstants.MonitorServiceUuid.toString().toLowerCase())

          ),
          SettingTabScreen(
              basicservice : _selectedservices.firstWhere((element) => element.serviceUuid.toString().toLowerCase() == AppConstants.BasicServiceUuid.toString().toLowerCase()),
             advancedservice : _selectedservices.firstWhere((element) => element.serviceUuid.toString().toLowerCase() == AppConstants.AdvancedServiceUuid.toString().toLowerCase()),
              selectedbasicservice:servicesList.services.firstWhere((element) => element.serviceUuid.toString().toLowerCase() == AppConstants.BasicServiceUuid.toString().toLowerCase()),
              selectedadvancedservice:servicesList.services.firstWhere((element) => element.serviceUuid.toString().toLowerCase() == AppConstants.AdvancedServiceUuid.toString().toLowerCase())


          ),
        ],
      ),
    );
  }
}
