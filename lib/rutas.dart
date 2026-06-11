import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'login/login_screen.dart';
import 'login/home_screen.dart';
import 'results_screen.dart';

final GoRouter appRoutes = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/results',
      builder: (context, state) {
        final mapData = state.extra;
        if (mapData is! Map<String, dynamic>) {
          return const Scaffold(
            body: Center(
              child: Text('No se recibieron datos para mostrar resultados.'),
            ),
          );
        }
        return ResultsScreen(data: mapData);
      },
    ),
  ],
);