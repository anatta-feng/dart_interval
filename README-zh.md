语言: [英语](README.md) | [中文](README-zh.md)

# dart_interval

[![Build Status](https://travis-ci.com/T-Oner/dart_interval.svg?branch=main)](https://travis-ci.com/github/T-Oner/dart_interval)

这个库提供了 Dart 语言的区间数据结构和运算。

## 安装

执行以下命令

```shell
dart pub add dart_interval
```

或者在你的项目 `pubspec.yaml` 中添加：

```yaml
dependencies:
  dart_interval: ^0.1.0
```

## 特性

- `Interval` - 区间的数据结构。
- `IntervalSet` - 合并区间。
- `Interval & Interval` - 区间的交集运算
- `Interval | Interval` - 区间的并集运算

## 示例

- [Simple example](./example/main.dart) - Api 示例.

## 如何使用

### 创建一个区间:

```dart
import 'package:dart_interval/dart_interval.dart';

final v1 = Interval.between(1, 3, lowerClosed: false, upperClosed: false);
```

### 合并区间:

```dart
final v1 = Interval.between(1, 3);
final v2 = Interval.between(2, 5);
final v3 = Interval.between(7, 9);
final set = IntervalSet([v1, v2, v3]);
print(set);
// output: [1, 5],[7, 9]
```

### 区间之间做交集运算:

```dart
print(v1 & v2);
// output: [2, 3]
```

### 区间之间做并集运算:

```dart
print(v1 | v2);
// output: [1, 5]
```

或者

```dart
print(IntervalSet([v1, v2]));
// output: [1, 5]
```