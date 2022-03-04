import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:backdrop/backdrop.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

//http get method

class _HomePageState extends State<HomePage> {
  var paises = ["Andorra", "Mexico", "Peru", "Canada", "Argentina"];

  var banderas = ["ad", "mx", "pe", "ca", "ar"];

  String _time = "";

  String _imageURL = "https://picsum.photos/750/1200";
  String _quote = "";
  String _author = "";
  int hour = 0, min = 0, sec = 0;
  final String _quoteURL = "https://zenquotes.io/api/random";

  //late DateTime _epoch;

  Future _getQuote() async {
    try {
      Response response = await get(Uri.parse(_quoteURL));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        _quote = result[0]['q'] as String;
        _author = result[0]['a'] as String;
        _imageURL = "https://picsum.photos/750/1200";
      }
    } catch (e) {
      print(e);
    }

    Response response = await get(
        Uri.parse("http://worldtimeapi.org/api/timezone/America/Lima"));
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      var fecha = new DateTime.fromMillisecondsSinceEpoch(
              (result['unixtime'] + result['raw_offset']) * 1000)
          .toUtc();

      _time = DateFormat("HH:mm:ss").format(fecha);
      print(_time);

      //_time = result['datetime'] as String;
      //var hora = _time.split(":");

      //print(hora);

      return result;
    }
  }

  SafeArea onSuccess() {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Image.network(_imageURL,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
              color: const Color.fromRGBO(87, 87, 87, 0.7),
              colorBlendMode: BlendMode.modulate),
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 40.0, 8.0, 12.0),
                  child: Column(
                    children: [
                      Center(
                          child: Text(
                        "Mexico",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      )),
                      Center(
                          child: Text(
                        _time,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                        ),
                      )),
                      SizedBox(height: 150),
                      ListTile(
                        title: Text(_quote,
                            style:
                                TextStyle(color: Colors.white, fontSize: 22)),
                        subtitle: Text(_author,
                            style: TextStyle(
                              color: Colors.white,
                            )),
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Center onLoading() {
    return Center(child: new CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
        appBar: BackdropAppBar(
          title: Text("Frase del dia"),
          actions: <Widget>[
            BackdropToggleButton(
              icon: AnimatedIcons.list_view,
            )
          ],
        ),
        backLayer: Container(
          child: ListView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Container(
                      child: Image.asset("assets/${banderas[index]}.png")),
                  title: Text("${paises[index]}",
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                  onTap: () {},
                );
              }),
        ),
        frontLayer: FutureBuilder(
            future: _getQuote(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> result) {
              if (result.hasData) {
                return onSuccess();
              } else {
                return onLoading();
              }
            }));
  }
}
