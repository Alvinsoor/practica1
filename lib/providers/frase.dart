import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class PhraseProvider with ChangeNotifier {
  final selectedCountry = [
    "Europe/Andorra",
    "America/Mexico_City",
    "America/Peru",
    "America/Vancouver",
    "America/Argentina/Salta"
  ];

  late int hora, minuto, segundo;

  final String _quoteURL = "https://zenquotes.io/api/random";
  late String _imageURL;
  String author = "";
  String quote = "";
  var rng = new Random();
  late var seed;

  Future _getQuote() async {
    try {
      Response response = await get(Uri.parse(_quoteURL));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print(result);

        author = result[0]["a"];
        quote = result[0]["q"];
      }
    } catch (e) {
      print(e);
    }
  }

  Future _getBackground() async {
    seed = rng.nextInt(999999999999999999);
    _imageURL = "https://picsum.photos/seed/${seed}/1000/1500";
  }

  Future _getHour(int index) async {}

  Future<void> changeQuote(int index) async {
    await _getQuote();
    await _getBackground();

    notifyListeners();
  }
}
