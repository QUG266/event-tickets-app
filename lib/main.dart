import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // 👈 hỗ trợ đa ngôn ngữ
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart'; // 👈 init locale data

import 'providers/event_provider.dart';
import 'providers/ticket_provider.dart';
import 'ui/screens/events_list_screen.dart';
import 'ui/screens/my_tickets_screen.dart';
import 'ui/screens/checkin_scanner_screen.dart';
import 'app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 👇 Khởi tạo dữ liệu locale cho intl (vd: vi_VN)
  await initializeDateFormatting('vi_VN', null);
  Intl.defaultLocale = 'vi_VN';

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventProvider()..load()),
        ChangeNotifierProvider(create: (_) => TicketProvider()..loadMyTickets()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Tickets',
      theme: appTheme,
      locale: const Locale('vi'), // 👈 mặc định tiếng Việt
      supportedLocales: const [
        Locale('vi'),
        Locale('en'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const _RootShell(),
    );
  }
}

class _RootShell extends StatefulWidget {
  const _RootShell();

  @override
  State<_RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<_RootShell> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = const [
      EventsListScreen(),
      MyTicketsScreen(),
      CheckinScannerScreen(),
    ];

    return Scaffold(
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => setState(() => index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.event), label: 'Sự kiện'),
          NavigationDestination(icon: Icon(Icons.confirmation_number), label: 'Vé của tôi'),
          NavigationDestination(icon: Icon(Icons.qr_code_scanner), label: 'Quét QR'),
        ],
      ),
    );
  }
}
