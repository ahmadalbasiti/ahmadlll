import 'package:moqbel/get/note_get_controller.dart';
import 'package:moqbel/storge/pref.dart';
import 'package:moqbel/utils/helpers.dart';
import 'package:flutter/material.dart';

import '../../model/note.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({this.note, Key? key}) : super(key: key);
  final Note? note;

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> with Helpers {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    // TODO: implement initState
    _descriptionController = TextEditingController(text: widget.note?.title);
    _titleController = TextEditingController(text: widget.note?.details);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _descriptionController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            iconTheme: const IconThemeData(color: Colors.black),
            title: const Text(
              'Note Screen',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'New Note ',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(height: 10),
              const Text(
                'Enter Title and Description',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black45),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _titleController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.title),
                  labelText: 'title',
                  labelStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black45,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _descriptionController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.description),
                  labelText: 'Description',
                  labelStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black45,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async => await performSave(),
                child: const Text('Save'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 40),
                  primary: Colors.blue[300],
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> performSave() async {
    if (checkSave()) {
      await save();
    }
  }

  bool checkSave() {
    if (_titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context,
        massage: 'Enter Name, Email and Password ', error: true);
    return false;
  }

  Future<void> save() async {
    // bool saved = isCreated()
    //     ? await Provider.of<NoteProvider>(context, listen: false)
    //         .create(note: note)
    //     : await Provider.of<NoteProvider>(context, listen: false).update(note);
    bool saved = isCreated()?
    await NoteGetController.to.create(note: note):
    await NoteGetController.to.updateNote(note);

    String massage = saved ? 'Note Saved' : 'Note Not Saved, Please Try Again';
    showSnackBar(context, massage: massage, error: !saved);
    isCreated() ? clear() : Navigator.pop(context);
  }

  bool isCreated() => widget.note == null;

  Note get note {
    Note note = Note();
    if (!isCreated()) {
      note.id = widget.note!.id;
    }
    note.title = _titleController.text;
    note.details = _descriptionController.text;
    note.user_id = PrefController().userId.toString();
    return note;
  }

  void clear() {
    _titleController.text = '';
    _descriptionController.text = '';
  }
}
