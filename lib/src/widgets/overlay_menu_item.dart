import 'package:flutter/material.dart';
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
/// Example with value:
/// ```dart
/// OverlayMenuItem(
///   value: 'edit',
///   leading: Icon(Icons.edit),
///   child: Text('Edit'),
/// )
/// // Menu auto-closes and returns 'edit'
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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled
          ? () {
              if (onTap != null) {
                // Execute custom tap handler
                onTap!();
              } else if (value != null) {
                // Return value and close menu
                Navigator.pop(context, value);
              }
            }
          : null,
      child: Opacity(
        opacity: enabled ? 1.0 : 0.5,
        child: Container(
          height: 48.0,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              if (leading != null) ...[
                leading!,
                const SizedBox(width: 12.0),
              ],
              Expanded(child: child),
              if (trailing != null) ...[
                const SizedBox(width: 12.0),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
