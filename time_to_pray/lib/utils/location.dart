import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

Position? position;
List<Placemark>? placeMarks;
String completeAddress = "";
bool isload = false;

final String id = DateTime.now().millisecondsSinceEpoch.toString();
String lat = "34.0151";
String lng = "71.5249";

getCurrentLocation() async {
  Position newPosition = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high, //for high accuracy like exact one
  );
  position = newPosition;
  placeMarks = await placemarkFromCoordinates(
    // take latitude,longitude
    position!.latitude,
    position!.longitude,
  );
  lat = position!.latitude.toString();
  lng = position!.longitude.toString();

  Placemark pMark = placeMarks![0];
  completeAddress =
      "${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality},${pMark.subAdministrativeArea}";
  // "${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality},${pMark.subAdministrativeArea} ${pMark.administrativeArea} ${pMark.postalCode},${pMark.country}";
}
