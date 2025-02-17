import 'package:flutter/material.dart';
import 'package:notesapp/models/note_database.dart';
import 'package:provider/provider.dart';
import 'package:notesapp/models/note_model.dart';

class NotePages extends StatefulWidget {
  const NotePages({super.key});

  @override
  State<NotePages> createState() => _NotePagesState();
}

class _NotePagesState extends State<NotePages> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    readNotes();
  }

  // Create Note
  void createNote() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: textController,
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    context
                        .read<NoteDatabase>()
                        .createNote(textController.text);
                    textController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Create"),
                )
              ],
            ));
  }

  // Read Note
  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  // Update Note
  void updateNote(Note note) {
    textController.text = note.text;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Update Note"),
              content: TextField(controller: textController),
              actions: [
                MaterialButton(
                  onPressed: () {
                    context
                        .read<NoteDatabase>()
                        .updateNote(note.id, textController.text);
                    textController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Update"),
                )
              ],
            ));
  }

  // Delete Note
  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    final noteDatabase = context.watch<NoteDatabase>();

    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
        appBar: AppBar(title: Text("Notes")),
        floatingActionButton: FloatingActionButton(
          onPressed: createNote,
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
            itemCount: currentNotes.length,
            itemBuilder: (context, index) {
              final note = currentNotes[index];
              // List Tile UI
              return ListTile(
                title: Text(note.text),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () => updateNote(note),
                        icon: Icon(Icons.edit)),
                    IconButton(
                        onPressed: () => deleteNote(note.id),
                        icon: Icon(Icons.delete)),
                  ],
                ),
              );
            }));
  }
}
