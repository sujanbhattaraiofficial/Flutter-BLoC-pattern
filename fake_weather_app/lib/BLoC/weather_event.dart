import 'package:equatable/equatable.dart';

class WeatherEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class GetWeatherFromSearchBar extends WeatherEvent {
  final String cityName;

  GetWeatherFromSearchBar(this.cityName);
  @override
  // TODO: implement props
  List<Object> get props => [cityName];
}

class AgainGetWeatherFromSearchBar extends WeatherEvent {}
