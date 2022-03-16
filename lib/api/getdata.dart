import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

// https://firebasestorage.googleapis.com/v0/b/navierre-test.appspot.com/o/data.json?alt=media&token=95462ce7-0718-4111-87ca-6c2ae9c78180

class GetData {
  final String city;
  final String state;
  final String weather;
  final String alert;
  final double temp;
  final int precipitation;
  final int humidity;
  final int windspeed;
  final int sunrise;
  final int sunset;

   GetData({
    required this.city,
    required this.state,
    required this.weather,
    required this.alert,
    required this.temp,
    required this.precipitation,
    required this.humidity,
    required this.windspeed,
    required this.sunrise,
    required this.sunset,
  });

  factory GetData.fromJson(Map<String, dynamic> json) {
    return GetData(
      city: json['city'],
      state: json['state'],
      weather: json['current']['weather'][0]["main"],
      alert: json['alerts'][0]['description'],
      temp: json['current']['temp'],
      precipitation: json['current']['precipitation'],
      humidity: json['current']['humidity'],
      windspeed: json['current']['wind_speed'],
      sunrise: json['current']['sunrise'],
      sunset: json['current']['sunset'],
    );
  }


 

  static Future<GetData> getData(url) async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
     return GetData.fromJson(convert.jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
