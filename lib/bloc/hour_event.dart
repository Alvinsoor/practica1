part of 'hour_bloc.dart';

@immutable
abstract class HourEvent {
  const HourEvent();
  @override
  List<Object?> get props => [];
}

class HourUpdateEvent extends HourEvent {}
