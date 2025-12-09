import 'package:flutter/material.dart';
import 'package:flutter_overlay_menu/flutter_overlay_menu.dart';

/// Represents a single menu item in the demo
class DemoMenuItem {
  final String id;
  final String label;
  final IconData? leadingIcon;
  final String? trailingText;
  final bool isDangerous;
  final bool hasDividerAfter;

  const DemoMenuItem({
    required this.id,
    required this.label,
    this.leadingIcon,
    this.trailingText,
    this.isDangerous = false,
    this.hasDividerAfter = false,
  });

  DemoMenuItem copyWith({
    String? id,
    String? label,
    IconData? leadingIcon,
    String? trailingText,
    bool? isDangerous,
    bool? hasDividerAfter,
  }) {
    return DemoMenuItem(
      id: id ?? this.id,
      label: label ?? this.label,
      leadingIcon: leadingIcon ?? this.leadingIcon,
      trailingText: trailingText ?? this.trailingText,
      isDangerous: isDangerous ?? this.isDangerous,
      hasDividerAfter: hasDividerAfter ?? this.hasDividerAfter,
    );
  }
}

/// Demo configuration for the overlay menu
class DemoConfiguration {
  // Style
  final double borderRadius;
  final double elevation;
  final Color backgroundColor;
  final double minWidth;
  final double? maxWidth;
  final double maxHeight;

  // Position
  final PositionPreference positionPreference;
  final MenuAlignment alignment;
  final Offset offset;

  // Animation
  final int durationMs;
  final Curve curve;

  // Items
  final List<DemoMenuItem> items;

  // Item Styles (NEW)
  final OverlayMenuItemStyle? itemStyle;
  final OverlayMenuItemStyle? selectedItemStyle;
  final OverlayMenuDividerStyle? dividerStyle;

  // Advanced
  final bool barrierDismissible;
  final Color barrierColor;
  final double buttonGap;
  final double screenMargin;

  const DemoConfiguration({
    // Style
    this.borderRadius = 8.0,
    this.elevation = 8.0,
    this.backgroundColor = Colors.white,
    this.minWidth = 180.0,
    this.maxWidth,
    this.maxHeight = 300.0,
    // Position
    this.positionPreference = PositionPreference.auto,
    this.alignment = MenuAlignment.start,
    this.offset = Offset.zero,
    // Animation
    this.durationMs = 200,
    this.curve = Curves.easeOutCubic,
    // Items
    required this.items,
    // Item Styles
    this.itemStyle,
    this.selectedItemStyle,
    this.dividerStyle,
    // Advanced
    this.barrierDismissible = true,
    this.barrierColor = Colors.transparent,
    this.buttonGap = 4.0,
    this.screenMargin = 8.0,
  });

  DemoConfiguration copyWith({
    double? borderRadius,
    double? elevation,
    Color? backgroundColor,
    double? minWidth,
    double? maxWidth,
    double? maxHeight,
    PositionPreference? positionPreference,
    MenuAlignment? alignment,
    Offset? offset,
    int? durationMs,
    Curve? curve,
    List<DemoMenuItem>? items,
    OverlayMenuItemStyle? itemStyle,
    OverlayMenuItemStyle? selectedItemStyle,
    OverlayMenuDividerStyle? dividerStyle,
    bool? barrierDismissible,
    Color? barrierColor,
    double? buttonGap,
    double? screenMargin,
  }) {
    return DemoConfiguration(
      borderRadius: borderRadius ?? this.borderRadius,
      elevation: elevation ?? this.elevation,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      minWidth: minWidth ?? this.minWidth,
      maxWidth: maxWidth ?? this.maxWidth,
      maxHeight: maxHeight ?? this.maxHeight,
      positionPreference: positionPreference ?? this.positionPreference,
      alignment: alignment ?? this.alignment,
      offset: offset ?? this.offset,
      durationMs: durationMs ?? this.durationMs,
      curve: curve ?? this.curve,
      items: items ?? this.items,
      itemStyle: itemStyle ?? this.itemStyle,
      selectedItemStyle: selectedItemStyle ?? this.selectedItemStyle,
      dividerStyle: dividerStyle ?? this.dividerStyle,
      barrierDismissible: barrierDismissible ?? this.barrierDismissible,
      barrierColor: barrierColor ?? this.barrierColor,
      buttonGap: buttonGap ?? this.buttonGap,
      screenMargin: screenMargin ?? this.screenMargin,
    );
  }

  /// Get preview summary text
  String get previewSummary {
    final shape = borderRadius > 0 ? 'Rounded(${borderRadius.toInt()}px)' : 'Square';
    final position = positionPreference.toString().split('.').last;
    final align = alignment.toString().split('.').last;
    final duration = '${durationMs}ms';
    final curveName = curve.toString().split('(').first.replaceAll('Cubic', '');
    
    return '$shape • $position • $align • $duration $curveName';
  }

  /// Convert to OverlayMenuStyle
  OverlayMenuStyle toMenuStyle() {
    return OverlayMenuStyle(
      backgroundColor: backgroundColor,
      elevation: elevation,
      borderRadius: BorderRadius.circular(borderRadius),
      border: BorderSide(
        color: Colors.grey.shade300,
        width: 1.0,
      ),
      minWidth: minWidth,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      itemStyle: itemStyle,
      selectedItemStyle: selectedItemStyle,
      dividerStyle: dividerStyle,
    );
  }
}
