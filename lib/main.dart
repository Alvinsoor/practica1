import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica1/bloc/background_bloc.dart';
import 'package:practica1/bloc/hour_bloc.dart';
import 'package:practica1/bloc/phrase_bloc.dart';
import 'home_page.dart';

Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};

MaterialColor colorCustom = MaterialColor(0xFF880E4F, color);

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Practica 1',
      theme: ThemeData(primarySwatch: colorCustom),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PhraseBloc()..add(PhraseUpdateEvent()),
          ),
          BlocProvider(
            create: (context) => BackgroundBloc()..add(BackgroundUpdateEvent()),
          ),
          BlocProvider(
            create: (context) => HourBloc()..add(HourUpdateEvent()),
          ),
        ],
        child: HomePage(),
      ),
    );
  }
}
