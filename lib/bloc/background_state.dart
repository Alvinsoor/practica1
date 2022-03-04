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
  var data;

  BackgroundSuccessState({required this.data});
  @override
  List<Object?> get props => [data];
}
