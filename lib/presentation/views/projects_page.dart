import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/constants/constants_value.dart';
import 'package:todo/core/di/di.dart';
import 'package:todo/core/theme/theme.dart';
import 'package:todo/core/utils/todoist_color_mapper.dart';
import 'package:todo/presentation/bloc/project/project_bloc.dart';
import 'package:todo/presentation/bloc/project/project_event.dart';
import 'package:todo/presentation/bloc/project/project_state.dart';
import 'package:todo/presentation/route/rout_paths.dart';
import 'package:todo/presentation/views/app_drawer.dart';
import 'package:todo/presentation/views/base/base-state.dart';
import 'package:todo/presentation/views/dialog.dart';
import 'package:todo/presentation/views/fab.dart';
import 'package:todo/presentation/views/state_widget.dart';
import 'package:todo/presentation/views/task/create/project_provider.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends BaseState<ProjectsPage> {
  bool showFab = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext buildContext) {
    return BlocProvider(
      create: (context) => getIt<ProjectsBloc>()..add(FetchProjectsEvent()),
      child: ThemeSwitchingArea(
        child: Scaffold(
          drawer: const AppDrawer(),
          floatingActionButton: showFab ? const FAB() : null,
          appBar: AppBar(
              title: Text(
            localization.projects,
            style: theme.textTheme.titleMedium
                ?.copyWith(color: theme.colorScheme.onPrimary),
          )),
          body: BlocConsumer<ProjectsBloc, ProjectsState>(
            listener: (context, state) {
              if (state is ProjectsError) {
                context.read<ProjectsBloc>().add(FetchProjectsEvent());
              }
              if (state is ProjectCreateSuccess ||
                  state is DeleteProjectState) {
                context.read<ProjectsBloc>().add(FetchProjectsEvent());
              }
              if (state is ProjectsLoaded) {
                setState(() {
                  showFab = state.projects.length < 8;
                });
              }
            },
            builder: (context, state) {
              if (state is ProjectsLoading) {
                return const StateWidget(isLoading: true, null);
              } else if (state is ProjectsLoaded) {
                if (state.projects.isEmpty) {
                  return StateWidget(
                      isLoading: false, localization.createProject);
                } else {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 3 / 2,
                    ),
                    padding: const EdgeInsets.all(10),
                    itemCount: state.projects.length,
                    itemBuilder: (gridContext, index) {
                      final project = state.projects[index];
                      // Primary color straight from Todoist
                      final base = todoistColor(project.color,
                          defaultColor: theme.primaryColor);

                      // A lighter tint for nicer depth. 0.4 retains readability across the palette.
                      final lighter = Color.lerp(base, Colors.white, 0.4)!;
                      return InkWell(
                        onTap: () {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (mounted) {
                              getIt<ProjectProvider>()
                                  .setCurrentProject(project);
                              context.push(
                                  '${AppRoutePath.taskListRoute}/${project.id}');
                            }
                          });
                        },
                        child: Card(
                          elevation: 4,
                          margin: const EdgeInsets.all(4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [lighter, base],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Stack(
                              children: [
                                Center(
                                  child: Text(
                                    project.name,
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                if (project.name != inbox)
                                  Positioned(
                                    top: 8,
                                    left: 8,
                                    child: IconButton(
                                      icon: const Icon(Icons.close,
                                          color: Colors.white),
                                      onPressed: () {
                                        showCustomDialog(
                                            context: context,
                                            title: localization.confirmDeletion,
                                            content: localization
                                                .wantConfirmDeletion,
                                            cancelText: localization.cancel,
                                            confirmText: localization.delete,
                                            onConfirm: () {
                                              context.read<ProjectsBloc>().add(
                                                  DeleteProjectEvent(
                                                      project.id));
                                            });
                                      },
                                    ),
                                  )
                                else
                                  const SizedBox.shrink(),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              } else if (state is ProjectsError) {
                return Center(child: Text(localization.somethingWentWrong));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}