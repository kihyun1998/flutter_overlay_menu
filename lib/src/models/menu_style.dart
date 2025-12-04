import 'package:flutter/material.dart';

/// Style configuration for overlay menus.
///
/// Defines the visual appearance and dimensions of the menu overlay,
/// including size constraints, colors, elevation, and shape.
///
/// Example:
/// ```dart
/// OverlayMenuStyle(
///   minWidth: 200,
///   maxWidth: 400,
///   backgroundColor: Colors.white,
///   elevation: 8,
///   shape: RoundedRectangleBorder(
///     borderRadius: BorderRadius.circular(12),
///   ),
/// )
/// ```
class OverlayMenuStyle {
  /// Creates an overlay menu style.
  const OverlayMenuStyle({
    this.width,
    this.minWidth,
    this.maxWidth,
    this.maxHeight = 300.0,
    this.backgroundColor,
    this.elevation = 8.0,
    this.shadowColor,
    this.shape,
    this.padding,
    this.scrollbarTheme,
  });

  /// Fixed width for the menu.
  ///
  /// If null, the menu width will match the anchor widget width,
  /// constrained by [minWidth] and [maxWidth].
  final double? width;

  /// Minimum width for the menu.
  ///
  /// If the calculated width is less than this value, it will be
  /// expanded to this minimum.
  final double? minWidth;

  /// Maximum width for the menu.
  ///
  /// If the calculated width is greater than this value, it will be
  /// constrained to this maximum.
  final double? maxWidth;

  /// Maximum height for the menu.
  ///
  /// If the content height exceeds this value, the menu will become
  /// scrollable. Defaults to 300.0.
  final double maxHeight;

  /// Background color of the menu.
  ///
  /// If null, uses [ThemeData.cardColor].
  final Color? backgroundColor;

  /// Elevation of the menu Material.
  ///
  /// Controls the shadow depth. Defaults to 8.0.
  final double elevation;

  /// Shadow color for the menu elevation.
  ///
  /// If null, uses the default Material shadow color.
  final Color? shadowColor;

  /// Shape of the menu.
  ///
  /// Defines the border radius and other shape properties.
  /// If null, uses a [RoundedRectangleBorder] with 8.0 radius.
  final ShapeBorder? shape;

  /// Internal padding of the menu.
  ///
  /// This creates space between the menu edges and its content.
  final EdgeInsetsGeometry? padding;

  /// Theme for the scrollbar (if the menu becomes scrollable).
  ///
  /// This will be used in Phase 2+.
  final ScrollbarThemeData? scrollbarTheme;

  /// Creates a copy of this style with the given fields replaced.
  OverlayMenuStyle copyWith({
    double? width,
    double? minWidth,
    double? maxWidth,
    double? maxHeight,
    Color? backgroundColor,
    double? elevation,
    Color? shadowColor,
    ShapeBorder? shape,
    EdgeInsetsGeometry? padding,
    ScrollbarThemeData? scrollbarTheme,
  }) {
    return OverlayMenuStyle(
      width: width ?? this.width,
      minWidth: minWidth ?? this.minWidth,
      maxWidth: maxWidth ?? this.maxWidth,
      maxHeight: maxHeight ?? this.maxHeight,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      elevation: elevation ?? this.elevation,
      shadowColor: shadowColor ?? this.shadowColor,
      shape: shape ?? this.shape,
      padding: padding ?? this.padding,
      scrollbarTheme: scrollbarTheme ?? this.scrollbarTheme,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OverlayMenuStyle &&
        other.width == width &&
        other.minWidth == minWidth &&
        other.maxWidth == maxWidth &&
        other.maxHeight == maxHeight &&
        other.backgroundColor == backgroundColor &&
        other.elevation == elevation &&
        other.shadowColor == shadowColor &&
        other.shape == shape &&
        other.padding == padding &&
        other.scrollbarTheme == scrollbarTheme;
  }

  @override
  int get hashCode {
    return Object.hash(
      width,
      minWidth,
      maxWidth,
      maxHeight,
      backgroundColor,
      elevation,
      shadowColor,
      shape,
      padding,
      scrollbarTheme,
    );
  }
}
