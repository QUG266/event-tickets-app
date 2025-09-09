import 'package:flutter/material.dart';

class TicketCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? trailing;
  const TicketCard({super.key, required this.title, required this.subtitle, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: trailing,
      ),
    );
  }
}
