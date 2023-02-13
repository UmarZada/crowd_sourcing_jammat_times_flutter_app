import 'package:flutter/material.dart';

class CircularDesignWidget extends StatelessWidget {
  String? imagePath;
  String? imageName;
  CircularDesignWidget({super.key, this.imagePath, this.imageName});

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey,
            backgroundImage: AssetImage(imagePath.toString()),
          ),
          const SizedBox(
            height: 2.0,
          ),
          Text(imageName.toString()),
        ],
      ),
    );
  }
}
