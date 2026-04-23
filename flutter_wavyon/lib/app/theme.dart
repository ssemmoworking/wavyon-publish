import 'package:flutter/material.dart';

class WavyonColors {
  static const Color primary = Color(0xFF1E3A8A);
  static const Color blue = Color(0xFF2563EB);
  static const Color indigo = Color(0xFF4338CA);
  static const Color violet = Color(0xFF8B5CF6);
  static const Color cyan = Color(0xFF06B6D4);
  static const Color pink = Color(0xFFEC4899);
  static const Color rose = Color(0xFFF43F5E);
  static const Color red = Color(0xFFDC2626);
  static const Color amber = Color(0xFFF59E0B);
  static const Color ink = Color(0xFF0F172A);
  static const Color deepIndigo = Color(0xFF1E1B4B);
  static const Color canvas = Color(0xFFFBFBFF);
  static const Color card = Colors.white;
  static const Color line = Color(0xFFF1F5F9);
  static const Color text = Color(0xFF0F172A);
  static const Color subtleText = Color(0xFF475569);
  static const Color muted = Color(0xFF94A3B8);
}

class WavyonGradients {
  static const LinearGradient text = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      WavyonColors.blue,
      WavyonColors.violet,
      WavyonColors.pink,
      WavyonColors.amber,
    ],
  );

  static const LinearGradient banner1 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      WavyonColors.primary,
      WavyonColors.indigo,
      WavyonColors.violet,
    ],
  );

  static const LinearGradient banner2 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      WavyonColors.violet,
      WavyonColors.pink,
      WavyonColors.rose,
    ],
  );

  static const LinearGradient banner3 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      WavyonColors.cyan,
      WavyonColors.blue,
      WavyonColors.violet,
    ],
  );

  static const LinearGradient banner4 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFDB2777),
      Color(0xFFEA580C),
    ],
  );

  static const LinearGradient dark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      WavyonColors.ink,
      WavyonColors.deepIndigo,
    ],
  );
}

class WavyonShadows {
  static const List<BoxShadow> card = [
    BoxShadow(
      color: Color(0x0A0F172A),
      blurRadius: 16,
      offset: Offset(0, 6),
    ),
  ];

  static const List<BoxShadow> strong = [
    BoxShadow(
      color: Color(0x190F172A),
      blurRadius: 30,
      offset: Offset(0, 16),
    ),
  ];

  static const List<BoxShadow> blue = [
    BoxShadow(
      color: Color(0x332563EB),
      blurRadius: 24,
      offset: Offset(0, 14),
    ),
  ];
}

class WavyonBadgeStyle {
  const WavyonBadgeStyle({
    required this.background,
    required this.foreground,
    required this.border,
  });

  final Color background;
  final Color foreground;
  final Color border;
}

String tradeStatusLabel(String statusKey) {
  switch (statusKey) {
    case 'ON_SALE':
      return 'On sale';
    case 'RESERVED':
      return 'Reserved';
    case 'COMPLETED':
      return 'Completed';
    case 'HIDDEN_REPORTED':
      return 'Reported';
    case 'HIDDEN_BLOCKED':
      return 'Blocked';
    case 'DELETED':
      return 'Deleted';
    default:
      return statusKey;
  }
}

WavyonBadgeStyle tradeStatusStyle(String statusKey) {
  switch (statusKey) {
    case 'ON_SALE':
      return const WavyonBadgeStyle(
        background: Color(0xFFF0FDF4),
        foreground: Color(0xFF16A34A),
        border: Color(0xFFDCFCE7),
      );
    case 'RESERVED':
      return const WavyonBadgeStyle(
        background: Color(0xFFFFF7ED),
        foreground: Color(0xFFEA580C),
        border: Color(0xFFFED7AA),
      );
    case 'COMPLETED':
      return const WavyonBadgeStyle(
        background: Color(0xFFF1F5F9),
        foreground: Color(0xFF64748B),
        border: Color(0xFFE2E8F0),
      );
    case 'HIDDEN_REPORTED':
      return const WavyonBadgeStyle(
        background: Color(0xFFFEF2F2),
        foreground: Color(0xFFDC2626),
        border: Color(0xFFFECACA),
      );
    case 'HIDDEN_BLOCKED':
      return const WavyonBadgeStyle(
        background: Color(0xFFE2E8F0),
        foreground: Color(0xFF475569),
        border: Color(0xFFCBD5E1),
      );
    default:
      return const WavyonBadgeStyle(
        background: Color(0xFFF1F5F9),
        foreground: Color(0xFF94A3B8),
        border: Color(0xFFE2E8F0),
      );
  }
}

