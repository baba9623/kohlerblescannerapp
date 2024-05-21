part of 'characteristics_bloc.dart';

@immutable
abstract class CharacteristicsState {}

final class CharacteristicsInitial extends CharacteristicsState {}

class CharacteristicLoadingState extends CharacteristicsState{}

class CharacteristicLoadedState extends CharacteristicsState{
  PropertiesModel propertiesModel;
  CharacteristicLoadedState({required this.propertiesModel});
}
class CharacteristicErrorState extends CharacteristicsState{
  String errorMsg='';
  CharacteristicErrorState({required this.errorMsg});
}
