import 'package:bloc/bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:meta/meta.dart';

import '../models/properties_model.dart';
import '../models/service_model.dart';
import '../services/service_services.dart';

part 'characteristics_event.dart';
part 'characteristics_state.dart';

class CharacteristicsBloc extends Bloc<CharacteristicsEvent, CharacteristicsState> {
  CharacteristicsBloc() : super(CharacteristicsInitial()) {

    on<WriteCharacteristicsEvent>((event, emit) async {
      emit(CharacteristicLoadingState());
      var result = await onWrite(event.bluetoothCharacteristic,event.value);
      if(result == "success")
        {
          emit(CharacteristicLoadingState());
          await Future.delayed(const Duration(seconds: 5));
          ServicesList servicesList= await loadService();
          if(servicesList.services.isNotEmpty)
            {
              PropertiesModel propertiesModel =await onDiscoverServices(event.device,servicesList);
              emit(CharacteristicLoadedState(propertiesModel: propertiesModel));
            }
          else
            {
              emit(CharacteristicErrorState(errorMsg: "services not loaded"));
            }

        }
      else
        {
          emit(CharacteristicErrorState(errorMsg: "discover service error"));
        }
    });

    on<FetchAllCharacteristicsEvent>((event, emit) async{
      emit(CharacteristicLoadingState());
      ServicesList servicesList= await loadService();
      if(servicesList.services.isNotEmpty)
      {
        PropertiesModel propertiesModel =await onDiscoverServices(event.device,servicesList);
        emit(CharacteristicLoadedState(propertiesModel: propertiesModel));
      }
      else
      {
        emit(CharacteristicErrorState(errorMsg: "services not loaded"));
      }
    });
  }
}
