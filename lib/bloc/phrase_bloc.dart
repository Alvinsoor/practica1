import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

part 'phrase_event.dart';
part 'phrase_state.dart';

class PhraseBloc extends Bloc<PhraseEvent, PhraseState> {
  PhraseBloc() : super(PhraseInitial()) {
    on<PhraseEvent>(loadPhrase);
  }

  final String _quoteURL = "https://zenquotes.io/api/random";

  void loadPhrase(PhraseEvent event, Emitter emit) async {
    // TODO: implement event handler
    var json = await _getPhrase();

    if (json == null) {
      emit(PhraseErrorState(errorMsg: 'Error message'));
    } else {
      final String author = json[0]["a"];
      final String quote = json[0]["q"];
      emit(PhraseSuccessState(author: author, quote: quote));
    }
  }

  Future _getPhrase() async {
    try {
      Response response = await get(Uri.parse(_quoteURL));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        return result;
      }
    } catch (e) {
      print(e);
    }
  }
}
