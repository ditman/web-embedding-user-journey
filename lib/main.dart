import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'nice_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ChartPage(),
    );
  }
}

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return ChartPageState();
  }
}

class ChartPageState extends State<ChartPage> {
  late double value;
  late Timer timer;

  double _computeValue() => Random().nextDouble() * 100;

  ChartPageState() {
    // The value should come from JavaScript.
    value = _computeValue();
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        value = _computeValue();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: NiceChart(
          value: value,
        ),
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    timer.cancel();
  }
}
