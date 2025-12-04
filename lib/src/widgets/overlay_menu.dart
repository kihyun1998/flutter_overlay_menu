import 'package:flutter/material.dart';
import '../models/menu_style.dart';
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
    Key? key,
    required this.items,
    this.onItemSelected,
    this.style,
  })  : child = null,
        super(key: key);

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
    Key? key,
    required Widget this.child,
    this.style,
  })  : items = const [],
        onItemSelected = null,
        super(key: key);

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
      // Inject onItemTap callback into each OverlayMenuItem
      final processedItems = items.map((item) {
        if (item is OverlayMenuItem<T>) {
          // Create a new OverlayMenuItem with onItemTap callback
          return OverlayMenuItem<T>(
            key: item.key,
            value: item.value,
            leading: item.leading,
            trailing: item.trailing,
            onTap: item.onTap,
            enabled: item.enabled,
            onItemTap: (value) {
              // Call the onItemSelected callback which showOverlayMenu will wrap with closeMenu
              onItemSelected?.call(value as T);
            },
            child: item.child,
          );
        }
        return item;
      }).toList();

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
        child: SingleChildScrollView(
          child: content,
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

    // Apply decoration
    content = Container(
      decoration: BoxDecoration(
        color: effectiveStyle.backgroundColor,
        borderRadius: borderRadius,
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 1.0,
        ),
      ),
      child: borderRadius != null
          ? ClipRRect(
              borderRadius: borderRadius,
              child: content,
            )
          : content,
    );

    return content;
  }
}
