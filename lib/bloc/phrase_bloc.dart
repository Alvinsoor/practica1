import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'phrase_event.dart';
part 'phrase_state.dart';

class PhraseBloc extends Bloc<PhraseEvent, PhraseState> {
  PhraseBloc() : super(PhraseInitial()) {
    on<PhraseEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
