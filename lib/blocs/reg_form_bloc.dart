import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:flutter_form_validation/models/models.dart';

part 'reg_form_event.dart';
part 'reg_form_state.dart';

class RegFormBloc extends Bloc<RegFormEvent, RegFormState> {
  @override
  RegFormState get initialState => const RegFormState();

  void onTransition(Transition<RegFormEvent, RegFormState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<RegFormState> mapEventToState(RegFormEvent event) async* {
    if (event is EmailChanged) {
      final email = Email.dirty(event.email);
      yield state.copyWith(
        email: email,
        status: Formz.validate([email, state.password]),
      );
    } else if (event is PasswordChanged) {
      final password = Password.dirty(event.password);
      yield state.copyWith(
        password: password,
        status: Formz.validate([state.email, password]),
      );
    } else if (event is FormSubmitted) {
      if (state.status.isValidated) {
        yield state.copyWith(status: FormzStatus.submissionInProgress);
        await Future.delayed(const Duration(seconds: 1));
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      }
    } else if (event is FormReset) {
      yield const RegFormState();
    }
  }
}
