part of 'phrase_bloc.dart';

@immutable
abstract class PhraseEvent {
  const PhraseEvent();
  @override
  List<Object?> get props => [];
}

class PhraseUpdateEvent extends PhraseEvent {}
