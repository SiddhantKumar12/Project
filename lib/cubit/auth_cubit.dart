// auth_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum AuthStatus { authenticated, unauthenticated, unknown, loading }

class AuthCubit extends Cubit<AuthStatus> {
  AuthCubit() : super(AuthStatus.unknown) {
    checkAuthentication();
  }

  void checkAuthentication() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        emit(AuthStatus.authenticated);
      } else {
        emit(AuthStatus.unauthenticated);
      }
    });
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      emit(AuthStatus.loading);
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      emit(AuthStatus.authenticated);
    } catch (e) {
      emit(AuthStatus.unauthenticated);
      // Handle error, e.g., show error message
    }
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    try {
      emit(AuthStatus.loading);
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      emit(AuthStatus.authenticated);
    } catch (e) {
      emit(AuthStatus.unauthenticated);
      // Handle error, e.g., show error message
    }
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    emit(AuthStatus.unauthenticated);
  }
}
