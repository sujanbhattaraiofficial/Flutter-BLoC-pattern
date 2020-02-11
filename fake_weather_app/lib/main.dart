import 'package:fake_weather_app/BLoC/weather_event.dart';
import 'package:fake_weather_app/BLoC/weather_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fake_weather_app/BLoC/weather_manage_bloc.dart';
import 'BLoC/weather_manage_bloc.dart';
import 'Model/weatherData.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider(
          create: (context) => WeatherManageBloc(),
          child: WeatherPage(),
        ));
  }
}

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final weatherBloc = WeatherManageBloc();

  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherManageBloc>(context);
    TextEditingController controller = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WeatherManageBloc, WeatherState>(
            bloc: weatherBloc,
            builder: (BuildContext context, WeatherState state) {
              if (state is NotSearchingState) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Search weather",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        child: TextFormField(
                          controller: controller,
                          textInputAction: TextInputAction.search,
                          cursorColor: Colors.red,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              focusColor: Colors.red,
                              filled: true,
                              hoverColor: Colors.red,
                              hintText: "Search City",
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(200)),
                                borderSide: BorderSide(color: Colors.green),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide:
                                      BorderSide(color: Colors.transparent))),
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: RaisedButton(
                          color: Colors.blue,
                          onPressed: () {
                            weatherBloc
                                .add(GetWeatherFromSearchBar(controller.text));
                          },
                          child: Text(
                            "Search",
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              } else if (state is SearchingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SearchedState) {
                return ShowWeatherData(state.weatherData, controller.text);
              }
            }),
      ),
    );
  }
}

class ShowWeatherData extends StatelessWidget {
  final WeatherData weatherData;
  final String cityName;
  const ShowWeatherData(this.weatherData, this.cityName);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(weatherData.temp.toString() + "°C"),
          Text(cityName),
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: 50.0,
            width: double.infinity,
            child: RaisedButton(
              onPressed: () {
                BlocProvider.of<WeatherManageBloc>(context)
                    .add(AgainGetWeatherFromSearchBar());
              },
              color: Colors.blue,
              child: Text("Search Again"),
            ),
          )
        ],
      ),
    );
  }
}
