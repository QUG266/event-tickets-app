import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../data/models/ticket.dart';
import '../data/repositories/ticket_repo.dart';
import '../data/repositories/event_repo.dart';

class TicketProvider extends ChangeNotifier {
  final _ticketRepo = TicketRepository();
  final _eventRepo = EventRepository();
  final _uuid = const Uuid();

  List<Ticket> myList = [];

  Future<void> loadMyTickets() async {
    myList = await _ticketRepo.myTickets();
    notifyListeners();
  }

  Future<Ticket> buyTicket({required int eventId, required String buyerName}) async {
    final t = Ticket(
      code: _uuid.v4(),
      eventId: eventId,
      buyerName: buyerName,
      status: TicketStatus.valid,
      createdAt: DateTime.now(),
    );
    final id = await _ticketRepo.insert(t);
    await _eventRepo.increaseSold(eventId);
    final saved = t.copyWith(id: id);
    await loadMyTickets();
    return saved;
  }

  Future<String> checkIn(String code) async {
    final t = await _ticketRepo.findByCode(code);
    if (t == null) return '❌ Không tìm thấy vé';
    if (t.status == TicketStatus.used) return '⚠️ Vé đã sử dụng';
    await _ticketRepo.markUsed(t.id!);
    await loadMyTickets();
    return '✅ Check-in thành công\nMã: ${t.code}';
  }
}

extension _Copy on Ticket {
  Ticket copyWith({int? id}) => Ticket(
    id: id ?? this.id,
    code: code,
    eventId: eventId,
    buyerName: buyerName,
    status: status,
    createdAt: createdAt,
  );
}
