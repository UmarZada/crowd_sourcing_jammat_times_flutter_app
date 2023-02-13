import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../model/model_juz.dart';

class JuzDetailScreen extends StatefulWidget {
  int juzNumber;
  JuzDetailScreen({super.key, required this.juzNumber});

  @override
  State<JuzDetailScreen> createState() => _JuzDetailScreenState();
}

class _JuzDetailScreenState extends State<JuzDetailScreen> {
  List<Ayahs> juzlist = [];
  Future<List<Ayahs>> _getData() async {
    final response = await http
        .get(Uri.parse('http://api.alquran.cloud/v1/juz/${widget.juzNumber}'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data["data"]["ayahs"]) {
        //print(i["status"])
        juzlist.add(Ayahs.fromJson(i));
      }
      return juzlist;
    } else {
      return juzlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _getData(),
        builder: (context, AsyncSnapshot<List<Ayahs>> snapshot) {
          if (!snapshot.hasData) {
            // ignore: avoid_unnecessary_containers
            return Container(
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: juzlist.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        index == 0
                            ? Container(
                                child: const Icon(Icons.star),
                              )
                            : Container(
                                height: 15.0,
                                width: 25.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.black,
                                ),
                                child: Center(
                                  child: Text(
                                    index.toString(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 10.0),
                                  ),
                                ),
                              ),
                        Expanded(
                          child: Text(
                            //widget.text.toString(),
                            snapshot.data![index].text.toString(),
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
