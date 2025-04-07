import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tank2/features/home/presentation/screens/home_screen.dart';
import 'package:tank2/features/login/presentation/bloc/login_cubit.dart';
import 'package:tank2/core/formatters/persian_to_english_number_formatter.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Builder(builder: (context) {
        return Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: 300,
                child: Column(
                  children: [
                    const Text(
                      'شماره همراه',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    const Text('لطفا شماره همراه و رمز عبور خود را وارد کنید.'),
                    const SizedBox(height: 40),
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _phoneController,
                        textDirection: TextDirection.ltr,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          PersianToEnglishNumberFormatter(),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if(value!.isEmpty){
                            return 'شماره همراه نمیتواند خالی باشد.';
                          }
                          if (!validatePhoneNumber(value)) {
                            return 'شماره تلفن همراه اشتباه وارد شده.';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _formKey.currentState!.validate();
                          context.read<LoginCubit>().updateEnableBtn(enableBtn: validatePhoneNumber(value));
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          labelText: 'شماره همراه',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const TextField(
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        label: Text('رمز عبور'),
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: BlocBuilder<LoginCubit, LoginState>(
                            buildWhen: (previous, current) => previous.enableBtn != current.enableBtn,
                            builder: (context, state) {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: state.enableBtn ? Colors.green : Colors.grey,
                                  padding: const EdgeInsets.all(25),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.go(HomeScreen.routeName,extra: _phoneController.text);
                                  }
                                },
                                child: const Text(
                                  'تایید و ادامه',
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  bool validatePhoneNumber(String value) {
    if (value.length >= 11) {
      if ((value.substring(0, 2).contains('09') && value.length == 11) ||
          (value.substring(0, 3).contains('989') && value.length == 12) ||
          (value.substring(0, 4).contains('+989') && value.length == 13)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
