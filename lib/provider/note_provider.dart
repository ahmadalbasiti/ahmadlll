import 'package:moqbel/database/note_controller.dart';
import 'package:moqbel/model/note.dart';
import 'package:flutter/material.dart';

class NoteProvider extends ChangeNotifier {
  final NoteController _noteController = NoteController();
  List<Note> notes = <Note>[];
  bool loading = false ;
  void read() async {
    loading = true ;
    notes = await _noteController.read();
    loading = false ;
    notifyListeners();
  }

  Future<bool> create({required Note note}) async {
    int newRow = await _noteController.create(note);
    if (newRow != 0) {
      notes.add(note);
      notifyListeners();
    }
    return newRow != 0;
  }

  Future<bool> delete(int index) async {
    bool deleted = await _noteController.delete(notes[index].id);
    if (deleted) {
      notes.removeAt(index);
      notifyListeners();
    }
    // if(deleted){
    //
    //   // notes.removeWhere((elements)=>elements.id==id);
    //   // notifyListeners();
    //   // int index = notes.indexWhere((note)=>note.id==id);
    //   // if(index!=-1){
    //   //   notes.removeAt(index);
    //   //   notifyListeners();
    //   // }
    // }

    return deleted;
  }

  Future<bool> update(Note updateNote) async {
    bool updated = await _noteController.update(updateNote);
    if (updated) {
      int index = notes.indexWhere((elements) => elements.id == updateNote.id);
      if (index != -1) {
        notes[index] = updateNote;
        notifyListeners();
      }
    }
    return updated;
  }
}
