import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class PropertiesModel{
  List<BluetoothCharacteristic> informationServiceCharacteristics;
  List<BluetoothCharacteristic> monitorServiceCharacteristics;
  List<BluetoothCharacteristic> basicServiceCharacteristics;
  List<BluetoothCharacteristic> advancedServiceCharacteristics;

  PropertiesModel({required this.informationServiceCharacteristics,required this.monitorServiceCharacteristics, required this.basicServiceCharacteristics,required this.advancedServiceCharacteristics});
}