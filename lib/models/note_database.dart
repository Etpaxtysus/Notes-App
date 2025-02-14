import 'package:isar/isar.dart';
import 'package:notesapp/models/note_model.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase {
  static late Isar isar;
  // Initialize Database
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema], directory: dir.path);
  }

  // List of Notes :
  final List<Note> currentNotes = [];

  // Create
  Future<void> createNote(String textFromUser) async {
    final newNote = Note()..text = textFromUser;

    await isar.writeTxn(() => isar.notes.put(newNote));

    fetchNotes();
  }

  // Read
  Future<void> fetchNotes() async {
    List<Note> fetchedNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
  }

  // Update
  Future<void> updateNote(int id, String newText) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.text = newText;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      fetchNotes();
    }
  }

  // Delete
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    fetchNotes();
  }
}
