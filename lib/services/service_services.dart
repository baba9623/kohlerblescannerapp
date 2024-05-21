import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import '../Constants/app_constants.dart';
import '../Utils/snackbar.dart';
import '../models/properties_model.dart';
import '../models/service_model.dart';
import 'package:collection/collection.dart';

Future<String> _loadServiceAsset() async {
  return await rootBundle.loadString('assets/json/services.json');
}

Future<ServicesList> loadService() async {
  String jsonService = await _loadServiceAsset();
  final jsonResponse = json.decode(jsonService);
  ServicesList Services = new ServicesList.fromJson(jsonResponse);
  return Services;
}

Future<String> ReadData (BluetoothCharacteristic characteristics) async {
  List<int> rawdata= await characteristics.read();
  String str ="";
  if(characteristics.serviceUuid.toString().toLowerCase() == AppConstants.InformationServiceUuid.toString().toLowerCase())
    {
          if(characteristics.characteristicUuid.toString().toLowerCase() == AppConstants.AdvNameCharacteristicsUuid.toString().toLowerCase())
            {
             return str = String.fromCharCodes(rawdata);
            }
          if(characteristics.characteristicUuid.toString().toLowerCase() == AppConstants.SkuNumberCharacteristicsUuid.toString().toLowerCase())
          {
            return str = String.fromCharCodes(rawdata);
          }
          if(characteristics.characteristicUuid.toString().toLowerCase() == AppConstants.SkuConfigDateCharacteristicsUuid.toString().toLowerCase())
          {
            String date = String.fromCharCodes(rawdata);
            String week = date.substring(0,2);
            String year =date.substring(2);
            return str = "Week of $week, 20$year";
          }
          if(characteristics.characteristicUuid.toString().toLowerCase() == AppConstants.McuFirmwareCharacteristicsUuid.toString().toLowerCase())
          {

            String ver  = rawdata.join(".");
            return str ="V $ver";
          }
          if(characteristics.characteristicUuid.toString().toLowerCase() == AppConstants.BleFirmwareCharacteristicsUuid.toString().toLowerCase())
          {
            String ver  = rawdata.join(".");
            return str ="V $ver";
          }
          if(characteristics.characteristicUuid.toString().toLowerCase() == AppConstants.ProductionDateCharacteristicsUuid.toString().toLowerCase())
          {
            String date = String.fromCharCodes(rawdata);
            String week = date.substring(0,2);
            String year =date.substring(2);
            return str = "Week of $week, 20$year";
          }
    }
    if(characteristics.serviceUuid.toString().toLowerCase() == AppConstants.MonitorServiceUuid.toString().toLowerCase())
    {
      if(characteristics.characteristicUuid.toString().toLowerCase() == AppConstants.BatteryStatusCharacteristicsUuid.toString().toLowerCase())
      {
        if(rawdata[0] == 0 || rawdata[0] == 00)
        {
           return str="Normal";
        }
        if(rawdata[0] == 1 || rawdata[0] == 01)
        {
          return str="Low";
        }
        if(rawdata[0] == 2 || rawdata[0] == 02)
        {
          return str="Critical";
        }
        if(rawdata[0] == 3 || rawdata[0] == 03)
        {
          return str="Adc fail";
        }

      }
      if(characteristics.characteristicUuid.toString().toLowerCase() == AppConstants.FlushCountCharacteristicsUuid.toString().toLowerCase())
      {
        var num = bytesToInteger(rawdata).toString();
        return str =num;
      }
      if(characteristics.characteristicUuid.toString().toLowerCase() == AppConstants.LowFlushCountCharacteristicsUuid.toString().toLowerCase())
      {
        var num = bytesToInteger(rawdata).toString();
        return str =num;
      }
    }
    if(characteristics.serviceUuid.toString().toLowerCase() == AppConstants.BasicServiceUuid.toString().toLowerCase())
    {
      if(characteristics.characteristicUuid.toString().toLowerCase() == AppConstants.DualFlushCharacteristicsUuid.toString().toLowerCase())
       {
         if(rawdata[0] == 0 || rawdata[0] == 00)
         {
           return str="Disabled";
         }
         if(rawdata[0] == 1 || rawdata[0] == 01)
         {
           return str="Enabled";
         }
       }
      if(characteristics.characteristicUuid.toString().toLowerCase() == AppConstants.DualFlushTimeThresholdCharacteristicsUuid.toString().toLowerCase())
      {
        var num = bytesToInteger(rawdata).toString();
        return str ="$num ms";
      }
      if(characteristics.characteristicUuid.toString().toLowerCase() == AppConstants.SentinelFlushCharacteristicsUuid.toString().toLowerCase())
      {
        if(rawdata[0] == 0 || rawdata[0] == 00)
        {
          return str="Disabled";
        }
        if(rawdata[0] == 1 || rawdata[0] == 01)
        {
          return str="Enabled";
        }
      }
      if(characteristics.characteristicUuid.toString().toLowerCase() == AppConstants.SentinelFlushIntervalCharacteristicsUuid.toString().toLowerCase())
      {
        if(rawdata[0] > 0)
        {
          int data =rawdata[0];
          return str="$data hrs";
        }

      }
    }
   if(characteristics.serviceUuid.toString().toLowerCase() == AppConstants.AdvancedServiceUuid.toString().toLowerCase())
    {
      if(characteristics.characteristicUuid.toString().toLowerCase() == AppConstants.SensorDistanceCharacteristicsUuid.toString().toLowerCase())
        {
          if(rawdata[0] > 0)
          {
            int data =rawdata[0];
            return str="$data inch";
          }
        }
      if(characteristics.characteristicUuid.toString().toLowerCase() == AppConstants.FlushDelayOutTimeCharacteristicsUuid.toString().toLowerCase())
      {
       var num = bytesToInteger(rawdata).toString();
       return str ="$num ms";
      }
      if(characteristics.characteristicUuid.toString().toLowerCase() == AppConstants.SensorIdleTimingCharacteristicsUuid.toString().toLowerCase())
      {
        var num = bytesToInteger(rawdata).toString();
        return str ="$num ms";
      }
      if(characteristics.characteristicUuid.toString().toLowerCase() == AppConstants.SensorLatchTimingCharacteristicsUuid.toString().toLowerCase())
      {
        var num = bytesToInteger(rawdata).toString();
        return str ="$num ms";
      }
      if(characteristics.characteristicUuid.toString().toLowerCase() == AppConstants.ArmingDelayInTimeCharacteristicsUuid.toString().toLowerCase())
      {
        var num = bytesToInteger(rawdata).toString();
        return str ="$num ms";
      }
    }
  return str;

}

