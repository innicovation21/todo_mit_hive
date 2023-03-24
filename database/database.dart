import 'package:hive_flutter/hive_flutter.dart';


// Klasse für unsere Datenbank mit entsprechenden Variablen & Funktionen
class ToDoDataBase {
  List toDoListe = [];

  // wir referenzieren unsere box
  final _toDoBox = Hive.box('mybox');

  // Erstellen einer Liste (wenn app das erste mal gestartet wird)
  void createInitialData() {
    // befüllen der Liste mit ein paar default-aufgaben (welche ebenfalls in Form von Listen dargestellt werden)
    toDoListe = [
      ["Wäsche waschen", false],
      ["Einkaufszettel schreiben", false],
    ];
  }

  // Daten abrufen
  void loadData() {
    toDoListe = _toDoBox.get("TODOLIST");
  }

  // Datenbank aktuallisieren
  void updateDataBase() {
    //wir legen die Liste hinter den entsprechenden Key
    _toDoBox.put("TODOLIST", toDoListe);
  }
}
