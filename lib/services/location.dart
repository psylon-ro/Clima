import 'package:geolocator/geolocator.dart';

class Location {
  double lAtitide;
  double lOngitude;
  Future<void> getCurrentlocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );
      lAtitide = position.latitude;
      lOngitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
