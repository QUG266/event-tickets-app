import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../providers/ticket_provider.dart';

class MyTicketsScreen extends StatelessWidget {
  const MyTicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.watch<TicketProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Vé của tôi')),
      body: RefreshIndicator(
        onRefresh: ()=> context.read<TicketProvider>().loadMyTickets(),
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          separatorBuilder: (_, __)=> const SizedBox(height: 12),
          itemCount: p.myList.length,
          itemBuilder: (_, i){
            final t = p.myList[i];
            final used = t.status.name == 'used';
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 12)],
                border: Border.all(color: Theme.of(context).dividerColor),
              ),
              child: Row(
                children: [
                  // QR “rời” như cuống vé
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: const BorderRadius.horizontal(left: Radius.circular(20)),
                    ),
                    child: QrImageView(data: t.code, size: 90),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Vé #${t.id}', style: const TextStyle(fontWeight: FontWeight.w800)),
                          const SizedBox(height: 6),
                          Text('Mã: ${t.code}', maxLines: 1, overflow: TextOverflow.ellipsis),
                          Text('Người mua: ${t.buyerName}'),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Chip(
                                label: Text(used ? 'ĐÃ DÙNG' : 'CÒN HIỆU LỰC'),
                                visualDensity: VisualDensity.compact,
                                color: WidgetStatePropertyAll(
                                  used ? Colors.red.withOpacity(.15) : Colors.green.withOpacity(.15)),
                              ),
                              const Spacer(),
                              IconButton(
                                tooltip: 'Hiển thị QR lớn',
                                onPressed: (){
                                  showDialog(context: context, builder: (_)=> AlertDialog(
                                    content: QrImageView(data: t.code, size: 260),
                                  ));
                                },
                                icon: const Icon(Icons.fullscreen),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
