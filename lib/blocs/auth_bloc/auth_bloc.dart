import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meetflow/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;

  AuthBloc(this.authRepo) : super(AuthInitial()) {
    on<AuthCheck>((event, emit) async {
      final loggedIn = await authRepo.isLoggedIn();
      emit(loggedIn ? Authenticated() : Unauthenticated());
    });

    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      final success = await authRepo.login(event.email, event.password);
      emit(success ? Authenticated() : AuthError("Invalid credentials"));
    });

    on<LogoutRequested>((event, emit) async {
      await authRepo.logout();
      emit(Unauthenticated());
    });
  }
}
