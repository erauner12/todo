import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/core/util/storage.dart';
import 'package:todo/data/datasources/comments_remote_datasource.dart';
import 'package:todo/data/datasources/comments_remote_datasource_impl.dart';
import 'package:todo/data/datasources/local/projects_local_datasource.dart';
import 'package:todo/data/datasources/local/sync_local_datasource.dart';
import 'package:todo/data/datasources/local/tasks_local_datasource.dart';
import 'package:todo/data/datasources/remote/projects_remote_datasource.dart';
import 'package:todo/data/datasources/remote/tasks_remote_datasource.dart';
import 'package:todo/data/models/attachment_model.dart';
import 'package:todo/data/models/comment_model.dart';
import 'package:todo/data/models/due_model.dart';
import 'package:todo/data/models/duration_model.dart';
import 'package:todo/data/models/project_model_response.dart';
import 'package:todo/data/models/sync_model.dart';
import 'package:todo/data/models/task_model_response.dart';
import 'package:todo/data/repositories/comments_repository_impl.dart';
import 'package:todo/data/repositories/projects_repository_impl.dart';
import 'package:todo/data/repositories/tasks_repository_impl.dart';
import 'package:todo/data/sync_manager.dart';
import 'package:todo/domain/repositories/comments_repository.dart';
import 'package:todo/domain/repositories/projects_repository.dart';
import 'package:todo/domain/repositories/tasks_repository.dart';
import 'package:todo/domain/usecases/create_comments_usecase.dart';
import 'package:todo/domain/usecases/create_project_usecase.dart';
import 'package:todo/domain/usecases/create_task_usecase.dart';
import 'package:todo/domain/usecases/CloseTaskUseCase.dart';
import 'package:todo/domain/usecases/delete_task_usecase.dart';
import 'package:todo/domain/usecases/delete_usease.dart';
import 'package:todo/domain/usecases/get_all_comments_usecase.dart';
import 'package:todo/domain/usecases/get_projects_usecase.dart';
import 'package:todo/domain/usecases/get_task_usecase.dart';
import 'package:todo/domain/usecases/update_task_usecase.dart';
import 'package:todo/presentation/bloc/comment/comment_bloc.dart';
import 'package:todo/presentation/bloc/create_task/create_task_bloc.dart';
import 'package:todo/presentation/bloc/project/project_bloc.dart';
import 'package:todo/presentation/bloc/task/task_bloc.dart';
import 'package:todo/presentation/bloc/update_task/update_task_bloc.dart';
import 'package:todo/presentation/route/app_router.dart';
import 'package:todo/services/api/dio_client.dart';
import 'package:todo/services/api/project_service.dart';

