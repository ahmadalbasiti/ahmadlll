import 'package:moqbel/database/controller/db_controller.dart';
import 'package:moqbel/database/controller/db_opration.dart';
import 'package:moqbel/model/note.dart';
import 'package:moqbel/storge/pref.dart';
import 'package:sqflite/sqflite.dart';

class NoteController implements DBControllerOperation<Note> {
  Database database = DbController().database;

  @override
  Future<int> create(model) async {
    int newRow = await database.insert('note', model.toMap());
    return newRow;
  }

  @override
  Future<bool> delete(int id) async {
    int countOfDeleteRow =
        await database.delete('note', where: 'id = ?', whereArgs: [id]);
    return countOfDeleteRow == 1;
  }

  @override
  Future<List<Note>> read() async {
    List<Map<String, dynamic>> row =
        await database.query('note', where: 'user_id = ?', whereArgs: [
          PrefController().userId.toString(),
        ]);
    return row
        .map((Map<String, dynamic> rowMap) => Note.fromMap(rowMap))
        .toList();
  }

  @override
  Future<Note?> show(int id) async {
    List<Map<String, dynamic>> row = await database.query('note');
    return Note.fromMap(row.first);
  }

  @override
  Future<bool> update(note) async {
    int countOfRowUpdate = await database
        .update('note', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
    return countOfRowUpdate == 1;
  }
}


