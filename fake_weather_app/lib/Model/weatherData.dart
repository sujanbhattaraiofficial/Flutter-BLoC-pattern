import 'package:equatable/equatable.dart';

class WeatherData extends Equatable {
  final String cityName;
  final double temprature;

  WeatherData({this.cityName, this.temprature});
  @override
  // TODO: implement props
  List<Object> get props => [cityName, temprature];

  double getTemp() {
    return temprature;
  }
  String get city => cityName;
}
