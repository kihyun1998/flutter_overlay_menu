import 'package:flutter/material.dart';

/// Style configuration for overlay menu items.
///
/// Controls the appearance of menu items including layout, colors,
/// borders, text, and icons.
///
/// Example:
/// ```dart
/// OverlayMenuItemStyle(
///   height: 44,
///   padding: EdgeInsets.symmetric(horizontal: 12),
///   backgroundColor: Colors.transparent,
///   hoverColor: Colors.grey[100],
///   borderRadius: BorderRadius.circular(8),
///   textStyle: TextStyle(fontSize: 14),
/// )
/// ```
class OverlayMenuItemStyle {
  /// Creates an overlay menu item style.
  const OverlayMenuItemStyle({
    // Layout
    this.height,
    this.padding,
    this.margin,
    // Background colors
    this.backgroundColor,
    this.hoverColor,
    this.splashColor,
    this.highlightColor,
    // Border
    this.border,
    this.borderRadius,
    // Text
    this.textStyle,
    // Icon
    this.iconColor,
    this.iconSize,
    // Spacing
    this.leadingGap,
    this.trailingGap,
    // Visual effects
    this.elevation,
    this.shadowColor,
  });

  // ===== Layout Properties =====

  /// Height of the menu item.
  ///
  /// If null, defaults to 48.0.
  final double? height;

  /// Internal padding of the menu item content.
  ///
  /// If null, defaults to `EdgeInsets.symmetric(horizontal: 16.0)`.
  final EdgeInsetsGeometry? padding;

  /// External margin around the menu item.
  ///
  /// If null, defaults to `EdgeInsets.zero`.
  final EdgeInsetsGeometry? margin;

  // ===== Background Colors =====

  /// Background color in normal state.
  ///
  /// If null, defaults to transparent.
  final Color? backgroundColor;

  /// Color when hovering over the item.
  ///
  /// Applied via InkWell.hoverColor.
  /// If null, uses Theme's hoverColor.
  final Color? hoverColor;

  /// Color for the splash (ripple) effect when tapped.
  ///
  /// Applied via InkWell.splashColor.
  /// If null, uses Theme's splashColor.
  final Color? splashColor;

  /// Color when pressing and holding the item.
  ///
  /// Applied via InkWell.highlightColor.
  /// If null, uses Theme's highlightColor.
  final Color? highlightColor;

  // ===== Border Properties =====

  /// Border around the menu item.
  ///
  /// Common use: `Border.all(color: Colors.blue)`
  final BoxBorder? border;

  /// Border radius for rounded corners.
  ///
  /// Applies to both the container decoration and InkWell ripple.
  /// If null, defaults to `BorderRadius.zero`.
  final BorderRadius? borderRadius;

  // ===== Text Style =====

  /// Text style for the menu item content.
  ///
  /// Applied via DefaultTextStyle to affect all text widgets.
  final TextStyle? textStyle;

  // ===== Icon Properties =====

  /// Color for icons (leading and trailing).
  ///
  /// Applied via IconTheme.
  final Color? iconColor;

  /// Size for icons (leading and trailing).
  ///
  /// Applied via IconTheme.
  /// If null, defaults to 24.0.
  final double? iconSize;

  // ===== Spacing =====

  /// Gap between leading widget and child.
  ///
  /// If null, defaults to 12.0.
  final double? leadingGap;

  /// Gap between child and trailing widget.
  ///
  /// If null, defaults to 12.0.
  final double? trailingGap;

  // ===== Visual Effects =====

  /// Elevation (shadow depth) for the item.
  ///
  /// Usually 0.0 for menu items. Use for special emphasis.
  final double? elevation;

  /// Shadow color for the elevation.
  final Color? shadowColor;

