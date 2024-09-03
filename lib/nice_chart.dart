import 'package:flutter/material.dart';
import 'package:geekyants_flutter_gauges/geekyants_flutter_gauges.dart';

/// Renders a Gauge chart for [value] (between 0 and 100).
class NiceChart extends StatelessWidget {
  const NiceChart({required this.value, super.key})
      : assert(
            value >= 0,
            'NiceChart can only render values in the range: [0, 100]. '
            'Received: $value'),
        assert(
            value <= 100,
            'NiceChart can only render values in the range: [0, 100]. '
            'Received: $value');

  final double value;

  @override
  Widget build(BuildContext context) {
    final Color color = _sampleColor(value / 100);

    // Compute the values from the actual size of the widget so it looks nicer.
    final double thickness = 40;
    final double fontSize = 72;

    return Stack(
      alignment: Alignment.center,
      children: [
        RadialGauge(
          valueBar: [
            RadialValueBar(
              color: color,
              value: value,
              valueBarThickness: thickness,
            )
          ],
          track: RadialTrack(
            start: 0,
            end: 100,
            thickness: thickness,
            color: Colors.black12,
            trackStyle: const TrackStyle(
              showLabel: false,
              showSecondaryRulers: false,
              showPrimaryRulers: false,
            ),
          ),
        ),
        Text(
          value.round().toString(),
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: fontSize,
              ),
        ),
      ],
    );
  }
}

// Return the Color at the 't'-th stop of a lerp of 'colors'.
Color _sampleColor(double t, {List<Color> colors = colors}) {
  assert (t >= 0 && t <= 100);
  if (t == 1.0) {
    return colors.last;
  }

  double scaledT = t * (colors.length - 1);
  int first = scaledT.truncate();

  // HSV gradients look way better than RGB.
  final HSVColor sampledHSV = HSVColor.lerp(
    HSVColor.fromColor(colors[first]),
    HSVColor.fromColor(colors[first + 1]),
    scaledT.decimal(),
  )!;

  return sampledHSV.toColor();
}

// A bad-to-good gradient.
const colors = [Colors.red, Colors.yellow, Colors.green];

// Returns the decimal part of a positive double.
extension on double {
  double decimal() {
    assert(this >= 0);
    return this - floor();
  }
}
