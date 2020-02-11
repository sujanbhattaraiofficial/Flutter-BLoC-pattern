import 'dart:convert';
import 'package:fake_weather_app/BLoC/weather_event.dart';
import 'package:fake_weather_app/BLoC/weather_state.dart';
import 'package:fake_weather_app/Model/weatherData.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class WeatherManageBloc extends Bloc<WeatherEvent, WeatherState> {
  @override
  WeatherState get initialState => NotSearchingState();
  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is GetWeatherFromSearchBar) {
      yield SearchingState();
      try {
        final weather = await _fetchWeatherData(event.cityName);
        yield SearchedState(weather);
      } catch (exception) {
        print(exception);
      }
    } else if (event is AgainGetWeatherFromSearchBar) {
      yield SearchingState();
      yield NotSearchingState();
    }
  }

  Future<WeatherData> _fetchWeatherData(String cityName) async {
    // use AIP if you want to.
    // final result = await http.Client().get(
    //     "http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=d885aa1d783fd13a55050afeef620fcb");
    // if (result.statusCode != 200) {
    //   throw Exception("not connected");
    // } else {
    //   ok();
    //   return parsedJasonData(result.body);
    // }
    return (WeatherData(temprature: 20.0));
  }

  // WeatherData parsedJasonData(response) {
  //   final dataDecode = json.decode(response);
  //   final weatherDecode = dataDecode["main"];
  //   return WeatherData.fromJson(weatherDecode);
  // }

  ok() {
    print("connected");
  }
}
