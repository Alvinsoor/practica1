part of 'phrase_bloc.dart';

@immutable
abstract class PhraseState {
  const PhraseState();

  @override
  List<Object?> get props => [];
}

class PhraseInitial extends PhraseState {}

class PhraseErrorState extends PhraseState {
  final String errorMsg;

  PhraseErrorState({required this.errorMsg});
  @override
  List<String?> get props => [errorMsg];
}

class PhraseSuccessState extends PhraseState {
  String quote;
  String author;

  PhraseSuccessState({required this.quote, required this.author});
  @override
  List<Object?> get props => [author];
}
