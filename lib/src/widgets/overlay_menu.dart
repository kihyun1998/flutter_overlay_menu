import 'package:flutter/material.dart';

import '../models/menu_style.dart';
import 'overlay_menu_divider.dart';
import 'overlay_menu_entry.dart';
import 'overlay_menu_item.dart';

/// A widget that displays a menu with a list of items.
///
/// This is the content widget used within overlay menus.
/// It handles rendering menu items, scrolling, and styling.
///
/// Example:
/// ```dart
/// OverlayMenu(
///   items: [
///     OverlayMenuItem(value: 'edit', child: Text('Edit')),
///     OverlayMenuDivider(),
///     OverlayMenuItem(value: 'delete', child: Text('Delete')),
///   ],
///   style: OverlayMenuStyle(
///     backgroundColor: Colors.white,
///     elevation: 8,
///   ),
/// )
/// ```
class OverlayMenu<T> extends StatelessWidget {
  /// Creates an overlay menu with a list of items.
  const OverlayMenu({
    super.key,
    required this.items,
    this.onItemSelected,
    this.style,
  }) : child = null;

  /// Creates an overlay menu with custom content.
  ///
  /// This constructor allows complete customization of the menu content
  /// instead of using a list of items.
  ///
  /// Example:
  /// ```dart
  /// OverlayMenu.custom(
  ///   child: ColorPicker(
  ///     onColorSelected: (color) {
  ///       Navigator.pop(context, color);
  ///     },
  ///   ),
  /// )
  /// ```
  const OverlayMenu.custom({
    super.key,
    required Widget this.child,
    this.style,
  })  : items = const [],
        onItemSelected = null;

  /// The list of menu entries to display.
  final List<OverlayMenuEntry> items;

  /// Custom child widget (for custom constructor).
  final Widget? child;

  /// Called when an item with a value is selected.
  ///
  /// This is only called for items without [onTap] callbacks.
  final void Function(T value)? onItemSelected;

  /// Style configuration for the menu.
  final OverlayMenuStyle? style;

  /// Creates the default style based on the theme.
  OverlayMenuStyle _defaultStyle(BuildContext context) {
    return OverlayMenuStyle(
      backgroundColor: Theme.of(context).cardColor,
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      minWidth: 180.0, // Default minimum width for proper content display
      maxHeight: 300.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? _defaultStyle(context);

    // Extract border radius from shape
    BorderRadius? borderRadius;
    if (effectiveStyle.shape is RoundedRectangleBorder) {
      final shape = effectiveStyle.shape as RoundedRectangleBorder;
      if (shape.borderRadius is BorderRadius) {
        borderRadius = shape.borderRadius as BorderRadius;
      }
    }

    Widget content;

    if (child != null) {
      // Custom content
      content = child!;
    } else {
      // Build from items list
      // Inject onItemTap callback and menuStyle into each OverlayMenuItem
      // Only recreate items if they need modification
      final processedItems = <Widget>[];
      
      for (final item in items) {
        if (item is OverlayMenuItem<T>) {
          // Only create a new item if we need to inject callbacks/styles
          // Most items will need this, so we recreate
          processedItems.add(
            OverlayMenuItem<T>(
              key: item.key,
              value: item.value,
              leading: item.leading,
              trailing: item.trailing,
              onTap: item.onTap,
              enabled: item.enabled,
              selected: item.selected,
              itemStyle: item.itemStyle,
              onItemTap: (value) {
                // Call the onItemSelected callback which showOverlayMenu will wrap with closeMenu
                onItemSelected?.call(value as T);
              },
              menuStyle: effectiveStyle, // Pass menu style for inheritance
              child: item.child,
            ),
          );
        } else if (item is OverlayMenuDivider) {
          // Only recreate if divider style needs to be injected
          if (effectiveStyle.dividerStyle != null && item.menuDividerStyle == null) {
            processedItems.add(
              OverlayMenuDivider(
                key: item.key,
                style: item.style,
                menuDividerStyle: effectiveStyle.dividerStyle,
              ),
            );
          } else {
            // Can reuse the original divider
            processedItems.add(item);
          }
        } else {
          // Unknown item type, add as-is
          processedItems.add(item);
        }
      }

      content = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: processedItems,
      );

      // Add padding if specified
      if (effectiveStyle.padding != null) {
        content = Padding(
          padding: effectiveStyle.padding!,
          child: content,
        );
      }

      // Make scrollable if needed
      content = ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: effectiveStyle.maxHeight,
        ),
        child: ScrollbarTheme(
          data: effectiveStyle.scrollbarTheme ?? ScrollbarThemeData(
            thumbVisibility: MaterialStateProperty.all(false),
            thickness: MaterialStateProperty.all(6.0),
            radius: const Radius.circular(3.0),
          ),
          child: Scrollbar(
            child: SingleChildScrollView(
              child: content,
            ),
          ),
        ),
      );
    }

    // Apply size constraints
    content = ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: effectiveStyle.minWidth ?? 0,
        maxWidth: effectiveStyle.maxWidth ?? double.infinity,
      ),
      child: content,
    );

    // Apply clipping if border radius is present
    // Material widget (when used with showOverlayMenu) handles all visual styling:
    // backgroundColor, elevation, shape (borderRadius + border)
    // This widget only needs to clip the content to match the shape
    if (borderRadius != null) {
      content = ClipRRect(
        borderRadius: borderRadius,
        child: content,
      );
    }

    return content;
  }
}
