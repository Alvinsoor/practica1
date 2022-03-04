part of 'background_bloc.dart';

@immutable
abstract class BackgroundEvent {
  const BackgroundEvent();
  @override
  List<Object?> get props => [];
}

class BackgroundUpdateEvent extends BackgroundEvent {}
