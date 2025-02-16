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

  // Delete Note

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
              return ListTile(
                title: Text(note.text),
              );
            }));
  }
}
