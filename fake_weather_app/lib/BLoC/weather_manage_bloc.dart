import 'dart:math';
import 'package:fake_weather_app/BLoC/weather_event.dart';
import 'package:fake_weather_app/BLoC/weather_state.dart';
import 'package:fake_weather_app/Model/weatherData.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

class WeatherManageBloc extends Bloc<WeatherEvent, WeatherState> {
  @override
  WeatherState get initialState => NotSearchingState();
  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is GetWeatherFromSearchBar) {
      yield SearchingState();
      final weather = await _fetchWeatherData(event.cityName);
      yield SearchedState(weather);
    } else if (event is AgainGetWeatherFromSearchBar) {
      yield SearchingState();
      yield NotSearchingState();
    }
  }

  Future<WeatherData> _fetchWeatherData(String cityName) {
    return Future.delayed(Duration(seconds: 1), () {
      return WeatherData(
          cityName: cityName,
          temprature: 20 + Random().nextInt(25) + Random().nextDouble());
    });
  }
}
