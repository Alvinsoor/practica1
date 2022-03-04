import 'dart:math';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

part 'background_event.dart';
part 'background_state.dart';

class BackgroundBloc extends Bloc<BackgroundEvent, BackgroundState> {
  BackgroundBloc() : super(BackgroundInitial()) {
    on<BackgroundEvent>(loadBackground);
  }

  void loadBackground(BackgroundEvent event, Emitter emit) async {
    // TODO: implement event handler
    var image = await _getBackground();

    if (image == null) {
      emit(BackgroundErrorState(errorMsg: 'Error message'));
    } else {
      emit(BackgroundSuccessState(bytes: image));
    }
  }

  Future _getBackground() async {
    final rng = new Random();
    final seed = rng.nextInt(999999);
    //final _seed = DateTime.now().millisecond;

    final Uri url = Uri(
        scheme: "https", host: "picsum.photos", path: "seed/${seed}/1000/1500");

    print(url);

    //String _imageURL = "https://picsum.photos/seed/${seed}/1000/1500";

    try {
      Response response = await get(url);
      if (response.statusCode == 200) {
        var image = response.bodyBytes;
        return image; //https://stackoverflow.com/questions/53182480/how-to-get-a-flutter-uint8list-from-a-network-image

      }
    } catch (e) {
      print(e);
    }
  }
}
