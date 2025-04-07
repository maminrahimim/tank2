import 'package:go_router/go_router.dart';
import 'package:tank2/features/home/presentation/screens/home_screen.dart';
import 'package:tank2/features/login/presentation/screens/login_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
        path: HomeScreen.routeName,
        builder: (context, state) {
          final String phoneNumber = state.extra as String;
          return HomeScreen(phoneNumber: phoneNumber);
        }
    ),
  ],
);
