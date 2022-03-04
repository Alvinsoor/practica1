import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'hour_event.dart';
part 'hour_state.dart';

class HourBloc extends Bloc<HourEvent, HourState> {
  HourBloc() : super(HourInitial()) {
    on<HourEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
