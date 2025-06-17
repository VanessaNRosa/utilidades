import 'package:flutter/material.dart';
import 'package:utilidades/src/controllers/temperature_controller.dart';

class TemperatureView extends StatefulWidget {
  const TemperatureView({super.key});

  @override
  State<TemperatureView> createState() => _TemperatureViewState();
}

class _TemperatureViewState extends State<TemperatureView> {
  final TemperatureController _temperatureController = TemperatureController();

  @override
  void dispose() {
    _temperatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _temperatureController.temperatureNotifier,
      builder: (context, temperature, _) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Tempo em Blumenau hoje",
                  style: TextStyle(fontSize: 24, color: Colors.black),
                ),
                const SizedBox(height: 16),
                const Icon(Icons.sunny, size: 64, color: Colors.amber),
                const SizedBox(height: 16),

                // Temperatura atual ou loading
                temperature.isLoading
                    ? const CircularProgressIndicator()
                    : Text(
                        "${temperature.currentTemperature.toStringAsFixed(1)}°C",
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),

                const SizedBox(height: 8),
                const Text(
                  "Temperatura atual",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 146, 191, 228),
                  ),
                ),
                const SizedBox(height: 8),

                SizedBox(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () async {
                      await _temperatureController.loadInitialTemperature();
                    },
                    child: const Text(
                      "Carregar Temperatura",
                      style: TextStyle(
                        color: Color.fromARGB(255, 96, 130, 158),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 60),

                Text(
                  temperature.averageTemperature != null
                      ? "${temperature.averageTemperature!.toStringAsFixed(1)}°C"
                      : "--°C",
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Temperatura média",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 146, 191, 228),
                  ),
                ),
                const SizedBox(height: 8),

                SizedBox(
                  height: 50,
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      _temperatureController.calculateAverageTemperature();
                    },
                    child: const Text(
                      "Calcular Temperatura Média",
                      style: TextStyle(
                        color: Color.fromARGB(255, 96, 130, 158),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}