import 'package:dart_interval/dart_interval.dart';

void main() {
  final v1 = Interval.between(552, 858);
  final v2 = Interval.between(2, 5);
  final v3 = Interval.between(516, 923);
  final v4 = Interval.between(7, 9);
  final set = IntervalSet([v1, v2, v3]);

  print(set);
  print(v1 & v3);
  print(v2 & v4);
}