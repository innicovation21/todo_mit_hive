import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todomithive/widgets/buttons.dart';

import '../database/database.dart';
import '../widgets/alertdialogs.dart';
import '../widgets/tiles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Referenzierung der Hive Box
  final toDoBox = Hive.box('toDoBox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // wenn es noch keine Datenbank mit dem Namen 'TODOLIST' gibt...
    if (toDoBox.get("TODOLIST") == null) {
      //...dann erstelle so eine Datenbank...
      db.createInitialData();
    } else {
      // ...ansonsten lade die bereits bestehende Datenbank
      db.loadData();
    }

    super.initState();
  }

  // controller für unser TextField
  final _controller = TextEditingController();

  // Funktion für check / uncheck des checkbox widgets
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoListe[index][1] = !db.toDoListe[index][1];
    });
    db.updateDataBase();
  }

  // funktion zum updaten/speichern einer neuen Aufgabe
  void saveNewTask() {
    setState(() {
      db.toDoListe.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // Funktion zum Erstellen einer neuen Aufgabe
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return AddTaskDialog(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // Funktion zum Löschen einer Aufgabe
  void deleteTask(int index) {
    setState(() {
      db.toDoListe.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text('TO DO'),
        elevation: 0,
      ),
      // Button für neue Aufgaben
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoListe.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoListe[index][0],
            taskCompleted: db.toDoListe[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
