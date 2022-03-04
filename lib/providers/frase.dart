import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class PhraseProvider with ChangeNotifier {
  final String _quoteURL = "https://zenquotes.io/api/random";

  String author = "";
  String quote = "";

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

  Future<void> changeQuote() async {
    await _getQuote();

    notifyListeners();
  }
}
