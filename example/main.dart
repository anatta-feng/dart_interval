import 'package:dart_interval/dart_interval.dart';

void main() {
  final v3 = Interval.between(7, 9, lowerClosed: false, upperClosed: false);
  final v1 = Interval.between(1, 3);
  final v2 = Interval.between(2, 5);
  final set = IntervalSet([v1, v2, v3]);

  print(set);
  print(v1 & v2);
  print(v1 | v2);
}