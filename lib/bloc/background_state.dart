part of 'background_bloc.dart';

@immutable
abstract class BackgroundState {
  const BackgroundState();

  @override
  List<Object?> get props => [];
}

class BackgroundInitial extends BackgroundState {}

class BackgroundErrorState extends BackgroundState {
  final String errorMsg;

  BackgroundErrorState({required this.errorMsg});
  @override
  List<String?> get props => [errorMsg];
}

class BackgroundSuccessState extends BackgroundState {
  //https://www.codegrepper.com/code-examples/dart/flutter+how+to+download+image+url+async+and+display
  final Uint8List bytes;

  BackgroundSuccessState({required this.bytes});
  @override
  List<Object?> get props => [bytes];
}
