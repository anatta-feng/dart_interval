import 'package:dart_interval/dart_interval.dart';
import 'package:test/test.dart';

void main() {
  test("test Interval", () {
    var v1 = Interval.between(1, 3);
    expect(v1.toString(), '(1, 3)');
  });

  test("test Interval merging", () {
    var v1 = Interval.between(1, 3);
    var v2 = Interval.between(2, 4);
    var v3 = Interval.between(6, 8);
    var intervalSet = IntervalSet([v1, v2, v3]);
    expect(intervalSet.toString(), '(1, 4),(6, 8)');
  });

  test("test Interval intersection", () {
    var v1 = Interval.between(1, 3);
    var v2 = Interval.between(2, 4);
    var result = v1 & v2;
    expect(result.toString(), "(2, 3)");
  });
  
  test("test Interval union", () {
    var v1 = Interval.between(1, 3);
    var v2 = Interval.between(2, 4);
    var result = v1 | v2;
    expect(result.toString(), "(1, 4)");
  });
}
