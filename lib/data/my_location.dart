import 'package:geolocator/geolocator.dart';

class MyLocation {
  late double latitude2;
  late double longitude2;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // 데이터를 전달해 주는 부분
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<void> getMyCurrentLocation() async {
    try {
      // Future를 받을 때는 내부에 설정된 Generic type으로 지정.
      Position position = await _determinePosition();
      print('current position $position');
      latitude2 = position.latitude;
      longitude2 = position.longitude;

      print('latitude : $latitude2, longitude : $longitude2');
    } catch (e) {
      print('네트워크에 문제가 발생했습니다. 잠시 후 다시 시도해 주시기 바랍니다.');
    }
  }
}
