import 'package:flutter/material.dart';

const Color baseColor = Color(0xFFE7626C);
const Color cardColor = Color(0xFFF4EDDB);
const Color displayLargeColor = Color(0xFF232B55);

const ColorScheme colorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFFE7626C), // 메인 색상
  onPrimary: Colors.white, // 기본 텍스트 색상
  secondary: Color(0xFF6D8AFF), // 보조 색상
  onSecondary: Colors.white, // 보조 색상 위의 텍스트
  error: Color(0xFFD32F2F), // 에러 색상
  onError: Colors.white, // 배경 위 텍스트
  surface: cardColor, // 카드나 버튼의 표면 색상
  onSurface: Color(0xFF232B55), // 표면 위의 텍스트 색상
);
