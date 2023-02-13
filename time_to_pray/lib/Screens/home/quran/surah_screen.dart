import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:time_to_pray/Screens/home/quran/surah_detail_screen.dart';

class SurahScreen extends StatefulWidget {
  const SurahScreen({super.key});

  @override
  State<SurahScreen> createState() => _SurahScreenState();
}

class _SurahScreenState extends State<SurahScreen> {
  var data;
  final List<Map<String, dynamic>> list = [];
  getRequet() async {
    try {
      final response = await http
          .get(Uri.parse('http://api.alquran.cloud/v1/quran/quran-uthmani'));
      if (response.statusCode == 200) {
        print("data found");
        data = jsonDecode(response.body.toString());

        for (var i = 0; i <= 113; i++) {
          list.add(data['data']['surahs'][i]);
        }

        print(data['data']["surahs"][0]["name"]);

        print(list);
        setState(() {});
      } else {
        print("Data not found");
      }
    } catch (e) {
      // ignore: avoid_print
      print("${e.toString()}");
    }
    return data;
  }

  @override
  void initState() {
    getRequet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("======${list.length}");
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ElevatedButton(
            //   onPressed: () {
            //     getRequet();
            //   },
            //   child: Text("test"),
            // ),
            Container(
              height: MediaQuery.of(context).size.height - 20.0,
              width: double.infinity,
              child: list.isEmpty
                  // ignore: avoid_unnecessary_containers
                  ? Container(
                      child: const Center(child: CircularProgressIndicator()),
                    )
                  : ListView.builder(
                      itemCount: list.length,
                      itemBuilder: ((context, index) {
                        return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SurahDetailScreen(
                                        text: list[index]["ayahs"],
                                      )));
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 15.0,
                                      width: 25.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        color: Colors.black,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${index + 1}",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10.0),
                                        ),
                                      ),
                                    ),
                                    test(list[index]["name"]),
                                  ],
                                ),
                              ),
                            ));
                      }),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget test(String text) {
    return Align(
      alignment: Alignment.topRight,
      child: Text(
        text,
        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}
