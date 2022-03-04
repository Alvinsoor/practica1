import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'hour_event.dart';
part 'hour_state.dart';

final selectedCountry = [
  "Europe/Andorra",
  "America/Mexico_City",
  "America/Lima",
  "America/Vancouver",
  "America/Argentina/Salta"
];

class HourBloc extends Bloc<HourEvent, HourState> {
  HourBloc() : super(HourInitial()) {
    on<HourEvent>(loadHour);
  }

  int index = 1;

  void loadHour(HourEvent event, Emitter emit) async {
    // TODO: implement event handler
    var time = await _getHour();

    if (time == null) {
      emit(HourErrorState(errorMsg: 'Error message'));
    } else {
      emit(HourSuccessState(time: time));
    }
  }

  Future _getHour() async {
    try {
      Response response = await get(Uri.parse(
          "http://worldtimeapi.org/api/timezone/${selectedCountry[index]}"));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        var fecha = new DateTime.fromMillisecondsSinceEpoch(
                (result['unixtime'] + result['raw_offset']) * 1000)
            .toUtc();

        final _time = DateFormat("HH:mm:ss").format(fecha);
        print(_time);

        return _time;
      }
    } catch (e) {
      print(e);
    }
  }

  // TODO: implement event handler
}
