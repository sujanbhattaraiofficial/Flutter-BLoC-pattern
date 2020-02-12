import 'package:equatable/equatable.dart';
import 'package:real_weather_app/Model/weatherData.dart';

class WeatherState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class NotSearchingState extends WeatherState {}

class SearchingState extends WeatherState {}

class SearchedState extends WeatherState {
  final WeatherData weatherData;

  SearchedState(this.weatherData);

  @override
  // TODO: implement props
  List<Object> get props => [weatherData];
}
