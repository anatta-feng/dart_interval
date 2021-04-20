import 'dart:math';

class Interval implements Comparable {
  final int lowerBound;
  final int upperBound;

  final bool lowerClosed;
  final bool upperClosed;

  Interval._(this.lowerBound, this.upperBound,
      {this.lowerClosed = false, this.upperClosed = false});

  factory Interval.between(int a, int b,
      {bool lowerClosed = false, bool upperClosed = false}) {
    return Interval._(a, b, lowerClosed: lowerClosed, upperClosed: upperClosed);
  }

  @override
  String toString() {
    return "${lowerClosed ? '[' : '('}$lowerBound, $upperBound${upperClosed ? ']' : ')'}";
  }

  bool comes_before(Interval other) {
    if (this == other) {
      return false;
    } else if (this.lowerBound < other.lowerBound) {
      return true;
    } else if (this.lowerBound > other.lowerBound) {
      return false;
    } else if (this.lowerClosed == other.lowerClosed) {
      if (this.upperBound < other.upperBound) {
        return true;
      } else if (this.upperBound > other.upperBound ||
          this.upperClosed == other.upperClosed ||
          this.upperClosed) {
        return false;
      } else {
        return true;
      }
    } else if (this.lowerClosed) {
      return true;
    } else {
      return false;
    }
  }

  Interval operator &(Interval other) {
    Interval result;
    if (this == other) {
      result = Interval._(this.lowerBound, this.upperBound,
          lowerClosed: this.lowerClosed, upperClosed: this.upperClosed);
    } else if (this.comes_before(other)) {
      if (this.overlaps(other)) {
        int lower;
        bool lower_closed;
        if (this.lowerBound == other.lowerBound) {
          lower = this.lowerBound;
          lower_closed = this.lowerClosed && other.lowerClosed;
        } else if (this.lowerBound > other.lowerBound) {
          lower = this.lowerBound;
          lower_closed = this.lowerClosed;
        } else {
          lower = other.lowerBound;
          lower_closed = other.lowerClosed;
        }
        int upper;
        bool upper_closed;
        if (this.upperBound == other.upperBound) {
          upper = this.upperBound;
          upper_closed = this.upperClosed || other.upperClosed;
        } else if (this.upperBound < other.upperBound) {
          upper = this.upperBound;
          upper_closed = this.upperClosed;
        } else {
          upper = other.upperBound;
          upper_closed = other.upperClosed;
        }
        result = Interval._(lower, upper,
            lowerClosed: lower_closed, upperClosed: upper_closed);
      } else {
        result = Interval.none();
      }
    } else {
      result = this & other;
    }
    return result;
  }

  Interval operator |(Interval other) {
    if (this == other) {
      return this;
    } else {
      return this.join(other);
    }
  }

  @override
  int compareTo(other) {
    int result;
    if (this == other) {
      result = 0;
    } else if (this.comes_before(other)) {
      result = -1;
    } else {
      result = 1;
    }
    return result;
  }

  bool overlaps(Interval other) {
    bool result;
    if (this == other) {
      result = true;
    } else if (other.comes_before(this)) {
      result = other.overlaps(this);
    } else if (other.lowerBound < this.upperBound) {
      result = true;
    } else if (other.lowerBound == this.upperBound) {
      result = other.lowerClosed && this.upperClosed;
    } else {
      result = false;
    }
    return result;
  }

  bool adjacentTo(Interval other) {
    bool result;
    if (this.comes_before(other)) {
      if (this.upperBound == other.lowerBound) {
        result = this.upperClosed != other.lowerClosed;
      } else {
        result = false;
      }
    } else if (this == other) {
      result = false;
    } else {
      result = other.adjacentTo(this);
    }
    return result;
  }

  Interval join(Interval other) {
    if (this.overlaps(other) || this.adjacentTo(other)) {
      int lbound;
      bool linc;
      if (this.lowerBound < other.lowerBound) {
        lbound = this.lowerBound;
        linc = this.lowerClosed;
      } else if (this.lowerBound == other.lowerBound) {
        lbound = this.lowerBound;
        linc = this.lowerClosed || other.lowerClosed;
      } else {
        lbound = other.lowerBound;
        linc = other.lowerClosed;
      }
      int ubound;
      bool uinc;
      if (this.upperBound > other.upperBound) {
        ubound = this.upperBound;
        uinc = this.upperClosed;
      } else if (this.upperBound == other.upperBound) {
        ubound = this.upperBound;
        uinc = this.upperClosed || other.upperClosed;
      } else {
        ubound = other.upperBound;
        uinc = other.upperClosed;
      }
      return Interval._(lbound, ubound, upperClosed: uinc, lowerClosed: linc);
    } else {
      throw Exception("The Intervals are disjoint.");
    }
  }

  static Interval none() {
    return Interval._(0, 0);
  }
}

abstract class BaseIntervalSet {
  List<Interval> _intervals = List.empty(growable: true);

  BaseIntervalSet(List<Interval> items) {
    for (var value in items) {
      this._add(value);
    }
    this._intervals.sort();
  }

  int get length => _intervals.length;

  @override
  String toString() {
    var rangeStr = "";

    if (this._intervals.isEmpty) {
      rangeStr = "<Empty>";
    } else {
      rangeStr = this._intervals.join(",");
    }

    return rangeStr;
  }

  void _add(Interval item) {
    List<Interval> newIntervals = List.empty(growable: true);
    for (var value in this._intervals) {
      if (value.overlaps(item) || value.adjacentTo(item)) {
        item = item.join(value);
      } else {
        newIntervals.add(value);
      }
    }
    newIntervals.add(item);
    this._intervals = newIntervals;
    this._intervals.sort();
  }

  List<Interval> operator +(List<Interval> other) {
    for (var value in other) {
      _add(value);
    }
    return this._intervals;
  }

  Interval operator [](int index) {
    return this._intervals[index];
  }

  void add(Interval value) {
    this._add(value);
  }

  void addAll(Iterable<Interval> iterable) {
    for (var value in iterable) {
      this._add(value);
    }
  }

  Interval elementAt(int index) {
    return this._intervals.elementAt(index);
  }

  void forEach(void Function(Interval element) f) {
    this._intervals.forEach(f);
  }

  bool get isEmpty => this._intervals.isEmpty;

  bool get isNotEmpty => this._intervals.isNotEmpty;

  Iterator<Interval> get iterator => this._intervals.iterator;
}

class IntervalSet extends BaseIntervalSet {
  IntervalSet(List<Interval> items) : super(items);
}
