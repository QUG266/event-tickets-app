import 'package:flutter/foundation.dart';
import '../data/models/event.dart';
import '../data/repositories/event_repo.dart';

class EventProvider extends ChangeNotifier {
  final _repo = EventRepository();
  List<Event> events = [];

  Future<void> load() async {
    events = await _repo.all();
    notifyListeners();
  }
}
