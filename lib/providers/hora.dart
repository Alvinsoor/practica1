import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class HourProvider with ChangeNotifier {
  final selectedCountry = [
    "Europe/Andorra",
    "America/Mexico_City",
    "America/Lima",
    "America/Vancouver",
    "America/Argentina/Salta"
  ];

  String _time = "";

  Future _getQuote() async {
    try {
      Response response = await get(Uri.parse(
          "http://worldtimeapi.org/api/timezone/America/Mexico_City"));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        var fecha = new DateTime.fromMillisecondsSinceEpoch(
                (result['unixtime'] + result['raw_offset']) * 1000)
            .toUtc();

        _time = DateFormat("HH:mm:ss").format(fecha);
        print(_time);

        return result;
      }
    } catch (e) {
      print(e);
    }
  }
}
