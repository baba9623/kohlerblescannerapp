import 'package:kohlerblescannerapp/models/setting_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDataBase{

  //private constructor(singleton)
  AppDataBase._();
  static final AppDataBase instance=AppDataBase._();

  Database? myDB;
  ///table
  static final String SETTING_TABLE ="basicsettings";

  ///columns
  static final String SETTING_ID ="settingId";
  static final String SETTING_NAME ="name";
  static final String SETTING_VALUE ="value";

  Future<Database> initDB() async{
    var docdirectory =await getApplicationDocumentsDirectory();
    var dbpath = join(docdirectory.path,"blescannerDb.db");
   return await openDatabase(
     dbpath,
     version: 1,
     onCreate: (db,version){
       //Create tables

       db.execute("create table $SETTING_TABLE ( $SETTING_ID integer primary key autoincrement, $SETTING_NAME text, $SETTING_VALUE text)");
     }
   );
  }

  Future<Database> getDB() async {
    if(myDB != null)
      {
        return myDB!;
      }
    else
    {
     myDB = await initDB();
     return myDB!;
    }
  }

  void addSetting(SettingModel settingModel) async {
    var db = await getDB();
    db.insert(SETTING_TABLE, settingModel.toMap());
  }

  Future<List<SettingModel>> fetchsetting() async{
   var db = await getDB();
   List<SettingModel> arrSettings=[];

   var data = await db.query(SETTING_TABLE);
   for(Map<String,dynamic> eachsetting in data)
     {
       SettingModel settingModel =SettingModel.fromMap(eachsetting);
       arrSettings.add(settingModel);
     }
   return arrSettings;
  }

  void deleteSetting() async{
    var db = await getDB();
    db.delete(SETTING_TABLE, where: "");
  }

}