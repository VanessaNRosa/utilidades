import 'dart:async';
import 'dart:isolate';
import 'dart:math';

import 'package:flutter/foundation.dart';

class TemperatureModel {
  final double currentTemperature;
  final List<double> previousTemperatures;
  final double? averageTemperature;

  TemperatureModel({
    required this.currentTemperature,
    required this.previousTemperatures,
    required this.averageTemperature,
  });
}

class TemperatureController {
  final ValueNotifier<TemperatureModel> temperatureNotifier;
  StreamSubscription<double>? _temperatureSubscription;

  TemperatureController()
    : temperatureNotifier = ValueNotifier(
        TemperatureModel(
          currentTemperature: 0,
          previousTemperatures: [],
          averageTemperature: null,
        ),
      );

  Future<void> loadInitialTemperature() async {
    await Future.delayed(Duration(seconds: 2));
    final random = Random();
    final initialTemperature = 20 + random.nextDouble() * 10;

    temperatureNotifier.value = TemperatureModel(
      currentTemperature: initialTemperature,
      previousTemperatures: [initialTemperature],
      averageTemperature: null,
    );

    _startTemperatureStream();
  }

  void _startTemperatureStream() {
    _temperatureSubscription?.cancel();

    final stream = Stream<double>.periodic(Duration(seconds: 2), (_) {
      final random = Random();
      final variation = -1 + (random.nextDouble() * 2);
      final current = temperatureNotifier.value.currentTemperature;
      final newTemp = (current + variation).clamp(15, 23);
      return double.parse(newTemp.toStringAsFixed(1));
    });

    _temperatureSubscription = stream.listen((newTemp) {
      final currentModel = temperatureNotifier.value;

      final updatedList = [...currentModel.previousTemperatures, newTemp];

      if (updatedList.length > 10) {
        updatedList.removeAt(0);
      }

      temperatureNotifier.value = TemperatureModel(
        currentTemperature: newTemp,
        previousTemperatures: updatedList,
        averageTemperature: currentModel.averageTemperature,
      );
    });
  }

  Future<void> calculateAverageTemperature() async {
    final temperatures = temperatureNotifier.value.previousTemperatures;

    if (temperatures.isEmpty) {
      temperatureNotifier.value = TemperatureModel(
        currentTemperature: temperatureNotifier.value.currentTemperature,
        previousTemperatures: temperatures,
        averageTemperature: null,
      );
      return;
    }

    final average = await Isolate.run(() {
      final sum = temperatures.reduce((a, b) => a + b);
      return sum / temperatures.length;
    });

    temperatureNotifier.value = TemperatureModel(
      currentTemperature: temperatureNotifier.value.currentTemperature,
      previousTemperatures: temperatures,
      averageTemperature: average,
    );
  }

  void dispose() {
    _temperatureSubscription?.cancel();
    temperatureNotifier.dispose();
  }
}
