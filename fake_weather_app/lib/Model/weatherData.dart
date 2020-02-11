import 'package:equatable/equatable.dart';

class WeatherData extends Equatable {
  final double temprature;

  WeatherData({this.temprature});
  @override
  // TODO: implement props
  List<Object> get props => [temprature];

  double get temp => temprature;

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(temprature: json["temp"]);
  }
}
