import 'package:bloc/bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState(enableBtn: false));

  updateEnableBtn({required bool enableBtn}){
    emit(state.copyWith(newEnableBtn: enableBtn));
  }
}
