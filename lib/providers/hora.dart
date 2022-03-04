import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HourProvider with ChangeNotifier {
  final selectedCountry = [
    "Europe/Andorra",
    "America/Mexico_City",
    "America/Lima",
    "America/Vancouver",
    "America/Argentina/Salta"
  ];

  late int hora, minuto, segundo;
}
