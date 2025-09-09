enum TicketStatus { valid, used }

class Ticket {
  final int? id;
  final String code;      // UUID -> in QR
  final int eventId;
  final String buyerName;
  final TicketStatus status;
  final DateTime createdAt;

  Ticket({
    this.id,
    required this.code,
    required this.eventId,
    required this.buyerName,
    required this.status,
    required this.createdAt,
  });

  factory Ticket.fromMap(Map<String, dynamic> m) => Ticket(
    id: m['id'],
    code: m['code'],
    eventId: m['eventId'],
    buyerName: m['buyerName'],
    status: (m['status'] == 'used') ? TicketStatus.used : TicketStatus.valid,
    createdAt: DateTime.fromMillisecondsSinceEpoch(m['createdAt']),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'code': code,
    'eventId': eventId,
    'buyerName': buyerName,
    'status': status == TicketStatus.valid ? 'valid' : 'used',
    'createdAt': createdAt.millisecondsSinceEpoch,
  };
}
