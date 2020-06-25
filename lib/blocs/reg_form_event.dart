part of 'reg_form_bloc.dart';

abstract class RegFormEvent extends Equatable {
  const RegFormEvent();

  @override
  List<Object> get props => [];

  bool get stringify => true;
}

class EmailChanged extends RegFormEvent {
  final String email;

  const EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends RegFormEvent {
  final String password;

  const PasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];
}

class FormSubmitted extends RegFormEvent {}

class FormReset extends RegFormEvent {}
