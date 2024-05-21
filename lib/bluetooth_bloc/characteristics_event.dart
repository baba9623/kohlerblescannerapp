part of 'characteristics_bloc.dart';

@immutable
abstract class CharacteristicsEvent {}

class WriteCharacteristicsEvent extends CharacteristicsEvent{
  BluetoothCharacteristic bluetoothCharacteristic;
  String value;
  BluetoothDevice device;
  WriteCharacteristicsEvent({required this.bluetoothCharacteristic, required this.value, required this.device});

}

class FetchAllCharacteristicsEvent extends CharacteristicsEvent{
  BluetoothDevice device;
  FetchAllCharacteristicsEvent({required this.device});
}
