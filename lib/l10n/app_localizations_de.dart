// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get helloWorld => 'Hallo Welt!';

  @override
  String get createTask => 'Aufgabe erstellen';

  @override
  String get confirmDeletion => 'Löschen bestätigen';

  @override
  String get wantConfirmDeletion =>
      'Sind Sie sicher, dass Sie dieses Projekt löschen möchten?';

  @override
  String get wantConfirmDeletionTask =>
      'Sind Sie sicher, dass Sie diese Aufgabe löschen möchten?';

  @override
  String get kanbanBoard => 'Kanban-Tafel';

  @override
  String get projects => 'Projekte';

  @override
  String get addNewTask => 'Neue Aufgabe hinzufügen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get somethingWentWrong => 'Etwas ist schief gelaufen!';

  @override
  String get darkMode => 'Dunkler Modus';

  @override
  String get language => 'Sprache';

  @override
  String get english => 'Englisch';

  @override
  String get german => 'Deutsch';

  @override
  String get logout => 'Abmelden';

  @override
  String get createProject => 'Projekt erstellen';

  @override
  String get projectName => 'Projektname';

  @override
  String get pleaseEnterProjectName => 'Bitte geben Sie einen Projektnamen ein';

  @override
  String get taskHistory => 'Aufgabenverlauf';

  @override
  String get nothingToSeeHere => 'Nichts zu sehen hier';

  @override
  String get selectAProject => 'Wählen Sie ein Projekt ...';

  @override
  String get selectATaskState => 'Wählen Sie einen Aufgabenstatus ...';

  @override
  String get endDateLabel => 'Enddatum ...';

  @override
  String get endDate => 'Enddatum';

  @override
  String get isRecurring => 'Wiederkehrend';

  @override
  String get updateTask => 'Aufgabe aktualisieren';

  @override
  String get content => 'Inhalt';

  @override
  String get description => 'Beschreibung';

  @override
  String get stop => 'Stoppen';

  @override
  String get start => 'Starten';

  @override
  String get postComment => 'Kommentar posten';

  @override
  String get comments => 'Kommentare';

  @override
  String get startDateLabel => 'Startdatum ...';

  @override
  String get startDate => 'Startdatum';

  @override
  String get pleaseFillInAllFields => 'Bitte füllen Sie alle Felder aus!';

  @override
  String get totalTime => 'Gesamtzeit';

  @override
  String get theDatesCannotBeBeforeToday =>
      'Die Daten dürfen nicht vor heute liegen.';

  @override
  String get endDateCannotBeBeforeStart =>
      'Das Enddatum darf nicht vor dem Startdatum liegen.';
}
