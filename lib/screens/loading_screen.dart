import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = '77ba117405532dc770fefe94903a59be';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  double latitude;
  double longitude;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();

    latitude = location.latitude;
    longitude = location.longitude;

    getData();
  }
  
  void getData() async {
    http.Response response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');
    if (response.statusCode == 200) {
      String data = response.body;

      var decodeData = jsonDecode(data);  // creating the dynamic variable here reduces repetition in code below

      double temperature = decodeData['main']['temp'];
      int condition = decodeData['weather'][0]['id'];  // we add the [0] b/c looking at the JSON we see an unknown
                                        //(and unclear) list so have to access the first item, which gives the data
      String cityName = decodeData['name'];

      print(temperature);
      print(condition);
      print(cityName);

      var weatherDescription = jsonDecode(data) ['weather'][0]['description'];

      print(weatherDescription);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold();
  }
}
