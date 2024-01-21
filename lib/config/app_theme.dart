import 'package:flutter/material.dart';

class AppTheme {
  static Color background = HexColor.from("#ffffff");
  static Color aboutBackground = HexColor.from("#f2f2f2");
  static Color projectsBackground = HexColor.from("#FBF6EF");
  static Color experienceBackground = HexColor.from("#FFF3FA");
  static Color skillsBackground = HexColor.from("#ffffff");
  static Color foreground = Colors.grey.shade900;
  static Color foregroundLighter = Colors.grey.shade800;
  static Color buttonBorder = HexColor.from("#818181");

  static TextStyle get fontBold => TextStyle(
        fontFamily: "Satoshi",
        fontWeight: FontWeight.bold,
        color: foreground,
      );

  static TextStyle get fontExtraBold => TextStyle(
        fontFamily: "Satoshi",
        fontWeight: FontWeight.w900,
        color: foreground,
      );

  static TextStyle fontSize(double size) => TextStyle(
        fontFamily: "Satoshi",
        fontSize: size,
        color: foreground,
      );
}

class InputDecorations {
  static final BorderRadius _borderRadius = BorderRadius.circular(10);

  static InputDecoration get outlinedInputDecoration => InputDecoration(
        border: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: const BorderSide(color: Colors.grey, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: const BorderSide(color: Colors.grey, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: const BorderSide(color: Colors.green, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      );

  static InputDecoration createOutlined({String? labelText, String? hintText}) {
    return outlinedInputDecoration.copyWith(
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Colors.grey,
      ),
      hintText: hintText,
      hintStyle: const TextStyle(
        color: Colors.grey,
      ),
      errorStyle: const TextStyle(
        color: Colors.red,
        fontFamily: "Sen",
        fontSize: 12,
      ),
    );
  }

  static InputDecoration createUnderLined(
      {String? labelText, String? hintText}) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Colors.grey,
      ),
      hintText: hintText,
      hintStyle: const TextStyle(
        color: Colors.grey,
      ),
      errorStyle: const TextStyle(
        color: Colors.red,
        fontFamily: "Sen",
        fontSize: 12,
      ),
    );
  }
}

extension ConfigurableTextStyle on TextStyle {
  TextStyle withColor(Color color) {
    return copyWith(
      color: color,
    );
  }

  TextStyle useSen() {
    return copyWith(
      fontFamily: "Sen",
    );
  }

  TextStyle makeBold() {
    return copyWith(
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle makeItalic() {
    return copyWith(
      fontStyle: FontStyle.italic,
    );
  }

  TextStyle makeExtraBold() {
    return copyWith(
      fontWeight: FontWeight.w900,
    );
  }

  TextStyle makeMedium() {
    return copyWith(
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle fontSize(double size) {
    return copyWith(
      fontSize: size,
    );
  }
}

extension HexColor on Color {
  static Color from(String hexColor) {
    hexColor = hexColor.replaceAll("0x", "");
    hexColor = hexColor.replaceAll("#", "");
    hexColor = hexColor.toUpperCase();
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}
