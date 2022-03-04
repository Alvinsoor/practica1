part of 'hour_bloc.dart';

@immutable
abstract class HourState {
  const HourState();

  @override
  List<Object?> get props => [];
}

class HourInitial extends HourState {}

class HourErrorState extends HourState {
  final String errorMsg;

  HourErrorState({required this.errorMsg});
  @override
  List<String?> get props => [errorMsg];
}

class HourSuccessState extends HourState {
  var data;

  HourSuccessState({required this.data});
  @override
  List<Object?> get props => [data];
}
