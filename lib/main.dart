import 'package:flutter/material.dart';
import 'package:flutter_form_validation/blocs/reg_form_bloc.dart';
import 'package:flutter_form_validation/screens/register_screen.dart';
import 'package:flutter_form_validation/themes/style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Register',
      theme: primarytheme,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bloc Register'),
        ),
        body: BlocProvider(
          create: (context) => RegFormBloc(),
          child: RegistrationForm()),
      ),
    );
  }
}
