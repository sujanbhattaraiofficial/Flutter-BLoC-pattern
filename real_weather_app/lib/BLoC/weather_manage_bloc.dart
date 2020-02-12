import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_weather_app/BLoC/weather_event.dart';
import 'package:real_weather_app/BLoC/weather_state.dart';
import 'package:real_weather_app/Model/weatherData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherManageBloc extends Bloc<WeatherEvent, WeatherState> {
  @override
  // TODO: implement initialState
  WeatherState get initialState => NotSearchingState();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is GetWeatherDataFromSearchBar) {
      yield SearchingState();

      try {
        final weather = await _fetchWeatherData(event.cityName);
        yield SearchedState(weather);
      } catch (exception) {
        print(exception);
      }
    } else if (event is ResetWeatherData) {
      yield NotSearchingState();
    }
  }

  Future<WeatherData> _fetchWeatherData(String cityName) async {
    //use api
    final result = await http.Client().get(
        'http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=d885aa1d783fd13a55050afeef620fcb');
    if (result.statusCode != 200) {
      throw Exception();
    } else {
      return parsedJson(result.body);
    }
  }

  WeatherData parsedJson(final response) {
    final responseData = json.decode(response);
    final weatherData = responseData["main"];
    return WeatherData.fromJson(weatherData);
  }
}
