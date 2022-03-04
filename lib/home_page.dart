import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:practica1/providers/frase.dart';
import 'package:practica1/providers/hora.dart';
import 'package:practica1/providers/imagen.dart';

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
  final String _quoteURL = "https://zenquotes.io/api/random";
  final String _imageURL = "https://picsum.photos/750/1200";
  String _quote = "";
  String _author = "";

  int ind = 1;

  bool loaded = false;

  //late DateTime _epoch;

  Future _getQuote() async {
    try {
      Response response = await get(Uri.parse(_quoteURL));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        _quote = result[0]['q'] as String;
        _author = result[0]['a'] as String;
      }
    } catch (e) {
      print(e);
    }

    Response response = await get(
        Uri.parse("http://worldtimeapi.org/api/timezone/America/Mexico_City"));
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      var fecha = new DateTime.fromMillisecondsSinceEpoch(
              (result['unixtime'] + result['raw_offset']) * 1000)
          .toUtc();

      _time = DateFormat("HH:mm:ss").format(fecha);
      //print(_time);

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
                        "${paises[ind]}",
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
        headerHeight: MediaQuery.of(context).size.height / 1.5,
        appBar: BackdropAppBar(
          title: Text("Frase del dia"),
          actions: <Widget>[
            BackdropToggleButton(
              icon: AnimatedIcons.list_view,
            )
          ],
        ),
        backLayer: Container(
          child: Container(
            height: MediaQuery.of(context).size.height / 4.2,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Container(
                        child: Image.network(
                            'https://flagcdn.com/32x24/${banderas[index]}.png')),
                    title: Text("${paises[index]}",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    onTap: () {
                      _tapButton(index);
                    },
                  );
                }),
          ),
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

  Future _tapButton(int index) async {
    loaded = false;
    context.read<PhraseProvider>().changeQuote();
    context.read<BackgroundProvider>().changeBackground();
    context.read<HourProvider>().changeCountry(index);
    loaded = true;
  }
}
