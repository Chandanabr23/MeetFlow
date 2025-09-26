import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meetflow/models/user.dart';
import 'package:meetflow/repositories/user_repo.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepo userRepo;

  UserBloc(this.userRepo) : super(UserInitial()) {
    on<FetchUsers>((event, emit) async {
      emit(UserLoading());
      try {
        final users = await userRepo.fetchUsers();
        emit(UserLoaded(users));
      } catch (e) {
        emit(UserError("Failed to load users"));
      }
    });
  }
}
