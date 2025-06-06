import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/util/storage.dart';
import 'package:todo/presentation/route/rout_paths.dart';
import 'package:todo/presentation/views/projects_page.dart';
import 'package:todo/presentation/views/settings/token_setup_page.dart';
import 'package:todo/presentation/views/task/create/create_task_screen.dart';
import 'package:todo/presentation/views/task/update/update_task_screen.dart';
import 'package:todo/presentation/views/task_history_page.dart';
import 'package:todo/presentation/views/tasks_page.dart';

// Note: Assuming ProjectsPage and TaskHistoryPage exist.
// If not, their imports and usage will need to be adjusted.

class AppRouter {
  final Storage storage;

  AppRouter({required this.storage});

  late final GoRouter router = GoRouter(
    initialLocation: AppRoutePath.homeRoute,
    routes: [
      GoRoute(
        path: AppRoutePath.homeRoute,
        builder: (context, state) => const ProjectsPage(),
      ),
      GoRoute(
        path: AppRoutePath.tokenSetupRoute,
        builder: (context, state) => const TokenSetupPage(),
      ),
      GoRoute(
        path: AppRoutePath.taskHistory,
        builder: (context, state) => const TaskHistoryPage(),
      ),
      GoRoute(
        path: '${AppRoutePath.taskListRoute}/:projectId',
        builder: (context, state) {
          final id = state.pathParameters['projectId']!;
          return TasksPage(projectId: id);
        },
      ),
      GoRoute(
        path: AppRoutePath.createTaskRoute,
        builder: (context, state) => const CreateTaskScreen(),
      ),
      GoRoute(
        path: '${AppRoutePath.updateTaskRoute}/:taskId',
        builder: (context, state) {
          final id = state.pathParameters['taskId']!;
          return UpdateTaskScreen(taskId: id);
        },
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) async {
      final token = await storage.getApiToken();
      final hasToken = token != null && token.isNotEmpty;

      final isGoingToSetup = state.matchedLocation == AppRoutePath.tokenSetupRoute;

      // If there's no token and the user is not trying to go to the setup page,
      // redirect them to the setup page.
      if (!hasToken && !isGoingToSetup) {
        return AppRoutePath.tokenSetupRoute;
      }

      // No redirect needed in other cases.
      return null;
    },
  );
}