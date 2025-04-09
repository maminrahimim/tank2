import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tank2/core/cubit/sidebar_cubit.dart';
import 'package:tank2/core/widgets/sidebar_item.dart';
import 'package:tank2/features/claculator/presentation/screens/calculator_screen.dart';
import 'package:tank2/features/home/presentation/screens/home_screen.dart';
import 'package:tank2/features/login/presentation/screens/login_screen.dart';
import 'package:tank2/features/profile/presentation/screens/profile_screen.dart';
import 'package:tank2/features/setting/presentation/screens/setting_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => LoginScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return BlocProvider(
          create: (context) => SidebarCubit(),
          child: Builder(builder: (context) {
            return Scaffold(
              body: Stack(
                children: [
                  Container(margin: const EdgeInsets.only(right: 60), child: child),
                  Align(
                    alignment: Alignment.centerRight,
                    child: MouseRegion(
                      onEnter: (_) => context.read<SidebarCubit>().toggleIsHovered(true),
                      onExit: (_) => context.read<SidebarCubit>().toggleIsHovered(false),
                      child: BlocBuilder<SidebarCubit, SidebarState>(
                        buildWhen: (previous, current) => previous.isHovered != current.isHovered,
                        builder: (context, state) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: state.isHovered ? 200 : 60,
                            color: Colors.green,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SidebarItem(
                                  icon: Icons.home,
                                  text: 'خانه',
                                  isHovered: state.isHovered,
                                  onTap: () => context.go(HomeScreen.routeName),
                                ),
                                SidebarItem(
                                  icon: Icons.person,
                                  text: 'پروفایل',
                                  isHovered: state.isHovered,
                                  onTap: () => context.go(ProfileScreen.routeName),
                                ),
                                SidebarItem(
                                  icon: Icons.settings,
                                  text: 'تنظیمات',
                                  isHovered: state.isHovered,
                                  onTap: () => context.go(SettingScreen.routeName),
                                ),
                                SidebarItem(
                                  icon: Icons.calculate,
                                  text: 'ماشین حساب',
                                  isHovered: state.isHovered,
                                  onTap: () => context.go(CalculatorScreen.routeName),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
      routes: [
        GoRoute(
          path: HomeScreen.routeName,
          builder: (context, state) {
            return const HomeScreen();
          },
        ),
        GoRoute(
          path: ProfileScreen.routeName,
          builder: (context, state) {
            return const ProfileScreen();
          },
        ),
        GoRoute(
          path: SettingScreen.routeName,
          builder: (context, state) {
            return const SettingScreen();
          },
        ),
        GoRoute(
          path: CalculatorScreen.routeName,
          builder: (context, state) {
            return const CalculatorScreen();
          },
        ),
      ],
    ),
  ],
);
