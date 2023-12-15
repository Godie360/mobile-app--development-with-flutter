import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(AreaCalculator());
}

class AreaCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Calculate Circle Area',
        home: CalculatorScreen(),
        debugShowCheckedModeBanner: false);
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  TextEditingController radiusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calculate Circle Area',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'Roboto'),
        ),
        centerTitle: false,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: radiusController,
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(labelText: 'Enter radius (in meters)'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
                onPressed: () {
                  calculateArea(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                child: Text('Calculate Area',
                    style: TextStyle(color: Colors.white))),
          ],
        ),
      ),
    );
  }

  void calculateArea(BuildContext context) {
    double radius = double.tryParse(radiusController.text) ?? 0.0;
    double area = pi * pow(radius, 2);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Result',
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0), //
          ),
          content: Text('Area: $area'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
