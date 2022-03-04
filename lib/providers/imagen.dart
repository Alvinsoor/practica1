import 'dart:async';

import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BackgroundProvider with ChangeNotifier {
  late String _imageURL;
  late ByteData _imageData;
  late Uint8List _bytes;

  Future _getBackground() async {
    var rng = new Random();
    var seed = rng.nextInt(999999);
    _imageURL = "https://picsum.photos/seed/${seed}/1000/1500";

    _imageData = await NetworkAssetBundle(Uri.parse(_imageURL)).load("");
    _bytes = _imageData.buffer.asUint8List();
  }

  Uint8List get bytes => _bytes;

  // display it with the Image.memory widget
  //Image.memory(bytes);

  Future changeBackground() async {
    await _getBackground();
    print("background execute");

    notifyListeners();
  }
}
