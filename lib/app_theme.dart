import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final appTheme = ThemeData(
  useMaterial3: true,
  colorSchemeSeed: const Color(0xFF635BFF), // tím indigo tươi
  textTheme: GoogleFonts.interTextTheme(),
  cardTheme: CardTheme(
    elevation: 1,
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
  appBarTheme: const AppBarTheme(centerTitle: true),
);
// Chú ý: Nếu muốn đổi màu chủ đề, hãy đổi colorSchemeSeed ở trên
// Mã màu có thể lấy từ https://flatuicolors.com/