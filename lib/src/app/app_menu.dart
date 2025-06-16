import 'package:flutter/material.dart';
import 'package:utilidades/src/models/menu_model.dart';
import 'package:utilidades/src/views/about_view.dart';
import 'package:utilidades/src/views/measure_converter_view.dart';
import 'package:utilidades/src/views/home_view.dart';
import 'package:utilidades/src/views/temperature_view.dart';

final List<MenuModel> appMenuItems = [
  MenuModel(
    title: "Home",
    icon: Icons.home,
    route: "/home",
    page: const HomeView(),
  ),
  MenuModel(
    title: "Sobre mim",
    icon: Icons.person_sharp,
    route: "/about",
    page: AboutView(),
  ),
  MenuModel(
    title: "Conversor de medidas",
    icon: Icons.square_foot,
    route: "/convertermedidas",
    page: ConverterView(),
  ),

  MenuModel(
    title: "Temperatura",
    icon: Icons.device_thermostat,
    route: "/temperatura",
    page: TemperatureView(),
  ),
];
