part of 'login_cubit.dart';

class LoginState {
  bool enableBtn;

  LoginState({required this.enableBtn});

  LoginState copyWith({bool? newEnableBtn}) {
    return LoginState(
      enableBtn: newEnableBtn ?? enableBtn,
    );
  }
}
