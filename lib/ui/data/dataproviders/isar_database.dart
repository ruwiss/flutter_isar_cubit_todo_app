import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../../utils/errors/exceptions.dart';
import '../models/todo_model.dart';

class IsarDatabase {
  static final instance = IsarDatabase._instance();

  IsarDatabase._instance() {
    initialize();
  }

  factory IsarDatabase() => instance;

  static late Isar isar;

  // Isar başlatılsın
  Future<void> initialize() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      isar = await Isar.open([TodoSchema], directory: dir.path);
    } catch (e) {
      throw DatabaseException("Veritabanı başlatma sorunu: $e");
    }
  }

  // Görev Ekle
  Future<List<Todo>> addTodo(String text) async {
    try {
      final newTodo = Todo()..text = text;
      await isar.writeTxn(() => isar.todos.put(newTodo));
      return await fetchTodos();
    } catch (e) {
      throw DatabaseException("Görev ekleme sorunu: $e");
    }
  }

  // Görevleri Getir
  Future<List<Todo>> fetchTodos() async {
    try {
      return await isar.todos.where().findAll();
    } catch (e) {
      throw DatabaseException("Görevleri getirme sorunu: $e");
    }
  }

  // Görev Güncelle
  Future<List<Todo>> updateTodo(Todo todo) async {
    try {
      final existingTodo = await isar.todos.get(todo.id);
      if (existingTodo != null) {
        await isar.writeTxn(() => isar.todos.put(todo));
      }
      return await fetchTodos();
    } catch (e) {
      throw DatabaseException("Görevi güncelleme sorunu: $e");
    }
  }

  // Görev Sil
  Future<List<Todo>> deleteTodo(int id) async {
    try {
      await isar.writeTxn(() => isar.todos.delete(id));
      return await fetchTodos();
    } catch (e) {
      throw DatabaseException("Görevi silme sorunu: $e");
    }
  }
}
