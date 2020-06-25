part of 'reg_form_bloc.dart';

class RegFormState extends Equatable {
  final Email email;
  final Password password;
  final FormzStatus status;

  const RegFormState(
      {this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.status = FormzStatus.pure});

  RegFormState copyWith({
    Email email,
    Password password,
    FormzStatus status,
  }) {
    return RegFormState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [email, password, status];

  bool get stringify => true;
}
