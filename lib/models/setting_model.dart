import 'package:kohlerblescannerapp/local_database/app_db.dart';

class SettingModel{
  int setting_id;
  String setting_name;
  String setting_value;

  SettingModel({
    required this.setting_id,
    required this.setting_name,
    required this.setting_value
});

  //from map  --> Model
  factory SettingModel.fromMap(Map<String,dynamic> map){
    return SettingModel(
        setting_id: map[AppDataBase.SETTING_ID],
        setting_name: map[AppDataBase.SETTING_NAME],
        setting_value: map[AppDataBase.SETTING_VALUE]);
  }

  //Model --> to map
 Map<String,dynamic> toMap()
 {
   return{
     AppDataBase.SETTING_NAME : setting_name,
     AppDataBase.SETTING_VALUE : setting_value
   };
 }

}