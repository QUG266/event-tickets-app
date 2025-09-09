class Event {
  final int? id;
  final String name;
  final String description;
  final DateTime dateTime;
  final String location;
  final double price;
  final int capacity;
  final int sold;
  final String imageUrl;

  Event({
    this.id,
    required this.name,
    required this.description,
    required this.dateTime,
    required this.location,
    required this.price,
    required this.capacity,
    required this.sold,
    required this.imageUrl,
  });

  factory Event.fromMap(Map<String,dynamic> m) => Event(
    id: m['id'],
    name: m['name'],
    description: m['description'],
    dateTime: DateTime.fromMillisecondsSinceEpoch(m['dateTime']),
    location: m['location'],
    price: (m['price'] as num).toDouble(),
    capacity: m['capacity'],
    sold: m['sold'],
    imageUrl: m['imageUrl'] ?? '',
  );

  Map<String,dynamic> toMap() => {
    'id': id,
    'name': name,
    'description': description,
    'dateTime': dateTime.millisecondsSinceEpoch,
    'location': location,
    'price': price,
    'capacity': capacity,
    'sold': sold,
    'imageUrl': imageUrl, 
  };
}
