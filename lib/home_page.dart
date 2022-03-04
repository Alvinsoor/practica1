import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:practica1/bloc/background_bloc.dart';
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

  int ind = 1;

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
                    //onTap: () {},
                  );
                }),
          ),
        ),
        frontLayer: SafeArea(
          child: Stack(
            children: <Widget>[
              BlocConsumer<BackgroundBloc, BackgroundState>(
                builder: (context, state) {
                  if (state is BackgroundErrorState) {
                    return Center(child: Text("Failure."));
                  } else if (state is BackgroundSuccessState) {
                    return Image.memory(state.bytes,
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height,
                        color: const Color.fromRGBO(87, 87, 87, 0.7),
                        colorBlendMode: BlendMode.modulate);
                  } else {
                    return Center(child: new CircularProgressIndicator());
                  }
                },
                listener: (context, state) {},
              ),
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
                            "10:10:12",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                            ),
                          )),
                          SizedBox(height: 150),
                          ListTile(
                            title: Text("I like big booty bitches.",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22)),
                            subtitle: Text("Descartes",
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
        ));
  }

  // Future _tapButton(int index) async {
  //   loaded = false;
  //   context.read<PhraseProvider>().changeQuote();
  //   context.read<BackgroundProvider>().changeBackground();
  //   context.read<HourProvider>().changeCountry(index);
  //   loaded = true;
  // }
}
