import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/models/event.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback onTap;
  const EventCard({super.key, required this.event, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final price = NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(event.price);
    return InkWell(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Ảnh nền
            CachedNetworkImage(
              imageUrl: event.imageUrl,
              height: 190, width: double.infinity, fit: BoxFit.cover,
              placeholder: (_, __) => Container(height: 190, color: Colors.black12),
              errorWidget: (_, __, ___) => Container(height: 190, color: Colors.black26),
            ),
            // Gradient tối dưới
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter, end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.65)],
                  ),
                ),
              ),
            ),
            // Nội dung
            Positioned(
              left: 16, right: 16, bottom: 14,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(event.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 4),
                        Text(
                          '${DateFormat('dd/MM/yyyy HH:mm').format(event.dateTime)} • ${event.location}',
                          style: TextStyle(color: Colors.white.withOpacity(0.9)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer.withOpacity(.9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(price, style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w700)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
