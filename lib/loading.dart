import 'package:flutter/material.dart';
import 'data/my_location.dart';
import 'data/network.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  final ButtonStyle style = ElevatedButton.styleFrom(
    textStyle: const TextStyle(
      color: Colors.white,
    ),
    backgroundColor: Colors.blueAccent,
  );

  late double latitude3;
  late double longitude3;
  static const String _apiKey = '398f8a0d0df86eb9c5bb0270c2d1490f';

  void getLocation() async {
    MyLocation myLocation = MyLocation();

    // getMyCurrentLocation이 Future<void>를 return하게 만들어서
    // await 처리를 하도록 만들어 준다.
    await myLocation.getMyCurrentLocation();

    latitude3 = myLocation.latitude2;
    longitude3 = myLocation.longitude2;

    Network network = Network(
      url:
          'https://api.openweathermap.org/data/2.5/weather?lat=$latitude3&lon=$longitude3&appid=$_apiKey',
    );

    var weatherData = await network.getJsonData();
    print('weather data : $weatherData');
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: style,
              onPressed: getLocation,
              child: const Text(
                'Get my location',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
