import 'package:flutter/services.dart';

class ServicesList{
  List<ServiceModel> services;

  ServicesList({required this.services});

  factory ServicesList.fromJson(Map<String, dynamic> parsedJson){

    var list = parsedJson['services'] as List;
    List<ServiceModel> services = list.map((i) => ServiceModel.fromJson(i)).toList();

    return ServicesList(
        services: services
    );
  }
}


class ServiceModel
{
   String serviceUuid;
   String name;
   String displayName;
   List<CharacteristicModel> characteristics;
  ServiceModel({required this.serviceUuid, required this.name, required this.displayName, required this.characteristics});

   factory ServiceModel.fromJson(Map<String, dynamic> parsedJson){

     var list = parsedJson['characteristics'] as List;
     List<CharacteristicModel> characteristicsList = list.map((i) => CharacteristicModel.fromJson(i)).toList();

     return ServiceModel(
         serviceUuid: parsedJson['serviceUuid'],
         name: parsedJson['name'],
         displayName:parsedJson['displayName'],
         characteristics: characteristicsList
     );
   }
}

class CharacteristicModel {
  String characteristicUuid;
  String name;
  CharacteristicModel({required this.characteristicUuid, required this.name});

  factory CharacteristicModel.fromJson(Map<String, dynamic> parsedJson){
    return CharacteristicModel(
        characteristicUuid:parsedJson['characteristicUuid'],
        name:parsedJson['name']
    );
  }
}







