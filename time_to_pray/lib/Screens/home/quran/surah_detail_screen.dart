import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SurahDetailScreen extends StatefulWidget {
  List<dynamic>? text;
  SurahDetailScreen({super.key, this.text});

  @override
  State<SurahDetailScreen> createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: widget.text!.length,
            itemBuilder: (context, index) {
              return Align(
                  alignment: Alignment.topRight,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          index == 0
                              // ignore: avoid_unnecessary_containers
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
                              "${widget.text![index]["text"]} ",
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
                  ));
            },
          ),
        ),
      ),
    );
  }
}
