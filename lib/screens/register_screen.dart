import 'package:flutter/material.dart';
import 'package:flutter_form_validation/blocs/reg_form_bloc.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegFormBloc, RegFormState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          showDialog(
            context: context,
            builder: (_) => SuccessDialog(onDismissed: () {
              context.bloc<RegFormBloc>().add(FormReset());
            }),
          );
        }
        if (state.status.isSubmissionInProgress) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text('Submitting..')),
            );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            //Text('Fluter Bloc Register'),
            EmailInput(),
            PasswordInput(),
            SizedBox(
              height: 20.0,
            ),
            SubmitButton(),
          ],
        ),
      ),
    );
  }
}

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegFormBloc, RegFormState>(
      condition: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            icon: Icon(
              Icons.email,
              color: Colors.blue,
            ),
            labelText: 'Email',
            hintText: 'yourmail@example.com',
            errorText: state.email.invalid ? 'Invaild Email' : null,
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            context.bloc<RegFormBloc>().add(EmailChanged(email: value));
          },
        );
      },
    );
  }
}

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegFormBloc, RegFormState>(
      condition: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            icon: Icon(Icons.lock),
            labelText: 'Password',
            hintText: '*****',
            errorText: state.password.invalid ? 'Invaild Password' : null,
          ),
          obscureText: true,
          onChanged: (value) {
            context.bloc<RegFormBloc>().add(PasswordChanged(password: value));
          },
        );
      },
    );
  }
}

class SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegFormBloc, RegFormState>(
      condition: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return RaisedButton(
          onPressed: state.status.isValidated
              ? () => context.bloc<RegFormBloc>().add(FormSubmitted())
              : null,
          child: Text('Submit'),
        );
      },
    );
  }
}

class SuccessDialog extends StatelessWidget {
  final VoidCallback onDismissed;
  SuccessDialog({Key key, @required this.onDismissed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Icon(Icons.info),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Form Submitted..',
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
            RaisedButton(child: Text('OK'), onPressed: onDismissed),
          ],
        ),
      ),
    );
  }
}

//https://github.com/felangel/bloc/blob/master/examples/flutter_form_validation/lib/main.dart
