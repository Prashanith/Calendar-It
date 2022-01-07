import 'dart:ui';

enum AppTheme{
  darkMode,
  lightMode
}

abstract class Theme{}

class LightTheme extends Theme{
  static const primary=Color(0xff142850);
  static const secondary=Color(0xff27496D);
  static const tertiary=Color(0xff00909E);
  static const quaternary=Color(0xffDAE1E7);
}

class DarkTheme extends Theme{
  static const primary=Color(0xff141414);
  static const secondary=Color(0xff0a0a0a);
  static const tertiary=Color(0xffcecece);
  static const quaternary=Color(0xffececec);
}