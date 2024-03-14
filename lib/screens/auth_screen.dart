import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/screens/quiz_screen.dart';
import 'package:project/screens/result_screen.dart';

import '../cubit/auth_cubit.dart';
import 'login_screen.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthStatus>(
      builder: (context, state) {
        if (state == AuthStatus.authenticated) {
          return QuizScreen(); // Navigate to the home page if authenticated
        } else {
          return LoginScreen(); // Stay on the login page if unauthenticated
        }
      },
    );
  }
}
