import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/service_model.dart';

Future<String> _loadServiceAsset() async {
  return await rootBundle.loadString('assets/json/services.json');
}

Future<ServicesList> loadService() async {
  String jsonService = await _loadServiceAsset();
  final jsonResponse = json.decode(jsonService);
  ServicesList Services = new ServicesList.fromJson(jsonResponse);
  return Services;
}




