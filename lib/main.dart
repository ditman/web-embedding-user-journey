import 'dart:js_interop';
import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';
import 'multi_view_app.dart';
import 'nice_chart.dart';

void main() {
  runWidget(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiViewApp(viewBuilder: _buildView);
  }

  Widget _buildView(BuildContext context) {
    final double valueFromJs = _getValueFromJs(context);
    return MaterialApp(
      home: ChartPage(value: valueFromJs),
    );
  }

  double _getValueFromJs(BuildContext context) {
    final int viewId = View.of(context).viewId;
    // The following is web-only code, and would crash in mobile...
    final Object? initialData = ui_web.views.getInitialData(viewId).dartify();
    return (initialData as Map)['value'] as double;
  }
}

class ChartPage extends StatelessWidget {
  const ChartPage({super.key, required this.value});
  final double value;

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
}
