import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Get the current theme and colors
LibraryColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

/// Helper class for managing themes and colors for iBorrow
class ThemeHelper {
  final _appTheme = "libraryTheme";

  final Map<String, LibraryColors> _supportedCustomColor = {
    'libraryTheme': LibraryColors(),
  };

  final Map<String, ColorScheme> _supportedColorScheme = {
    'libraryTheme': ColorSchemes.libraryColorScheme,
  };

  LibraryColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LibraryColors();
  }

  ThemeData _getThemeData() {
    final colors = _getThemeColors();
    final colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.libraryColorScheme;

    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      useMaterial3: true,
      textTheme: GoogleFonts.interTextTheme().apply(
        bodyColor: colors.black,
        displayColor: colors.black,
      ),
    );
  }

  LibraryColors themeColor() => _getThemeColors();
  ThemeData themeData() => _getThemeData();
}

class ColorSchemes {
  static final libraryColorScheme = ColorScheme.light(
    primary: Color(0xFFFC8520),
    secondary: Color(0xFFBA5A13),
    surface: Color(0xFFFFF2DF),
  );
}

/// iBorrow specific color palette
class LibraryColors {
  // Core colors
  Color get black => Color(0xFF1E1E1E);
  Color get white => Color(0xFFFFFFFF);
  Color get gray500 => Color(0xFF6B7280);

  // Brand colors for iBorrow
  Color get primaryOrange => Color(0xFFFC8520);
  Color get secondaryOrange => Color(0xFFBA5A13);
  Color get darkOrange => Color(0xFFA34A08);
  Color get lightCream => Color(0xFFFFF2DF);
  Color get fieldGray => Color(0xFFD9D9D9);

  // Legacy color support
  Color get blackCustom => Colors.black;
  Color get transparentCustom => Colors.transparent;
  Color get greyCustom => Colors.grey;
  Color get whiteCustom => Colors.white;
  Color get colorFFFFF2 => Color(0xFFFFF2DF);
  Color get colorFFFC85 => Color(0xFFFC8520);
  Color get colorFFBA5A => Color(0xFFBA5A13);
  Color get colorFFA34A => Color(0xFFA34A08);
  Color get colorFFD9D9 => Color(0xFFD9D9D9);
  Color get colorFFA34A2 => Color(0xFFA34A09);

  // Additional shades
  Color get grey200 => Colors.grey.shade200;
  Color get grey100 => Colors.grey.shade100;
}