WavyonBadgeStyle notificationCategoryStyle(String category) {
  switch (category) {
    case 'SYSTEM':
      return const WavyonBadgeStyle(
        background: Color(0xFFFEF2F2),
        foreground: Color(0xFFDC2626),
        border: Color(0xFFFECACA),
      );
    case 'PAYMENT':
      return const WavyonBadgeStyle(
        background: Color(0xFFF0FDF4),
        foreground: Color(0xFF16A34A),
        border: Color(0xFFDCFCE7),
      );
    case 'TRADE':
      return const WavyonBadgeStyle(
        background: Color(0xFFEFF6FF),
        foreground: Color(0xFF1D4ED8),
        border: Color(0xFFBFDBFE),
      );
    case 'COMMUNITY':
      return const WavyonBadgeStyle(
        background: Color(0xFFEEF2FF),
        foreground: Color(0xFF4338CA),
        border: Color(0xFFC7D2FE),
      );
    case 'NOTICE':
      return const WavyonBadgeStyle(
        background: Color(0xFFF5F3FF),
        foreground: Color(0xFF7C3AED),
        border: Color(0xFFDDD6FE),
      );
    case 'RESERVATION':
      return const WavyonBadgeStyle(
        background: Color(0xFFFFF7ED),
        foreground: Color(0xFFEA580C),
        border: Color(0xFFFED7AA),
      );
    default:
      return const WavyonBadgeStyle(
        background: Color(0xFFF8FAFC),
        foreground: WavyonColors.subtleText,
        border: Color(0xFFE2E8F0),
      );
  }
}

ThemeData buildWavyonTheme() {
  final base = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: WavyonColors.blue,
      primary: WavyonColors.blue,
      surface: Colors.white,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: WavyonColors.canvas,
    useMaterial3: true,
  );

  return base.copyWith(
    scaffoldBackgroundColor: WavyonColors.canvas,
    splashFactory: InkRipple.splashFactory,
    textTheme: base.textTheme.copyWith(
      headlineLarge: const TextStyle(
        fontSize: 30,
        height: 1.05,
        fontWeight: FontWeight.w900,
        color: WavyonColors.text,
      ),
      headlineMedium: const TextStyle(
        fontSize: 22,
        height: 1.15,
        fontWeight: FontWeight.w900,
        color: WavyonColors.text,
      ),
      titleLarge: const TextStyle(
        fontSize: 18,
        height: 1.2,
        fontWeight: FontWeight.w900,
        color: WavyonColors.text,
      ),
      titleMedium: const TextStyle(
        fontSize: 13,
        height: 1.25,
        fontWeight: FontWeight.w900,
        color: WavyonColors.text,
      ),
      bodyLarge: const TextStyle(
        fontSize: 13,
        height: 1.45,
        fontWeight: FontWeight.w700,
        color: WavyonColors.subtleText,
      ),
      bodyMedium: const TextStyle(
        fontSize: 11,
        height: 1.35,
        fontWeight: FontWeight.w700,
        color: WavyonColors.muted,
      ),
      labelLarge: const TextStyle(
        fontSize: 11,
        height: 1.1,
        fontWeight: FontWeight.w900,
        color: WavyonColors.text,
      ),
      labelMedium: const TextStyle(
        fontSize: 10,
        height: 1.1,
        fontWeight: FontWeight.w900,
        color: WavyonColors.subtleText,
      ),
      labelSmall: const TextStyle(
        fontSize: 9,
        height: 1.1,
        fontWeight: FontWeight.w900,
        color: WavyonColors.muted,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF8FAFC),
      hintStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w800,
        color: WavyonColors.muted,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: WavyonColors.line),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: WavyonColors.blue, width: 1.5),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: WavyonColors.line),
      ),
    ),
  );
}
