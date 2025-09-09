import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/event_provider.dart';
import '../widgets/event_card.dart';
import 'event_detail_screen.dart';

class EventsListScreen extends StatefulWidget {
  const EventsListScreen({super.key});
  @override
  State<EventsListScreen> createState() => _EventsListScreenState();
}

class _EventsListScreenState extends State<EventsListScreen> {
  String q = '';
  String category = 'Tất cả'; // demo chip

  @override
  Widget build(BuildContext context) {
    final p = context.watch<EventProvider>();
    final filtered = p.events.where((e) {
      final okQ = q.isEmpty || e.name.toLowerCase().contains(q.toLowerCase()) || e.location.toLowerCase().contains(q.toLowerCase());
      return okQ; // demo chưa filter theo category
    }).toList();

    return CustomScrollView(
      slivers: [
        SliverAppBar.large(
          title: const Text('Khám phá sự kiện'),
          actions: [
            IconButton(icon: const Icon(Icons.refresh), onPressed: ()=> context.read<EventProvider>().load()),
          ],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: Column(
              children: [
                // ô tìm kiếm
                TextField(
                  onChanged: (v)=> setState(()=> q = v),
                  decoration: InputDecoration(
                    hintText: 'Tìm theo tên, địa điểm...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 12),
                // chips danh mục (demo)
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (final c in ['Tất cả','Âm nhạc','Công nghệ','Thể thao'])
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(c),
                            selected: category == c,
                            onSelected: (_)=> setState(()=> category = c),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
        SliverList.builder(
          itemCount: filtered.length,
          itemBuilder: (_, i){
            final e = filtered[i];
            return EventCard(
              event: e,
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (_)=> EventDetailScreen(event: e),
                ));
              },
            );
          },
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
      ],
    );
  }
}