  /// Creates a copy with specified fields replaced.
  OverlayMenuItemStyle copyWith({
    double? height,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
    Color? hoverColor,
    Color? splashColor,
    Color? highlightColor,
    BoxBorder? border,
    BorderRadius? borderRadius,
    TextStyle? textStyle,
    Color? iconColor,
    double? iconSize,
    double? leadingGap,
    double? trailingGap,
    double? elevation,
    Color? shadowColor,
  }) {
    return OverlayMenuItemStyle(
      height: height ?? this.height,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      hoverColor: hoverColor ?? this.hoverColor,
      splashColor: splashColor ?? this.splashColor,
      highlightColor: highlightColor ?? this.highlightColor,
      border: border ?? this.border,
      borderRadius: borderRadius ?? this.borderRadius,
      textStyle: textStyle ?? this.textStyle,
      iconColor: iconColor ?? this.iconColor,
      iconSize: iconSize ?? this.iconSize,
      leadingGap: leadingGap ?? this.leadingGap,
      trailingGap: trailingGap ?? this.trailingGap,
      elevation: elevation ?? this.elevation,
      shadowColor: shadowColor ?? this.shadowColor,
    );
  }

  /// Merges this style with another, with other taking precedence.
  ///
  /// This is useful for combining default styles with custom overrides.
  OverlayMenuItemStyle merge(OverlayMenuItemStyle? other) {
    if (other == null) return this;
    return copyWith(
      height: other.height ?? height,
      padding: other.padding ?? padding,
      margin: other.margin ?? margin,
      backgroundColor: other.backgroundColor ?? backgroundColor,
      hoverColor: other.hoverColor ?? hoverColor,
      splashColor: other.splashColor ?? splashColor,
      highlightColor: other.highlightColor ?? highlightColor,
      border: other.border ?? border,
      borderRadius: other.borderRadius ?? borderRadius,
      textStyle: other.textStyle ?? textStyle,
      iconColor: other.iconColor ?? iconColor,
      iconSize: other.iconSize ?? iconSize,
      leadingGap: other.leadingGap ?? leadingGap,
      trailingGap: other.trailingGap ?? trailingGap,
      elevation: other.elevation ?? elevation,
      shadowColor: other.shadowColor ?? shadowColor,
    );
  }

  /// Creates a default normal (non-selected) item style.
  static OverlayMenuItemStyle defaultNormal(BuildContext context) {
    final theme = Theme.of(context);
    return OverlayMenuItemStyle(
      height: 48.0,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      margin: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      hoverColor: theme.hoverColor,
      splashColor: theme.splashColor,
      highlightColor: theme.highlightColor,
      borderRadius: BorderRadius.zero,
      leadingGap: 12.0,
      trailingGap: 12.0,
      iconSize: 24.0,
      elevation: 0.0,
    );
  }

  /// Creates a default selected item style.
  static OverlayMenuItemStyle defaultSelected(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return OverlayMenuItemStyle(
      height: 48.0,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      margin: EdgeInsets.zero,
      backgroundColor: primaryColor.withValues(alpha: 0.08),
      hoverColor: primaryColor.withValues(alpha: 0.12),
      splashColor: primaryColor.withValues(alpha: 0.16),
      highlightColor: primaryColor.withValues(alpha: 0.12),
      borderRadius: BorderRadius.zero,
      textStyle: TextStyle(
        color: primaryColor,
        fontWeight: FontWeight.w600,
      ),
      iconColor: primaryColor,
      leadingGap: 12.0,
      trailingGap: 12.0,
      iconSize: 24.0,
      elevation: 0.0,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OverlayMenuItemStyle &&
        other.height == height &&
        other.padding == padding &&
        other.margin == margin &&
        other.backgroundColor == backgroundColor &&
        other.hoverColor == hoverColor &&
        other.splashColor == splashColor &&
        other.highlightColor == highlightColor &&
        other.border == border &&
        other.borderRadius == borderRadius &&
        other.textStyle == textStyle &&
        other.iconColor == iconColor &&
        other.iconSize == iconSize &&
        other.leadingGap == leadingGap &&
        other.trailingGap == trailingGap &&
        other.elevation == elevation &&
        other.shadowColor == shadowColor;
  }

  @override
  int get hashCode {
    return Object.hash(
      height,
      padding,
      margin,
      backgroundColor,
      hoverColor,
      splashColor,
      highlightColor,
      border,
      borderRadius,
      textStyle,
      iconColor,
      iconSize,
      leadingGap,
      trailingGap,
      elevation,
      shadowColor,
    );
  }
}
