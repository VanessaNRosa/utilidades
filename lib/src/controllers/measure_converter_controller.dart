import 'dart:convert';

import 'package:utilidades/src/models/measure_converter_model.dart';

class MeasureConverterController {

late MeasureConverterModel _model;

void setInputValue(String value){
  value = value.replaceAll(",", ".");
  final parsedValue = double.tryParse(value) ?? 0.0;
  _model = MeasureConverterModel(
    inputValue: parsedValue, 
    fromUnit: _model.fromUnit, 
    toUnit: _model.toUnit
    );
}

void setUnits (Unit from, Unit to){
  _model = MeasureConverterModel(
    inputValue: _model.inputValue, 
    fromUnit: from, 
    toUnit: to);
}

void InitializeModel(){
  _model = MeasureConverterModel(
    inputValue: 0.0,
    fromUnit: Unit.meter,
    toUnit: Unit.centimeter
  );
}

String get result => _model.convert().toStringAsFixed(2);

}