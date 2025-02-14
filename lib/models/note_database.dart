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
  // Create

  // Read

  // Update

  // Delete
}
