class TemperatureModel {
  double currentTemperature;
  List<double> previousTemperatures;
  double? averageTemperature;
  final bool isLoading;

  TemperatureModel({
    required this.currentTemperature,
    required this.previousTemperatures,
    this.averageTemperature,
    required this.isLoading,
  });
}