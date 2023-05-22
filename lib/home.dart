import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF27282E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "EMI Calculator",
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(
          top: 20,
          left: 5,
          right: 5,
        ),
        decoration: const BoxDecoration(
          color: Color(0xFF252A31),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF42474B),
              spreadRadius: 3,
              blurRadius: 3,
              offset: Offset(-5, -5),
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Slider(
              min: 15000,
              max: 100000,
              value: 15000,
              onChanged: (value) {},
            ),
          ],
        ),
      ),
    );
  }
}
