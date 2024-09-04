import 'dart:js_interop';

/// This object exposes a js-interop API to read the initialData passed fromJS.
extension type ChartInitialData(JSObject _) implements JSObject {
  @JS('value')
  external num get _value;
  double get value => _value.toDouble();
}
