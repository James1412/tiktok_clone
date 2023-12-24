import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/repo/authentication_repo.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/main_navigation/main_navigation_screen.dart';
import 'package:tiktok_clone/features/users/user_profile_screen.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isLoggedin = ref.read(authRepo).isLoggedin;
      if (!isLoggedin) {
        if (state.subloc != SignUpScreen.routeURL &&
            state.subloc != LoginScreen.routeName) {
          return SignUpScreen.routeURL;
        } else {
          return null;
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MainNavigationScreen(),
      ),
      GoRoute(
        path: SignUpScreen.routeURL,
        name: SignUpScreen.routeName,
        builder: (context, state) => const SignUpScreen(),
        routes: [
          GoRoute(
              path: UsernameScreen.routeName,
              name: UsernameScreen.routeURL,
              builder: (context, state) => const UsernameScreen(),
              routes: const []),
        ],
      ),
      GoRoute(
        path: LoginScreen.routeName,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: UserProfileScreen.routeName,
        builder: (context, state) {
          return const UserProfileScreen();
        },
      ),
    ],
  );
});