num bytesToInteger(List<int> bytes) {
    num value = 0;
  if (Endian.host == Endian.big) {
    bytes = List.from(bytes.reversed);
  }
  for (var i = 0, length = bytes.length; i < length; i++) {
    value += bytes[i] * pow(256, i);
  }
  return value;
}

Uint8List integerToBytes(int value) {
  const arrayLength = 4;
  Uint8List hexdata = Uint8List(arrayLength)..buffer.asByteData().setInt32(0, value, Endian.little);
  return hexdata.sublist(0,2);
}

Uint8List integerTofourBytes(int value) {
  const arrayLength = 4;
  return Uint8List(arrayLength)..buffer.asByteData().setInt32(0, value, Endian.little);
}

Future<String> onWrite(BluetoothCharacteristic bluetoothCharacteristic,String value) async {
  try
  {
     List<int> rowdata =[];
     if(bluetoothCharacteristic.characteristicUuid.toString().toLowerCase() == AppConstants.DualFlushCharacteristicsUuid.toString().toLowerCase() || bluetoothCharacteristic.characteristicUuid.toString().toLowerCase() == AppConstants.SentinelFlushCharacteristicsUuid.toString().toLowerCase())
       {
         if(value == "Disabled")
           {
             rowdata=[00];
           }
         else
           {
             rowdata=[01];
           }
       }
     else if(bluetoothCharacteristic.characteristicUuid.toString().toLowerCase() == AppConstants.SentinelFlushIntervalCharacteristicsUuid.toString().toLowerCase() || bluetoothCharacteristic.characteristicUuid.toString().toLowerCase() == AppConstants.SensorDistanceCharacteristicsUuid.toString().toLowerCase())
       {
       rowdata.add(int.parse(value));
       }
     else if(bluetoothCharacteristic.characteristicUuid.toString().toLowerCase() == AppConstants.DualFlushTimeThresholdCharacteristicsUuid.toString().toLowerCase())
       {
       int currentValue = int.parse(value);
       rowdata = integerTofourBytes(currentValue);
       }
     else
       {
       int currentValue = int.parse(value);
       rowdata = integerToBytes(currentValue);
       print("row data is $rowdata");
       }

     await bluetoothCharacteristic.write(rowdata);
     Snackbar.show(ABC.c, "Write: Success", success: true);
     print("success");
     return "success";

  } catch (e)
  {
    Snackbar.show(ABC.c, prettyException("Write Error:", e), success: false);
    return "failed";
  }
}

Future<PropertiesModel> onDiscoverServices(BluetoothDevice device, ServicesList servicesList) async {
  List<BluetoothService> services = [];
  List<BluetoothCharacteristic> informationCharacteristics=[];
  List<BluetoothCharacteristic> monitorCharacteristics=[];
  List<BluetoothCharacteristic> basicCharacteristics=[];
  List<BluetoothCharacteristic> advancedCharacteristics=[];
  try
  {
    services = await device.discoverServices();
    if(services.isNotEmpty || servicesList != null ||servicesList.services.isNotEmpty)
    {
      for(BluetoothService service in services)
      {
        if(service.serviceUuid.toString().toLowerCase() == AppConstants.InformationServiceUuid.toString().toLowerCase())
        {
          ServiceModel informationserviceModel=  servicesList.services.firstWhere((element) => element.serviceUuid.toString().toLowerCase() == AppConstants.InformationServiceUuid.toString().toLowerCase());
          if(informationserviceModel != null ||informationserviceModel.characteristics.isNotEmpty) {
            for (var aElement in informationserviceModel.characteristics) {
              BluetoothCharacteristic value = service.characteristics.firstWhere((bElement) => bElement.characteristicUuid.toString().toLowerCase() == aElement.characteristicUuid.toString().toLowerCase());
              if (value != null)
              {
                informationCharacteristics.add(value);
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
                monitorCharacteristics.add(value);
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
                basicCharacteristics.add(value);
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
                advancedCharacteristics.add(value);
              }
            }
          }
        }
      }


    }

    Snackbar.show(ABC.c, "Discover Services: Success", success: true);

  } catch (e)
  {
    Snackbar.show(ABC.c, prettyException("Discover Services Error:", e), success: false);
  }
      PropertiesModel propertiesModel = PropertiesModel(
      informationServiceCharacteristics: informationCharacteristics,
      monitorServiceCharacteristics: monitorCharacteristics,
      basicServiceCharacteristics: basicCharacteristics,
      advancedServiceCharacteristics: advancedCharacteristics
  );
  return propertiesModel;


}






