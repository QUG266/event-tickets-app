import '../db/app_db.dart';
import '../models/event.dart';

class EventRepository {
  Future<List<Event>> all() async {
    final d = await AppDatabase().db;
    final rows = await d.query('events', orderBy: 'dateTime ASC');
    return rows.map((e)=>Event.fromMap(e)).toList();
  }

  Future<void> increaseSold(int eventId) async {
    final d = await AppDatabase().db;
    await d.rawUpdate('UPDATE events SET sold = sold + 1 WHERE id = ?', [eventId]);
  }
}
