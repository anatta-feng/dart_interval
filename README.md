Language: [English](README.md) | [Chinese](README-zh.md)

# dart_interval

[![Build Status](https://travis-ci.com/T-Oner/dart_interval.svg?branch=main)](https://travis-ci.com/github/T-Oner/dart_interval)

This library provides data structure and operations for intervals in Dart.

## Installation

Depend on it

Run this command:

With Dart:

```shell
dart pub add dart_interval
```

Or add this to your project's `pubspec.yml`:

```yaml
dependencies:
  dart_interval: ^0.1.0
```

## Feature

- `Interval` - The interval data structure.
- `IntervalSet` - The interval merging.
- `Interval & Interval` - The interval intersection calculation
- `Interval | Interval` - The interval union calculation

## Examples

- [Simple example](./example/main.dart) - Api example.

## Usage

### Create a Interval:

```dart
import 'package:dart_interval/dart_interval.dart';

final v1 = Interval.between(1, 3, lowerClosed: false, upperClosed: false);
```

### Merge the intervals:

```dart
final v1 = Interval.between(1, 3);
final v2 = Interval.between(2, 5);
final v3 = Interval.between(7, 9);
final set = IntervalSet([v1, v2, v3]);
print(set);
// output: [1, 5],[7, 9]
```

### Interval intersection calculation:

```dart
print(v1 & v2);
// output: [2, 3]
```

### Interval union calculation:

```dart
print(v1 | v2);
// output: [1, 5]
```

or

```dart
print(IntervalSet([v1, v2]));
// output: [1, 5]
```