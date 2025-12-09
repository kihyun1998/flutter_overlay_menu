import 'package:flutter/material.dart';

/// Style configuration for menu dividers.
///
/// Controls the appearance of dividers between menu items.
///
/// Example:
/// ```dart
/// OverlayMenuDividerStyle(
///   height: 12,
///   thickness: 1,
///   color: Colors.grey[300],
///   indent: 12,
///   endIndent: 12,
/// )
/// ```
class OverlayMenuDividerStyle {
  /// Creates a menu divider style.
  const OverlayMenuDividerStyle({
    this.height,
    this.thickness,
    this.color,
    this.indent,
    this.endIndent,
  });

  /// Total height of the divider widget.
  ///
  /// Includes padding. Defaults to 16.0.
  final double? height;

  /// Thickness of the divider line.
  ///
  /// Defaults to 1.0.
  final double? thickness;

  /// Color of the divider line.
  ///
  /// If null, uses Theme.dividerColor.
  final Color? color;

  /// Indent from the left edge.
  ///
  /// Defaults to 16.0.
  final double? indent;

  /// Indent from the right edge.
  ///
  /// Defaults to 16.0.
  final double? endIndent;

  /// Creates a copy with specified fields replaced.
  OverlayMenuDividerStyle copyWith({
    double? height,
    double? thickness,
    Color? color,
    double? indent,
    double? endIndent,
  }) {
    return OverlayMenuDividerStyle(
      height: height ?? this.height,
      thickness: thickness ?? this.thickness,
      color: color ?? this.color,
      indent: indent ?? this.indent,
      endIndent: endIndent ?? this.endIndent,
    );
  }

  /// Creates a default divider style.
  static OverlayMenuDividerStyle defaultStyle(BuildContext context) {
    return OverlayMenuDividerStyle(
      height: 16.0,
      thickness: 1.0,
      color: Theme.of(context).dividerColor,
      indent: 16.0,
      endIndent: 16.0,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OverlayMenuDividerStyle &&
        other.height == height &&
        other.thickness == thickness &&
        other.color == color &&
        other.indent == indent &&
        other.endIndent == endIndent;
  }

  @override
  int get hashCode {
    return Object.hash(
      height,
      thickness,
      color,
      indent,
      endIndent,
    );
  }
}
