import 'package:flutter/material.dart';
import '../models/menu_divider_style.dart';
import '../models/menu_style.dart';
import 'overlay_menu_entry.dart';

/// A divider widget for overlay menus.
///
/// Creates a horizontal line to separate menu items.
/// The appearance can be customized using the provided properties
/// or through the menu's dividerStyle.
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
///
/// Example with custom style:
/// ```dart
/// OverlayMenuDivider(
///   style: OverlayMenuDividerStyle(
///     height: 12,
///     thickness: 2,
///     color: Colors.grey[300],
///     indent: 12,
///     endIndent: 12,
///   ),
/// )
/// ```
class OverlayMenuDivider extends OverlayMenuEntry {
  /// Creates a menu divider.
  const OverlayMenuDivider({
    Key? key,
    this.style,
    this.menuDividerStyle, // Internal: from OverlayMenu
  }) : super(key: key);

  /// Custom style for this specific divider.
  ///
  /// Overrides the menu's dividerStyle.
  final OverlayMenuDividerStyle? style;

  /// Internal: menu-level divider style passed from OverlayMenu.
  /// Should not be set by users.
  final OverlayMenuDividerStyle? menuDividerStyle;

  /// Gets the effective height of this divider.
  ///
  /// Uses the height from style, menuDividerStyle, or defaults to 16.0.
  /// This is used by MenuSizeCalculator for size estimation.
  double get height {
    // Priority: style > menuDividerStyle > default (16.0)
    return style?.height ?? menuDividerStyle?.height ?? 16.0;
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = _resolveStyle(context);

    return Container(
      height: effectiveStyle.height,
      alignment: Alignment.center,
      child: Divider(
        thickness: effectiveStyle.thickness,
        color: effectiveStyle.color,
        indent: effectiveStyle.indent,
        endIndent: effectiveStyle.endIndent,
        height: 0, // Inner height (we control outer height with Container)
      ),
    );
  }

  /// Resolves the effective style based on priority:
  /// 1. style (this widget)
  /// 2. menuDividerStyle (from menuStyle)
  /// 3. Default style
  OverlayMenuDividerStyle _resolveStyle(BuildContext context) {
    // 1. Individual divider style takes priority
    if (style != null) {
      return _mergeWithDefaults(context, style!);
    }

    // 2. Menu's divider style
    if (menuDividerStyle != null) {
      return _mergeWithDefaults(context, menuDividerStyle!);
    }

    // 3. Default style
    return OverlayMenuDividerStyle.defaultStyle(context);
  }

  /// Merges the provided style with defaults.
  OverlayMenuDividerStyle _mergeWithDefaults(
    BuildContext context,
    OverlayMenuDividerStyle dividerStyle,
  ) {
    final defaults = OverlayMenuDividerStyle.defaultStyle(context);
    return OverlayMenuDividerStyle(
      height: dividerStyle.height ?? defaults.height,
      thickness: dividerStyle.thickness ?? defaults.thickness,
      color: dividerStyle.color ?? defaults.color,
      indent: dividerStyle.indent ?? defaults.indent,
      endIndent: dividerStyle.endIndent ?? defaults.endIndent,
    );
  }
}
