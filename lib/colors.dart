import 'package:flutter/material.dart';

const MaterialColor primary = MaterialColor(_primaryPrimaryValue, <int, Color>{
  50: Color(0xFFE5E6E6),
  100: Color(0xFFBFC0C1),
  200: Color(0xFF949698),
  300: Color(0xFF696B6E),
  400: Color(0xFF494C4F),
  500: Color(_primaryPrimaryValue),
  600: Color(0xFF24272B),
  700: Color(0xFF1F2124),
  800: Color(0xFF191B1E),
  900: Color(0xFF0F1013),
});
const int _primaryPrimaryValue = 0xFF292C30;

const MaterialColor primaryAccent =
    MaterialColor(_primaryAccentValue, <int, Color>{
  100: Color(0xFF5991FF),
  200: Color(_primaryAccentValue),
  400: Color(0xFF0051F2),
  700: Color(0xFF0048D9),
});
const int _primaryAccentValue = 0xFF266FFF;
