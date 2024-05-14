import '../colors/hex_color.dart';

class AppConstants{
 static final  backgroundcolor=HexColor("#272931");
 static final  appbarbackgroundcolor =HexColor("#2D2F38");
 static final buttonbacgroundcolor=HexColor("#039597");

 static const String InformationServiceUuid ="F26013B4-6B6E-459E-AC80-D04CD6ED682D";
 static const String MonitorServiceUuid ="89D18878-9C8D-4A64-A23D-62CD1C656FE8";
 static const String BasicServiceUuid ="220F02DC-30E3-4403-A148-2C213D974FE3";
 static const String AdvancedServiceUuid ="E729C847-7E6F-4D01-A615-37052E141A23";


 ///Information service characteristics
 static const String AdvNameCharacteristicsUuid ="F2601743-6B6E-459E-AC80-D04CD6ED682D";
 static const String SkuNumberCharacteristicsUuid ="F2601744-6B6E-459E-AC80-D04CD6ED682D";
 static const String SkuConfigDateCharacteristicsUuid ="F2601757-6B6E-459E-AC80-D04CD6ED682D";
 static const String McuFirmwareCharacteristicsUuid ="F2601725-6B6E-459E-AC80-D04CD6ED682D";
 static const String BleFirmwareCharacteristicsUuid ="F2601726-6B6E-459E-AC80-D04CD6ED682D";
 static const String ProductionDateCharacteristicsUuid ="F2601758-6B6E-459E-AC80-D04CD6ED682D";


 ///Monitoring service characteristics
 static const String BatteryStatusCharacteristicsUuid ="89D11736-9C8D-4A64-A23D-62CD1C656FE8";
 static const String FlushCountCharacteristicsUuid ="89D11732-9C8D-4A64-A23D-62CD1C656FE8";
 static const String LowFlushCountCharacteristicsUuid ="89D11733-9C8D-4A64-A23D-62CD1C656FE8";

 ///Basic service characteristics
 static const String DualFlushCharacteristicsUuid ="220F1727-30E3-4403-A148-2C213D974FE3";
 static const String DualFlushTimeThresholdCharacteristicsUuid ="220F1728-30E3-4403-A148-2C213D974FE3";
 static const String SentinelFlushCharacteristicsUuid ="220F1730-30E3-4403-A148-2C213D974FE3";
 static const String SentinelFlushIntervalCharacteristicsUuid ="220F1731-30E3-4403-A148-2C213D974FE3";

 ///Advaned service characteristics
 static const String SensorDistanceCharacteristicsUuid ="E7291738-7E6F-4D01-A615-37052E141A23";
 static const String FlushDelayOutTimeCharacteristicsUuid ="E7291755-7E6F-4D01-A615-37052E141A23";
 static const String SensorIdleTimingCharacteristicsUuid ="E7291752-7E6F-4D01-A615-37052E141A23";
 static const String SensorLatchTimingCharacteristicsUuid ="E7291753-7E6F-4D01-A615-37052E141A23";
 static const String ArmingDelayInTimeCharacteristicsUuid ="E7291754-7E6F-4D01-A615-37052E141A23";

}