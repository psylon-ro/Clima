import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apikey = '3eb08187809c947e6a3e19de396f9bb6';

class WeatherModel {
  Future<dynamic> getcityweather(String cityname) async {
    Networking data = Networking(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=$apikey&units=metric');
    var weatherdata = await data.getData();
    return weatherdata;
  }

  Future<dynamic> getlocationweather() async {
    Location location = Location();
    await location.getCurrentlocation();

    Networking data = Networking(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.lAtitide}&lon=${location.lOngitude}&appid=$apikey&units=metric');
    var weatherdata = await data.getData();
    return weatherdata;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
