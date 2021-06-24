import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';

class LocationScreen extends StatefulWidget {
  final wheatherinfo;
  LocationScreen(this.wheatherinfo);
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weathertexts = WeatherModel();
  String temperaturetext;
  int temperature;
  String conditionsIcon;
  String cityname;
  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        conditionsIcon = 'oops';
        temperaturetext = 'something went wrong';
        cityname = "";
      } else {
        var temp = weatherData['main']['temp'];
        temperature = temp.toInt();
        temperaturetext = weathertexts.getMessage(temperature);
        int conditions = weatherData['weather'][0]['id'];
        conditionsIcon = weathertexts.getWeatherIcon(conditions);
        String cityName = weatherData['name'];
        cityname = 'in $cityName';
        print("i was called");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    updateUI(widget.wheatherinfo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      onPressed: () async {
                        var weatherdata =
                            await weathertexts.getlocationweather();
                        updateUI(weatherdata);
                        print("button pressed");
                      },
                      child: Icon(
                        Icons.near_me,
                        size: 50.0,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        var citytext = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CityScreen();
                            },
                          ),
                        );
                        if (citytext != null) {
                          var weahtergo =
                              await weathertexts.getcityweather(citytext);
                          updateUI(weahtergo);
                        }
                      },
                      child: Icon(
                        Icons.location_city,
                        size: 50.0,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '$temperature°',
                        style: kTempTextStyle,
                      ),
                      Text(
                        conditionsIcon,
                        style: kConditionTextStyle,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    "$temperaturetext $cityname!",
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
