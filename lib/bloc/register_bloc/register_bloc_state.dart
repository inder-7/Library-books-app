part of 'register_bloc.dart';

@immutable
abstract class RegisterBlocState {}

class RegisterBlocInitial extends RegisterBlocState {}

class RegisterLoadingState extends RegisterBlocState {}

class RegisterSuccessState extends RegisterBlocState {}

class RegisterFailureState extends RegisterBlocState {
  final String error;

  RegisterFailureState({required this.error});
}

class RegisterUpdatedState extends RegisterBlocState {
  final List<String> states;
  final List<String> cities;

  RegisterUpdatedState({required this.states, required this.cities});
}
