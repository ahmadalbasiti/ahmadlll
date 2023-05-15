import 'package:moqbel/database/note_controller.dart';
import 'package:moqbel/model/note.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoteGetController extends GetxController {
  final NoteController _noteController = NoteController();

  static NoteGetController get to => Get.find();

  // List<Note> notes = <Note>[];
  RxList<Note> notes = <Note>[].obs;

  // bool loading = false;
  RxBool loading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    read();
    super.onInit();
  }

  void read() async {
    // loading = true;
    // notes = await _noteController.read();
    // loading = false;
    loading.value = true;
    notes.value = await _noteController.read();
    loading.value = false;
    // update();
  }

  Future<bool> create({required Note note}) async {
    int newRow = await _noteController.create(note);
    if (newRow != 0) {
      note.id = newRow;
      notes.add(note);
      // update();
    }
    return newRow != 0;
  }

  Future<bool> delete(int index) async {
    bool deleted = await _noteController.delete(notes[index].id);
    if (deleted) {
      notes.removeAt(index);
      // update();
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

  Future<bool> updateNote(Note updateNote) async {
    bool updated = await _noteController.update(updateNote);
    if (updated) {
      int index = notes.indexWhere((elements) => elements.id == updateNote.id);
      if (index != -1) {
        notes[index] = updateNote;
        // update();
      }
    }
    return updated;
  }
}
