import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class ConfessionCardViewModel {
  Future<String> getLocationName() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    Placemark placemark = placemarks.first;
    return '${placemark.locality}, ${placemark.country}';
  }
}
