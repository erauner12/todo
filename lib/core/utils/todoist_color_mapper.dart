import 'package:flutter/material.dart';

/// Converts Todoist color names (REST v2 `color` field) to a Flutter [Color].
/// Falls back to [defaultColor] when the name is unknown or empty.
Color todoistColor(String? name, {Color defaultColor = Colors.grey}) {
  if (name == null || name.isEmpty) return defaultColor;

  // NB: keep this map exhaustive for Todoist v2 palette.
  const map = <String, int>{
    'berry_red': 0xFFb8256f,
    'red': 0xFFdb4035,
    'orange': 0xFFff9933,
    'yellow': 0xFFfad000,
    'olive_green': 0xFFafb83b,
    'lime_green': 0xFF7ecc49,
    'green': 0xFF299438,
    'mint_green': 0xFF6accbc,
    'teal': 0xFF158fad,
    'sky_blue': 0xFF14aaf5,
    'light_blue': 0xFF96c3eb,
    'blue': 0xFF4073ff,
    'grape': 0xFF884dff,
    'violet': 0xFFaf38eb,
    'lavender': 0xFFeb96eb,
    'magenta': 0xFFe05194,
    'salmon': 0xFFff8d85,
    'charcoal': 0xFF808080,
    'grey': 0xFFb8b8b8,
  };

  return Color(map[name] ?? defaultColor.value);
}