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
  // Menu Style
  final double borderRadius;
  final double elevation;
  final Color backgroundColor;
  final Color? shadowColor;
  final double minWidth;
  final double? maxWidth;
  final double? minHeight; // Added minHeight for Empty State demo
  final double maxHeight;
  final double menuPaddingVertical;
  final double menuPaddingHorizontal;

  // Item Style
  final double itemHeight;
  final double itemPaddingHorizontal;
  final double itemPaddingVertical;
  final double itemMargin;
  final Color? itemBackgroundColor;
  final Color? itemHoverColor;
  final Color? itemSplashColor;
  final Color? itemHighlightColor;
  final double itemBorderRadius;
  final double itemTextSize;
  final double itemIconSize;
  final Color? itemIconColor;
  final double itemLeadingGap;
  final double itemTrailingGap;

  // Selected Item Style
  final Color? selectedItemBackgroundColor;
  final Color? selectedItemHoverColor;
  final Color? selectedItemTextColor;
  final Color? selectedItemIconColor;

  // Divider Style
  final OverlayMenuDividerStyle? dividerStyle;

  // Position
  final PositionPreference positionPreference;
  final MenuAlignment alignment;
  final Offset offset;

  // Animation
  final int durationMs;
  final Curve curve;

  // Items
  final List<DemoMenuItem> items;

  // Scrollbar Theme
  final double scrollbarThickness;
  final Color scrollbarColor;
  final bool scrollbarAlwaysVisible;
  final double scrollbarRadius;
  final Color? scrollbarTrackColor;
  final Color? scrollbarTrackBorderColor;
  final bool scrollbarTrackVisible;

  // Advanced
  final bool barrierDismissible;
  final Color barrierColor;
  final double buttonGap;
  final double screenMargin;

  // Pinned Button
  final bool showPinnedButton;
  final double pinnedButtonHeight;

  const DemoConfiguration({
    // Menu Style
    this.borderRadius = 8.0,
    this.elevation = 8.0,
    this.backgroundColor = Colors.white,
    this.shadowColor,
    this.minWidth = 180.0,
    this.maxWidth,
    this.minHeight, // Default null
    this.maxHeight = 300.0,
    this.menuPaddingVertical = 8.0,
    this.menuPaddingHorizontal = 0.0,
    // Item Style
    this.itemHeight = 48.0,
    this.itemPaddingHorizontal = 16.0,
    this.itemPaddingVertical = 0.0,
    this.itemMargin = 0.0,
    this.itemBackgroundColor,
    this.itemHoverColor,
    this.itemSplashColor,
    this.itemHighlightColor,
    this.itemBorderRadius = 0.0,
    this.itemTextSize = 14.0,
    this.itemIconSize = 24.0,
    this.itemIconColor,
    this.itemLeadingGap = 12.0,
    this.itemTrailingGap = 12.0,
    // Selected Item Style
    this.selectedItemBackgroundColor,
    this.selectedItemHoverColor,
    this.selectedItemTextColor,
    this.selectedItemIconColor,
    // Divider Style
    this.dividerStyle,
    // Position
    this.positionPreference = PositionPreference.auto,
    this.alignment = MenuAlignment.start,
    this.offset = Offset.zero,
    // Animation
    this.durationMs = 200,
    this.curve = Curves.easeOutCubic,
    // Items
    required this.items,
    // Scrollbar Theme
    this.scrollbarThickness = 6.0,
    this.scrollbarColor = Colors.grey,
    this.scrollbarAlwaysVisible = false,
    this.scrollbarRadius = 3.0,
    this.scrollbarTrackColor,
    this.scrollbarTrackBorderColor,
    this.scrollbarTrackVisible = false,
    // Advanced
    this.barrierDismissible = true,
    this.barrierColor = Colors.transparent,
    this.buttonGap = 4.0,
    this.screenMargin = 8.0,
    // Pinned Button
    this.showPinnedButton = false,
    this.pinnedButtonHeight = 52.0,
  });

  DemoConfiguration copyWith({
    double? borderRadius,
    double? elevation,
    Color? backgroundColor,
    Color? shadowColor,
    double? minWidth,
    double? maxWidth,
    double? minHeight,
    double? maxHeight,
    double? menuPaddingVertical,
    double? menuPaddingHorizontal,
    double? itemHeight,
    double? itemPaddingHorizontal,
    double? itemPaddingVertical,
    double? itemMargin,
    Color? itemBackgroundColor,
    Color? itemHoverColor,
    Color? itemSplashColor,
    Color? itemHighlightColor,
    double? itemBorderRadius,
    double? itemTextSize,
    double? itemIconSize,
    Color? itemIconColor,
    double? itemLeadingGap,
    double? itemTrailingGap,
    Color? selectedItemBackgroundColor,
    Color? selectedItemHoverColor,
    Color? selectedItemTextColor,
    Color? selectedItemIconColor,
    OverlayMenuDividerStyle? dividerStyle,
    PositionPreference? positionPreference,
    MenuAlignment? alignment,
    Offset? offset,
    int? durationMs,
    Curve? curve,
    List<DemoMenuItem>? items,
    double? scrollbarThickness,
    Color? scrollbarColor,
    bool? scrollbarAlwaysVisible,
    double? scrollbarRadius,
    Color? scrollbarTrackColor,
    Color? scrollbarTrackBorderColor,
    bool? scrollbarTrackVisible,
    bool? barrierDismissible,
    Color? barrierColor,
    double? buttonGap,
    double? screenMargin,
    bool? showPinnedButton,
    double? pinnedButtonHeight,
  }) {
    return DemoConfiguration(
      borderRadius: borderRadius ?? this.borderRadius,
      elevation: elevation ?? this.elevation,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      shadowColor: shadowColor ?? this.shadowColor,
      minWidth: minWidth ?? this.minWidth,
      maxWidth: maxWidth ?? this.maxWidth,
      minHeight: minHeight ?? this.minHeight,
      maxHeight: maxHeight ?? this.maxHeight,
      menuPaddingVertical: menuPaddingVertical ?? this.menuPaddingVertical,
      menuPaddingHorizontal:
          menuPaddingHorizontal ?? this.menuPaddingHorizontal,
      itemHeight: itemHeight ?? this.itemHeight,
      itemPaddingHorizontal:
          itemPaddingHorizontal ?? this.itemPaddingHorizontal,
      itemPaddingVertical: itemPaddingVertical ?? this.itemPaddingVertical,
      itemMargin: itemMargin ?? this.itemMargin,
      itemBackgroundColor: itemBackgroundColor ?? this.itemBackgroundColor,
      itemHoverColor: itemHoverColor ?? this.itemHoverColor,
      itemSplashColor: itemSplashColor ?? this.itemSplashColor,
      itemHighlightColor: itemHighlightColor ?? this.itemHighlightColor,
      itemBorderRadius: itemBorderRadius ?? this.itemBorderRadius,
      itemTextSize: itemTextSize ?? this.itemTextSize,
      itemIconSize: itemIconSize ?? this.itemIconSize,
      itemIconColor: itemIconColor ?? this.itemIconColor,
      itemLeadingGap: itemLeadingGap ?? this.itemLeadingGap,
      itemTrailingGap: itemTrailingGap ?? this.itemTrailingGap,
      selectedItemBackgroundColor:
          selectedItemBackgroundColor ?? this.selectedItemBackgroundColor,
      selectedItemHoverColor:
          selectedItemHoverColor ?? this.selectedItemHoverColor,
      selectedItemTextColor:
          selectedItemTextColor ?? this.selectedItemTextColor,
      selectedItemIconColor:
          selectedItemIconColor ?? this.selectedItemIconColor,
      dividerStyle: dividerStyle ?? this.dividerStyle,
      positionPreference: positionPreference ?? this.positionPreference,
      alignment: alignment ?? this.alignment,
      offset: offset ?? this.offset,
      durationMs: durationMs ?? this.durationMs,
      curve: curve ?? this.curve,
      items: items ?? this.items,
      scrollbarThickness: scrollbarThickness ?? this.scrollbarThickness,
      scrollbarColor: scrollbarColor ?? this.scrollbarColor,
      scrollbarAlwaysVisible:
          scrollbarAlwaysVisible ?? this.scrollbarAlwaysVisible,
      scrollbarRadius: scrollbarRadius ?? this.scrollbarRadius,
      scrollbarTrackColor: scrollbarTrackColor ?? this.scrollbarTrackColor,
      scrollbarTrackBorderColor:
          scrollbarTrackBorderColor ?? this.scrollbarTrackBorderColor,
      scrollbarTrackVisible:
          scrollbarTrackVisible ?? this.scrollbarTrackVisible,
      barrierDismissible: barrierDismissible ?? this.barrierDismissible,
      barrierColor: barrierColor ?? this.barrierColor,
      buttonGap: buttonGap ?? this.buttonGap,
      screenMargin: screenMargin ?? this.screenMargin,
      showPinnedButton: showPinnedButton ?? this.showPinnedButton,
      pinnedButtonHeight: pinnedButtonHeight ?? this.pinnedButtonHeight,
    );
  }

  /// Get preview summary text
  String get previewSummary {
    final shape =
        borderRadius > 0 ? 'Rounded(${borderRadius.toInt()}px)' : 'Square';
    final position = positionPreference.toString().split('.').last;
    final align = alignment.toString().split('.').last;
    final duration = '${durationMs}ms';
    final curveName = curve.toString().split('(').first.replaceAll('Cubic', '');

    return '$shape • $position • $align • $duration $curveName';
  }

  /// Convert to OverlayMenuStyle
  OverlayMenuStyle toMenuStyle(BuildContext context) {
    final theme = Theme.of(context);

    // Build item style
    final itemStyle = OverlayMenuItemStyle(
      height: itemHeight,
      padding: EdgeInsets.symmetric(
        horizontal: itemPaddingHorizontal,
        vertical: itemPaddingVertical,
      ),
      margin: EdgeInsets.all(itemMargin),
      backgroundColor: itemBackgroundColor,
      hoverColor: itemHoverColor ?? theme.hoverColor,
      splashColor: itemSplashColor ?? theme.splashColor,
      highlightColor: itemHighlightColor ?? theme.highlightColor,
      borderRadius: BorderRadius.circular(itemBorderRadius),
      textStyle: TextStyle(fontSize: itemTextSize),
      iconColor: itemIconColor,
      iconSize: itemIconSize,
      leadingGap: itemLeadingGap,
      trailingGap: itemTrailingGap,
    );

    // Build selected item style
    final primaryColor = theme.colorScheme.primary;
    final selectedItemStyle = OverlayMenuItemStyle(
      height: itemHeight,
      padding: EdgeInsets.symmetric(
        horizontal: itemPaddingHorizontal,
        vertical: itemPaddingVertical,
      ),
      margin: EdgeInsets.all(itemMargin),
      backgroundColor:
          selectedItemBackgroundColor ?? primaryColor.withValues(alpha: 0.08),
      hoverColor:
          selectedItemHoverColor ?? primaryColor.withValues(alpha: 0.12),
      splashColor: itemSplashColor ?? primaryColor.withValues(alpha: 0.16),
      highlightColor:
          itemHighlightColor ?? primaryColor.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(itemBorderRadius),
      textStyle: TextStyle(
        fontSize: itemTextSize,
        color: selectedItemTextColor ?? primaryColor,
        fontWeight: FontWeight.w600,
      ),
      iconColor: selectedItemIconColor ?? primaryColor,
      iconSize: itemIconSize,
      leadingGap: itemLeadingGap,
      trailingGap: itemTrailingGap,
    );

    return OverlayMenuStyle(
      backgroundColor: backgroundColor,
      elevation: elevation,
      shadowColor: shadowColor,
      borderRadius: BorderRadius.circular(borderRadius),
      border: BorderSide(
        color: Colors.grey.shade300,
        width: 1.0,
      ),
      minWidth: minWidth,
      maxWidth: maxWidth,
      minHeight: minHeight,
      maxHeight: maxHeight,
      padding: EdgeInsets.symmetric(
        vertical: menuPaddingVertical,
        horizontal: menuPaddingHorizontal,
      ),
      itemStyle: itemStyle,
      selectedItemStyle: selectedItemStyle,
      dividerStyle: dividerStyle,
      scrollbarTheme: ScrollbarThemeData(
        thumbVisibility: WidgetStateProperty.all(scrollbarAlwaysVisible),
        thickness: WidgetStateProperty.all(scrollbarThickness),
        thumbColor: WidgetStateProperty.all(scrollbarColor),
        radius: Radius.circular(scrollbarRadius),
        trackColor: scrollbarTrackColor != null
            ? WidgetStateProperty.all(scrollbarTrackColor)
            : null,
        trackBorderColor: scrollbarTrackBorderColor != null
            ? WidgetStateProperty.all(scrollbarTrackBorderColor)
            : null,
        trackVisibility: WidgetStateProperty.all(scrollbarTrackVisible),
      ),
      pinnedButtonHeight: showPinnedButton ? pinnedButtonHeight : null,
      showPinnedButtonDivider: true,
    );
  }
}
