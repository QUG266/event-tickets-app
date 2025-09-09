import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import '../../providers/ticket_provider.dart';

class CheckinScannerScreen extends StatefulWidget {
  const CheckinScannerScreen({super.key});

  @override
  State<CheckinScannerScreen> createState() => _CheckinScannerScreenState();
}

class _CheckinScannerScreenState extends State<CheckinScannerScreen> {
  bool _locked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quét QR Check-in')),
      body: MobileScanner(
        onDetect: (capture) async {
          if (_locked) return;
          final raw = capture.barcodes.first.rawValue;
          if (raw == null) return;
          setState(()=> _locked = true);
          final msg = await context.read<TicketProvider>().checkIn(raw);
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
          await Future.delayed(const Duration(seconds: 1));
          setState(()=> _locked = false);
        },
      ),
    );
  }
}
