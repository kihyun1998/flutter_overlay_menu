import 'package:flutter/material.dart';
import '../models/menu_item_style.dart';
import '../models/menu_style.dart';
import 'overlay_menu_entry.dart';

/// A menu item widget for overlay menus.
///
/// Represents an individual selectable item in an overlay menu.
/// Can include leading/trailing widgets and handle tap events.
///
/// The item behavior depends on the provided parameters:
/// - If [onTap] is provided: executes [onTap] when tapped (menu doesn't auto-close)
/// - If [onTap] is null and [value] is provided: returns [value] and auto-closes menu
///
/// Example with onTap:
/// ```dart
/// OverlayMenuItem(
///   leading: Icon(Icons.edit),
///   child: Text('Edit'),
///   onTap: () {
///     handleEdit();
///     Navigator.pop(context);  // Manual close
///   },
/// )
/// ```
///
/// Example with value and selection:
/// ```dart
/// OverlayMenuItem(
///   value: 'edit',
///   leading: Icon(Icons.edit),
///   child: Text('Edit'),
///   selected: currentValue == 'edit',
/// )
/// ```
///
/// Example with custom style:
/// ```dart
/// OverlayMenuItem(
///   value: 'delete',
///   child: Text('Delete'),
///   itemStyle: OverlayMenuItemStyle(
///     backgroundColor: Colors.red[50],
///     hoverColor: Colors.red[100],
///     textStyle: TextStyle(color: Colors.red),
///   ),
/// )
/// ```
class OverlayMenuItem<T> extends OverlayMenuEntry {
  /// Creates a menu item.
  const OverlayMenuItem({
    Key? key,
    this.value,
    required this.child,
    this.leading,
    this.trailing,
    this.onTap,
    this.enabled = true,
    this.selected = false,
    this.itemStyle,
    this.onItemTap, // Internal callback for closing menu
    this.menuStyle, // Internal: menu-level style
  }) : super(key: key);

  /// The value to return when this item is selected.
  ///
  /// If [onTap] is null, tapping this item will close the menu
  /// and return this value.
  final T? value;

  /// The primary content of the menu item.
  final Widget child;

  /// A widget to display before the [child].
  ///
  /// Typically an [Icon] or [CircleAvatar].
  final Widget? leading;

  /// A widget to display after the [child].
  ///
  /// Typically an [Icon] or keyboard shortcut text.
  final Widget? trailing;

  /// Called when the item is tapped.
  ///
  /// If provided, this takes precedence over the value-based behavior.
  /// The menu will NOT auto-close when [onTap] is provided.
  final VoidCallback? onTap;

  /// Whether this menu item is enabled.
  ///
  /// If false, the item will be displayed with reduced opacity
  /// and will not respond to taps.
  final bool enabled;

  /// Whether this item is currently selected.
  ///
  /// When true and no itemStyle is provided, uses the menu's
  /// selectedItemStyle or built-in selected style.
  final bool selected;

  /// Custom style for this specific item.
  ///
  /// Overrides both itemStyle and selectedItemStyle from OverlayMenuStyle.
  /// Use this for special items (e.g., delete button).
  final OverlayMenuItemStyle? itemStyle;

  /// Internal callback to close the menu with a value.
  /// This is set by OverlayMenu and should not be used directly.
  final void Function(T? value)? onItemTap;

  /// Internal: menu-level style passed from OverlayMenu.
  /// Should not be set by users.
  final OverlayMenuStyle? menuStyle;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = _resolveStyle(context);

    // Build the content (Row with leading/child/trailing)
    Widget content = Row(
      children: [
        if (leading != null) ...[
          leading!,
          SizedBox(width: effectiveStyle.leadingGap),
        ],
        Expanded(child: child),
        if (trailing != null) ...[
          SizedBox(width: effectiveStyle.trailingGap),
          trailing!,
        ],
      ],
    );

    // Apply IconTheme
    if (effectiveStyle.iconColor != null || effectiveStyle.iconSize != null) {
      content = IconTheme(
        data: IconThemeData(
          color: effectiveStyle.iconColor,
          size: effectiveStyle.iconSize,
        ),
        child: content,
      );
    }

    // Apply DefaultTextStyle
    if (effectiveStyle.textStyle != null) {
      content = DefaultTextStyle.merge(
        style: effectiveStyle.textStyle,
        child: content,
      );
    }

    // Wrap with Padding (inside InkWell so interactions cover padding area)
    if (effectiveStyle.padding != null) {
      content = Padding(
        padding: effectiveStyle.padding!,
        child: content,
      );
    }

    // Add height constraint
    if (effectiveStyle.height != null) {
      content = SizedBox(
        height: effectiveStyle.height,
        child: content,
      );
    }

    // Apply opacity for disabled state
    if (!enabled) {
      content = Opacity(opacity: 0.5, child: content);
    }

    // Prepare shape for Material and InkWell
    ShapeBorder? shape;
    if (effectiveStyle.border != null || effectiveStyle.borderRadius != null) {
      shape = RoundedRectangleBorder(
        side: effectiveStyle.border != null
            ? (effectiveStyle.border as Border).top // Use border if available
            : BorderSide.none,
        borderRadius: effectiveStyle.borderRadius ?? BorderRadius.zero,
      );
    }

    // Wrap with Material for background, elevation, and shape
    // Material must be outside InkWell for proper ripple clipping
    content = Material(
      color: effectiveStyle.backgroundColor ?? Colors.transparent,
      elevation: effectiveStyle.elevation ?? 0.0,
      shadowColor: effectiveStyle.shadowColor,
      shape: shape,
      type: MaterialType.card,
      child: InkWell(
        onTap: enabled ? _handleTap : null,
        hoverColor: effectiveStyle.hoverColor,
        splashColor: effectiveStyle.splashColor,
        highlightColor: effectiveStyle.highlightColor,
        customBorder: shape,
        child: content,
      ),
    );

    // Wrap with Container for margin only
    if (effectiveStyle.margin != null) {
      content = Container(
        margin: effectiveStyle.margin,
        child: content,
      );
    }

    return content;
  }

  /// Resolves the effective style based on priority:
  /// 1. itemStyle (this widget)
  /// 2. selectedItemStyle or itemStyle (from menuStyle)
  /// 3. Default styles
  OverlayMenuItemStyle _resolveStyle(BuildContext context) {
    // 1. Individual item style takes priority
    if (itemStyle != null) {
      return _mergeWithDefaults(context, itemStyle!);
    }

    // 2. Menu's selected/normal style
    if (selected && menuStyle?.selectedItemStyle != null) {
      return _mergeWithDefaults(context, menuStyle!.selectedItemStyle!);
    }
    if (menuStyle?.itemStyle != null) {
      return _mergeWithDefaults(context, menuStyle!.itemStyle!);
    }

    // 3. Default styles
    return selected
        ? OverlayMenuItemStyle.defaultSelected(context)
        : OverlayMenuItemStyle.defaultNormal(context);
  }

  /// Merges the provided style with defaults.
  OverlayMenuItemStyle _mergeWithDefaults(
    BuildContext context,
    OverlayMenuItemStyle style,
  ) {
    final defaults = selected
        ? OverlayMenuItemStyle.defaultSelected(context)
        : OverlayMenuItemStyle.defaultNormal(context);
    return defaults.merge(style);
  }

  void _handleTap() {
    if (onTap != null) {
      // Execute custom tap handler - menu doesn't auto-close
      onTap!();
    } else if (value != null) {
      // Use callback instead of Navigator.pop
      onItemTap?.call(value);
    }
  }
}
