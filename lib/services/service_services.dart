import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import '../Constants/app_constants.dart';
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

Future<String> ReadData (BluetoothCharacteristic characteristics) async
{
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
            return str = "Week Of $week , 20$year";
          }
          if(characteristics.characteristicUuid.toString().toLowerCase() == AppConstants.McuFirmwareCharacteristicsUuid.toString().toLowerCase())
          {

            return str = rawdata.join(".");
          }
          if(characteristics.characteristicUuid.toString().toLowerCase() == AppConstants.BleFirmwareCharacteristicsUuid.toString().toLowerCase())
          {
            return str = rawdata.join(".");
          }
          if(characteristics.characteristicUuid.toString().toLowerCase() == AppConstants.ProductionDateCharacteristicsUuid.toString().toLowerCase())
          {
            String date = String.fromCharCodes(rawdata);
            String week = date.substring(0,2);
            String year =date.substring(2);
            return str = "Week Of $week , 20$year";
          }
    }
    if(characteristics.serviceUuid.toString().toLowerCase() == AppConstants.MonitorServiceUuid.toString().toLowerCase())
    {
      if(characteristics.characteristicUuid.toString().toLowerCase() == AppConstants.BatteryStatusCharacteristicsUuid.toString().toLowerCase())
      {
        if(rawdata[0] == 0 || rawdata[0] == 00)
        {
           return str="normal";
        }
        if(rawdata[0] == 1 || rawdata[0] == 01)
        {
          return str="low";
        }
        if(rawdata[0] == 2 || rawdata[0] == 02)
        {
          return str="critical";
        }
        if(rawdata[0] == 3 || rawdata[0] == 03)
        {
          return str="adc fail";
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
  return Uint8List(arrayLength)..buffer.asByteData().setInt32(0, value, Endian.little);
}








