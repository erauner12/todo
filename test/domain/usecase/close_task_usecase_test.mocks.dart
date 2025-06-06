// Mocks generated by Mockito 5.4.4 from annotations
// in todo/test/domain/usecase/close_task_usecase_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:todo/core/error/failure.dart' as _i5;
import 'package:todo/data/models/task_data_request.dart' as _i7;
import 'package:todo/domain/entities/task.dart' as _i6;
import 'package:todo/domain/repositories/tasks_repository.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TasksRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTasksRepository extends _i1.Mock implements _i3.TasksRepository {
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.TaskEntity>>> getTasks(
          String? projectId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTasks,
          [projectId],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, List<_i6.TaskEntity>>>.value(
                _FakeEither_0<_i5.Failure, List<_i6.TaskEntity>>(
          this,
          Invocation.method(
            #getTasks,
            [projectId],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, List<_i6.TaskEntity>>>.value(
                _FakeEither_0<_i5.Failure, List<_i6.TaskEntity>>(
          this,
          Invocation.method(
            #getTasks,
            [projectId],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i6.TaskEntity>>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.TaskEntity>> getTask(String? taskId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTask,
          [taskId],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.TaskEntity>>.value(
            _FakeEither_0<_i5.Failure, _i6.TaskEntity>(
          this,
          Invocation.method(
            #getTask,
            [taskId],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, _i6.TaskEntity>>.value(
                _FakeEither_0<_i5.Failure, _i6.TaskEntity>(
          this,
          Invocation.method(
            #getTask,
            [taskId],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.TaskEntity>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.TaskEntity>> createTask(
          _i7.TaskDataRequest? taskData) =>
      (super.noSuchMethod(
        Invocation.method(
          #createTask,
          [taskData],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.TaskEntity>>.value(
            _FakeEither_0<_i5.Failure, _i6.TaskEntity>(
          this,
          Invocation.method(
            #createTask,
            [taskData],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, _i6.TaskEntity>>.value(
                _FakeEither_0<_i5.Failure, _i6.TaskEntity>(
          this,
          Invocation.method(
            #createTask,
            [taskData],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.TaskEntity>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> deleteTask(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteTask,
          [id],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
            _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #deleteTask,
            [id],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
                _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #deleteTask,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, bool>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> closeTask(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #closeTask,
          [id],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
            _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #closeTask,
            [id],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
                _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #closeTask,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, bool>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.TaskEntity>> updateTask(
    _i7.TaskDataRequest? taskData,
    String? id,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateTask,
          [
            taskData,
            id,
          ],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.TaskEntity>>.value(
            _FakeEither_0<_i5.Failure, _i6.TaskEntity>(
          this,
          Invocation.method(
            #updateTask,
            [
              taskData,
              id,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, _i6.TaskEntity>>.value(
                _FakeEither_0<_i5.Failure, _i6.TaskEntity>(
          this,
          Invocation.method(
            #updateTask,
            [
              taskData,
              id,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.TaskEntity>>);
}
