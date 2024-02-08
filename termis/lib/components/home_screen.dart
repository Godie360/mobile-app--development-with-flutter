import 'package:flutter/material.dart';
import 'package:termis/components/image_banner.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Stack(
            children: <Widget>[ImageBanner("assets/images/1.jpg")],
          ),
          Text('welcome')
        ],
      ),
    );
  }
}
