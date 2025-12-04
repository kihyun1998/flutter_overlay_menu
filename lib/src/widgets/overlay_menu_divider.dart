import 'package:flutter/material.dart';
import 'overlay_menu_entry.dart';

/// A divider widget for overlay menus.
///
/// Creates a horizontal line to separate menu items.
/// The appearance can be customized using the provided properties.
///
/// Example:
/// ```dart
/// OverlayMenu(
///   items: [
///     OverlayMenuItem(child: Text('Item 1')),
///     OverlayMenuDivider(),
///     OverlayMenuItem(child: Text('Item 2')),
///   ],
/// )
/// ```
class OverlayMenuDivider extends OverlayMenuEntry {
  /// Creates a menu divider.
  const OverlayMenuDivider({
    Key? key,
    this.height = 1.0,
    this.thickness = 1.0,
    this.color,
    this.indent = 0.0,
    this.endIndent = 0.0,
  }) : super(key: key);

  /// The divider's height including any spacing above and below.
  ///
  /// Defaults to 1.0.
  final double height;

  /// The thickness of the divider line.
  ///
  /// Defaults to 1.0.
  final double thickness;

  /// The color of the divider.
  ///
  /// If null, uses [ThemeData.dividerColor].
  final Color? color;

  /// The amount of empty space to the left of the divider.
  final double indent;

  /// The amount of empty space to the right of the divider.
  final double endIndent;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      thickness: thickness,
      color: color,
      indent: indent,
      endIndent: endIndent,
    );
  }
}
