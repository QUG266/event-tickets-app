import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static final AppDatabase _i = AppDatabase._();
  AppDatabase._();
  factory AppDatabase() => _i;

  Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    final p = join(await getDatabasesPath(), 'event_tickets.db');
    _db = await openDatabase(
      p,
      version: 1,
      onCreate: (d, v) async {
        await d.execute('''
          CREATE TABLE events(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            description TEXT,
            dateTime INTEGER NOT NULL,
            location TEXT NOT NULL,
            price REAL NOT NULL,
            capacity INTEGER NOT NULL,
            sold INTEGER NOT NULL
          );
        ''');
        await d.execute('''
          CREATE TABLE tickets(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            code TEXT UNIQUE NOT NULL,
            eventId INTEGER NOT NULL,
            buyerName TEXT NOT NULL,
            status TEXT NOT NULL,
            createdAt INTEGER NOT NULL,
            FOREIGN KEY(eventId) REFERENCES events(id)
          );
        ''');

        // Seed 2 sự kiện mẫu
        await d.insert('events', {
  'name':'Live Concert 2025',
  'description':'Show âm nhạc tối thứ 7',
  'dateTime': DateTime.now().add(const Duration(days:7)).millisecondsSinceEpoch,
  'location':'Hà Nội',
  'price': 299000,
  'capacity': 200,
  'sold': 0,
  'imageUrl': 'img/ve-moi.jpg'
});
await d.insert('events', {
  'name':'Tech Conference',
  'description':'Hội thảo công nghệ Flutter',
  'dateTime': DateTime.now().add(const Duration(days:30)).millisecondsSinceEpoch,
  'location':'Hồ Chí Minh',
  'price': 499000,
  'capacity': 150,
  'sold': 0,
  'imageUrl': 'img/vehoithao.jpg'
});
        },
        );
        return _db!;
    }
    }