import 'dart:convert';
import 'package:http/http.dart' as http;

var data;
String fajr1 = "";
String sunrise1 = '';
String dhuhr1 = '';
String asr1 = '';
String sunset1 = '';
String maghrib1 = '';
String isha1 = '';
String imsak1 = '';
String midnight1 = '';
String firstthird1 = '';
String lastthird1 = '';
final List<Map<String, dynamic>> list = [];
Future<void> getTimings(String monthNumber, String yearNo, int index) async {
  int myIndex = index - 1;
  try {
    final response = await http.get(Uri.parse(
        'http://api.aladhan.com/v1/calendar?latitude=51.508515&longitude=-0.1254872&method=2&month=${monthNumber}&year=${yearNo}'));

    if (response.statusCode == 200) {
      print("data found");
      data = jsonDecode(response.body.toString());
      print("====Index is $index");
      var mytime = data["data"][myIndex];
      print(mytime["timings"]["Fajr"]);
      fajr1 = mytime["timings"]["Fajr"];
      sunrise1 = mytime["timings"]["Sunrise"];
      dhuhr1 = mytime["timings"]["Dhuhr"];
      asr1 = mytime["timings"]["Asr"];
      sunset1 = mytime["timings"]["Sunset"];
      maghrib1 = mytime["timings"]["Maghrib"];
      isha1 = mytime["timings"]["Isha"];
      imsak1 = mytime["timings"]["Imsak"];
      midnight1 = mytime["timings"]["Midnight"];
      firstthird1 = mytime["timings"]["Firstthird"];
      lastthird1 = mytime["timings"]["Lastthird"];
    } else {}
  } catch (e) {
    // ignore: avoid_print
    print(e.toString());
  }
  return data;
}
