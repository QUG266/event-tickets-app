import '../db/app_db.dart';
import '../models/ticket.dart';

class TicketRepository {
  Future<int> insert(Ticket t) async {
    final d = await AppDatabase().db;
    return d.insert('tickets', t.toMap());
  }

  Future<Ticket?> findByCode(String code) async {
    final d = await AppDatabase().db;
    final rows = await d.query('tickets', where: 'code=?', whereArgs: [code], limit: 1);
    return rows.isEmpty ? null : Ticket.fromMap(rows.first);
  }

  Future<void> markUsed(int id) async {
    final d = await AppDatabase().db;
    await d.update('tickets', {'status':'used'}, where: 'id=?', whereArgs: [id]);
  }

  Future<List<Ticket>> myTickets() async {
    final d = await AppDatabase().db;
    final rows = await d.query('tickets', orderBy: 'createdAt DESC');
    return rows.map((e)=>Ticket.fromMap(e)).toList();
  }
}