import '../../domain/usecases/get_tasks_usecase.dart';
import '../../presentation/views/task/create/project_provider.dart';
import '../../presentation/views/task/create/project_provider_impl.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerLazySingleton<Storage>(() => Storage());

  final dio = createDio(getIt<Storage>());
  getIt.registerLazySingleton<Dio>(() => dio);

  getIt.registerLazySingleton<AppRouter>(
      () => AppRouter(storage: getIt<Storage>()));

  final projectService = ProjectService(dio);
  getIt.registerLazySingleton<ProjectService>(() => projectService);

  // Register Hive Boxes
  final taskBox = await Hive.openBox<TaskModelResponse>('tasks');
  final projectBox = await Hive.openBox<ProjectModelResponse>('projects');
  final syncBox = await Hive.openBox<SyncOperation>('sync');
  final durationBox = await Hive.openBox<DurationModel>('duration');
  final dueBox = await Hive.openBox<DueModel>('due');
  final commentBox = await Hive.openBox<CommentModel>('comment');
  final attachmentBox = await Hive.openBox<AttachmentModel>('attachment');

  getIt.registerSingleton<Box<TaskModelResponse>>(taskBox);
  getIt.registerSingleton<Box<ProjectModelResponse>>(projectBox);
  getIt.registerSingleton<Box<SyncOperation>>(syncBox);
  getIt.registerSingleton<Box<DurationModel>>(durationBox);
  getIt.registerSingleton<Box<DueModel>>(dueBox);
  getIt.registerSingleton<Box<CommentModel>>(commentBox);
  getIt.registerSingleton<Box<AttachmentModel>>(attachmentBox);

  getIt.registerSingleton<ProjectProvider>(ProjectProviderImpl());

  // Register data sources
  //register data sources
  getIt.registerLazySingleton<ProjectsRemoteDataSource>(
      () => ProjectsRemoteDataSourceImpl(getIt()));

  getIt.registerLazySingleton<TasksRemoteDataSource>(
    () => TasksRemoteDataSourceImpl(
      service: getIt<ProjectService>(),
    ),
  );

  // Register Local Data Sources
  getIt.registerLazySingleton<TasksLocalDataSource>(
      () => TasksLocalDataSourceImpl(getIt()));
  getIt.registerLazySingleton<ProjectsLocalDataSource>(
      () => ProjectsLocalDataSourceImpl(getIt()));
  getIt.registerLazySingleton<SyncLocalDataSource>(
      () => SyncLocalDataSource(getIt()));

  //register repositories
  getIt.registerSingleton<Connectivity>(Connectivity());

  getIt.registerLazySingleton<ProjectsRepository>(() => ProjectsRepositoryImpl(
        remoteDataSource: getIt<ProjectsRemoteDataSource>(),
        localDataSource: getIt<ProjectsLocalDataSource>(),
        syncQueue: getIt<SyncLocalDataSource>(),
      ));

  getIt.registerLazySingleton<TasksRepository>(
    () => TasksRepositoryImpl(
        remoteDataSource: getIt<TasksRemoteDataSource>(),
        localDataSource: getIt(),
        syncQueue: getIt()),
  );
  getIt.registerLazySingleton<CommentsRepository>(
    () => CommentsRepositoryImpl(
        remoteDataSource: getIt<CommentsRemoteDataSource>()),
  );
  getIt.registerLazySingleton<CommentsRemoteDataSource>(
    () => CommentsRemoteDataSourceImpl(
      getIt<ProjectService>(),
    ),
  );
  getIt.registerLazySingleton(() => SyncManager(
        syncQueue: getIt<SyncLocalDataSource>(),
        projectsRemoteDataSource: getIt<ProjectsRemoteDataSource>(),
        tasksRemoteDataSource: getIt<TasksRemoteDataSource>(),
        projectsLocalDataSource: getIt(),
        tasksLocalDataSource: getIt(),
      ));

  // Register use cases
  //register use cases
  getIt.registerLazySingleton<GetProjectsUseCase>(
      () => GetProjectsUseCase(getIt<ProjectsRepository>()));

  getIt.registerLazySingleton<CreateProjectUseCase>(
    () => CreateProjectUseCase(getIt<ProjectsRepository>()),
  );

  getIt.registerLazySingleton<GetTasksUseCase>(
    () => GetTasksUseCase(getIt<TasksRepository>()),
  );

  getIt.registerLazySingleton<DeleteProjectUseCase>(
    () => DeleteProjectUseCase(getIt<ProjectsRepository>()),
  );

  getIt.registerLazySingleton<CreateTaskUseCase>(
    () => CreateTaskUseCase(getIt<TasksRepository>()),
  );

  getIt.registerLazySingleton<DeleteTaskUseCase>(
    () => DeleteTaskUseCase(getIt<TasksRepository>()),
  );

  getIt.registerLazySingleton<CloseTaskUseCase>(
    () => CloseTaskUseCase(getIt<TasksRepository>()),
  );

  getIt.registerLazySingleton<UpdateTaskUseCase>(
    () => UpdateTaskUseCase(getIt<TasksRepository>()),
  );

  getIt.registerLazySingleton<GetAllCommentsUseCase>(
    () => GetAllCommentsUseCase(getIt<CommentsRepository>()),
  );

  getIt.registerLazySingleton<GetTaskUseCase>(
    () => GetTaskUseCase(getIt<TasksRepository>()),
  );

  getIt.registerLazySingleton<CreateCommentUseCase>(
    () => CreateCommentUseCase(getIt<CommentsRepository>()),
  );

  //register blocs
  getIt.registerFactory<ProjectsBloc>(
    () => ProjectsBloc(
        createProjectUseCase: getIt<CreateProjectUseCase>(),
        getProjectsUseCase: getIt<GetProjectsUseCase>(),
        deleteUseCase: getIt<DeleteProjectUseCase>()),
  );

  getIt.registerFactory<TasksBloc>(
    () => TasksBloc(
        getTasksUseCase: getIt<GetTasksUseCase>(),
        updateTaskUseCase: getIt<UpdateTaskUseCase>(),
        deleteTaskUseCase: getIt<DeleteTaskUseCase>()),
  );

  getIt.registerFactory<UpdateTaskBloc>(() => UpdateTaskBloc(
      updateTaskUseCase: getIt<UpdateTaskUseCase>(),
      getTaskUseCase: getIt<GetTaskUseCase>()));

  getIt.registerFactory<CreateTaskBloc>(() => CreateTaskBloc(
        createTaskUseCase: getIt<CreateTaskUseCase>(),
        getProjectsUseCase: getIt<GetProjectsUseCase>(),
      ));

  getIt.registerFactory<CommentBloc>(() => CommentBloc(
        getAllCommentsUseCase: getIt<GetAllCommentsUseCase>(),
        createCommentUseCase: getIt<CreateCommentUseCase>(),
      ));
}