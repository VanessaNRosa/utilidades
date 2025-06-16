class TemperatureModel {
  double currentTemperature;
  List<double> previousTemperatures;
  double? averageTemperature;

  TemperatureModel({
    required this.currentTemperature,
    required this.previousTemperatures,
    this.averageTemperature
  });
}