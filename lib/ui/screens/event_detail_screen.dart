import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../data/models/event.dart';
import '../../providers/ticket_provider.dart';

class EventDetailScreen extends StatefulWidget {
  final Event event;
  const EventDetailScreen({super.key, required this.event});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  final _nameCtrl = TextEditingController();

  @override
  void dispose() { _nameCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final e = widget.event;
    final price = NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(e.price);

    return Scaffold(
      body: Stack(
        children: [
          // Nội dung cuộn
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 280,
                pinned: true,
                stretch: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(e.name, maxLines: 1, overflow: TextOverflow.ellipsis),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(imageUrl: e.imageUrl, fit: BoxFit.cover),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter, end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black.withOpacity(.55)],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        const Icon(Icons.place_outlined, size: 18),
                        const SizedBox(width: 6),
                        Text(e.location, style: const TextStyle(fontWeight: FontWeight.w600)),
                        const Spacer(),
                        Chip(label: Text('${e.sold}/${e.capacity} đã bán')),
                      ]),
                      const SizedBox(height: 8),
                      Row(children: [
                        const Icon(Icons.schedule, size: 18),
                        const SizedBox(width: 6),
                        Text(DateFormat('EEEE, dd/MM/yyyy • HH:mm', 'vi_VN').format(e.dateTime)),
                      ]),
                      const SizedBox(height: 16),
                      Text('Giới thiệu', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Text(e.description),
                      const SizedBox(height: 20),
                      Text('Tên người mua', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _nameCtrl,
                        decoration: const InputDecoration(
                          hintText: 'Nhập tên hiển thị trên vé',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Thanh mua cố định dưới
          Positioned(
            left: 0, right: 0, bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16,12,16,16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(.1), blurRadius: 10)],
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Giá vé', style: TextStyle(fontSize: 12, color: Colors.black54)),
                        Text(price, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                      ],
                    ),
                    const Spacer(),
                    FilledButton.icon(
                      icon: const Icon(Icons.shopping_bag),
                      label: const Text('Mua vé'),
                      onPressed: () async {
                        final name = _nameCtrl.text.trim().isEmpty ? 'Khách' : _nameCtrl.text.trim();
                        final t = await context.read<TicketProvider>()
                            .buyTicket(eventId: e.id!, buyerName: name);
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Đã mua vé • Mã: ${t.code}')),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
