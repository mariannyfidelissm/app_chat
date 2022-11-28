import 'package:flutter/material.dart';

class ArquivadasPage extends StatefulWidget {
  const ArquivadasPage({Key? key}) : super(key: key);

  @override
  State<ArquivadasPage> createState() => _ArquivadasPageState();
}

class _ArquivadasPageState extends State<ArquivadasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('s')),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/back.jpg"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
