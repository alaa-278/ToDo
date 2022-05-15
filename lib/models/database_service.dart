import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/note.dart';
import 'package:todo_app/models/notes_screen.dart';

class DatabaseController extends GetxController implements GetxService {
  late final Database db;

  DatabaseController() {}

  Future<DatabaseController> init() async {
    db = await openDatabase(
      'my4_dsasasb.db',
      onCreate: (database, _) async {
        await database.execute("""
        CREATE TABLE notes(id INTEGER PRIMARY KEY autoincrement,title Text, 
        dateTime Text, note Text, isDone INTEGER, base64Image TEXT,color INTEGER)
        """);
      },
      version: 8,
    );
    return this;
  }

  Future<int> addNote(Note note) async {
    return await db.insert('notes', note.toMap());
  }

  Future<int> editNote(Note note) async {
    print(note.toMap());
    return await db
        .update('notes', note.toMap(), where: "id = ? ", whereArgs: [note.id]);
  }

  Future<int> deleteNote(Note note) async {
    return await db.delete('notes', where: "id = ? ", whereArgs: [note.id]);
  }

  Future<List<Note>> getAllNotes(FilterTypes filterTypes) {
    Future<List<Note>> note = db
        .query('notes',
        where: filterTypes == FilterTypes.all ? null : 'isDone=?',
        whereArgs: filterTypes == FilterTypes.all
            ? null
            : [filterTypes == FilterTypes.done ? 1 : 0])
        .then((value) => _generateFromMap(value));
    if (filterTypes == FilterTypes.before) {
      return note.then((value) =>
      [...value.where((e) => DateTime.now().isAfter(e.dateTime)).toList()]);
    } else if (filterTypes == FilterTypes.after) {
      return note.then((value) => [
        ...value.where((e) => DateTime.now().isBefore(e.dateTime)).toList()
      ]);
    } else {
      return note;
    }
  }

  List<Note> _generateFromMap(List<Map<String, dynamic>> data) {
    return List<Note>.generate(
        data.length, (index) => Note.fromMap(data[index]));
  }
}
