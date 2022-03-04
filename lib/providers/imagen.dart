import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class BackgroundProvider with ChangeNotifier {
  late String _imageURL;

  Future _getBackground() async {
    var rng = new Random();
    var seed = rng.nextInt(999999999999999999);
    _imageURL = "https://picsum.photos/seed/${seed}/1000/1500";
  }

  Future<void> changeQuote() async {
    await _getBackground();

    notifyListeners();
  }
}
