// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get createTask => 'Create Task';

  @override
  String get confirmDeletion => 'Confirm Deletion';

  @override
  String get wantConfirmDeletion =>
      'Are you sure you want to delete this project?';

  @override
  String get wantConfirmDeletionTask =>
      'Are you sure you want to delete this task?';

  @override
  String get kanbanBoard => 'Kanban Board';

  @override
  String get projects => 'Projects';

  @override
  String get addNewTask => 'Add New Task';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get somethingWentWrong => 'Something went wrong!';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get german => 'German';

  @override
  String get logout => 'Logout';

  @override
  String get createProject => 'Create Project';

  @override
  String get projectName => 'Project Name';

  @override
  String get pleaseEnterProjectName => 'Please enter a project name';

  @override
  String get taskHistory => 'Task History';

  @override
  String get nothingToSeeHere => 'Nothing to see here';

  @override
  String get selectAProject => 'Select a project ...';

  @override
  String get selectATaskState => 'Select a task state ...';

  @override
  String get endDateLabel => 'End date ...';

  @override
  String get endDate => 'End Date';

  @override
  String get isRecurring => 'Is Recurring';

  @override
  String get updateTask => 'Update Task';

  @override
  String get content => 'Content';

  @override
  String get description => 'Description';

  @override
  String get stop => 'Stop';

  @override
  String get start => 'Start';

  @override
  String get postComment => 'Post Comment';

  @override
  String get comments => 'Comments';

  @override
  String get startDateLabel => 'Start date ...';

  @override
  String get startDate => 'Start Date';

  @override
  String get pleaseFillInAllFields => 'Please fill in all fields!';

  @override
  String get totalTime => 'Total Time';

  @override
  String get theDatesCannotBeBeforeToday => 'The dates cannot be before today.';

  @override
  String get endDateCannotBeBeforeStart => 'End date cannot be before start.';
}
