part of 'register_bloc.dart';

@immutable
abstract class RegisterBlocEvent {}

class RegisterUserEvent extends RegisterBlocEvent {
  final String name;
  final String email;
  final String password;
  final String gender;
  final String country;
  final String state;
  final String city;

  RegisterUserEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.gender,
    required this.country,
    required this.state,
    required this.city,
  });
}

class CountryChangedEvent extends RegisterBlocEvent {
  final String country;

  CountryChangedEvent({required this.country});
}

class StateChangedEvent extends RegisterBlocEvent {
  final String state;

  StateChangedEvent({required this.state});
}
