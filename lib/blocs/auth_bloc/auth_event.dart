part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthCheck extends AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  LoginRequested(this.email, this.password);
}

class LogoutRequested extends AuthEvent {}
