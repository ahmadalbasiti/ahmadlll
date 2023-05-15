import 'package:moqbel/get/note_get_controller.dart';
import 'package:moqbel/provider/note_provider.dart';
import 'package:moqbel/screen/app/note_screen.dart';
import 'package:moqbel/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> with Helpers {
  // final NoteGetController _controller = Get.find();

  @override
  void initState() {
    // Provider.of<NoteProvider>(context, listen: false).read();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NoteScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.create, color: Colors.black)),
        ],
        title: const Text(
          'Notes Screen',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: GetX<NoteGetController>(
       init: NoteGetController(),
        global: true,
        builder:(controller){
         if (controller.loading.value) {
           return const Center(child: CircularProgressIndicator());
         }
         else
         if (controller.notes.isNotEmpty) {
           return ListView.builder(
             itemCount: controller.notes.length,
             itemBuilder: (context, index) {
               return ListTile(
                 onTap: () => Navigator.push(
                   context,
                   MaterialPageRoute(
                     builder: (context) => NoteScreen(
                       note: controller.notes[index],
                     ),
                   ),
                 ),
                 title: Text(controller.notes[index].title),
                 subtitle: Text(controller.notes[index].details),
                 leading: const Icon(Icons.note),
                 trailing: IconButton(
                   onPressed: () => deleteNote(index),
                   icon: const Icon(Icons.delete),
                 ),
               );
             },
           );
         }
         else {
           return const Center(
             child: Icon(
               Icons.warning,
               color: Colors.red,
               size: 100,
             ),
           );
         }
        } ,
      )
    );
  }

  void deleteNote(int index) async {
    // bool deleted =
    //     await Provider.of<NoteProvider>(context, listen: false).delete(index);
    bool deleted = await NoteGetController.to.delete(index);
    String massage = deleted ? 'Note deleted' : 'Note not deleted';
    showSnackBar(context, massage: massage, error: !deleted);
  }
}

/*

 GetBuilder<NoteGetController>(
          init: NoteGetController(),
          global: true,
          builder: (controller) {
             if (controller.loading) {
               return const Center(child: CircularProgressIndicator());
             }
             else
            if (controller.notes.isNotEmpty) {
              return ListView.builder(
                itemCount: controller.notes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NoteScreen(
                          note: controller.notes[index],
                        ),
                      ),
                    ),
                    title: Text(controller.notes[index].title),
                    subtitle: Text(controller.notes[index].details),
                    leading: const Icon(Icons.note),
                    trailing: IconButton(
                      onPressed: () => deleteNote(index),
                      icon: const Icon(Icons.delete),
                    ),
                  );
                },
              );
            }
            else {
              return const Center(
                child: Icon(
                  Icons.warning,
                  color: Colors.red,
                  size: 100,
                ),
              );
            }
          }),

 */
/*
 body: Consumer<NoteProvider>(
        builder: ((context, NoteProvider value, child) {
          // if (value.loading) {
          //   return const Center(child: CircularProgressIndicator());
          // }
          // else
            if (value.notes.isNotEmpty) {
            return ListView.builder(
              itemCount: value.notes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: ()=>Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoteScreen(
                        note: value.notes[index],
                      ),
                    ),
                  ),
                  title: Text(value.notes[index].title),
                  subtitle: Text(value.notes[index].details),
                  leading: const Icon(Icons.note),
                  trailing: IconButton(
                      onPressed: ()=> deleteNote(index),
                      icon: const Icon(Icons.delete)),
                );
              },
            );
          }
           else{
            return const Center(
              child: Icon(
                Icons.warning,
                color: Colors.red,
                size: 100,
              ),
            );
          }
        }),
      ),

*/
