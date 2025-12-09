import 'dart:ui';
import '../models/menu_style.dart';
import '../widgets/overlay_menu_entry.dart';
import '../widgets/overlay_menu_item.dart';
import '../widgets/overlay_menu_divider.dart';

/// Calculates the estimated size of an overlay menu.
///
/// This class provides utilities to estimate menu dimensions before rendering,
/// which is necessary for accurate positioning calculations.
class MenuSizeCalculator {
  /// Estimates the size of a menu based on its items and style.
  ///
  /// The width is determined by:
  /// 1. If [style.width] is specified, use it
  /// 2. Otherwise, use [anchorWidth]
  /// 3. Apply [style.minWidth] and [style.maxWidth] constraints
  ///
  /// The height is calculated by:
  /// 1. Sum up all item heights (48.0 for menu items, custom for dividers)
  /// 2. Add padding
  /// 3. Constrain to [style.maxHeight]
  ///
  /// Parameters:
  /// - [items]: List of menu entries to calculate size for
  /// - [anchorWidth]: Width of the anchor widget
  /// - [style]: Style configuration for the menu
  ///
  /// Returns: Estimated [Size] of the menu
  static Size estimateSize({
    required List<OverlayMenuEntry> items,
    required double anchorWidth,
    required OverlayMenuStyle? style,
  }) {
    // Calculate width
    double width;

    if (style?.width != null) {
      // Explicit width takes precedence
      width = style!.width!;
    } else {
      // Start with anchor width
      width = anchorWidth;

      // Apply minWidth constraint first (most important for preventing overflow)
      final minWidth = style?.minWidth ?? 180.0; // Default minWidth
      if (width < minWidth) {
        width = minWidth;
      }

      // Then apply maxWidth constraint
      if (style?.maxWidth != null && width > style!.maxWidth!) {
        width = style.maxWidth!;
      }
    }

    // Calculate height
    const double defaultItemHeight = 48.0;
    double totalHeight = 0.0;

    for (final item in items) {
      if (item is OverlayMenuItem) {
        totalHeight += defaultItemHeight;
      } else if (item is OverlayMenuDivider) {
        totalHeight += item.height;
      } else {
        // Unknown item type, use default height
        totalHeight += defaultItemHeight;
      }
    }

    // Add padding
    final padding = style?.padding;
    if (padding != null) {
      // For EdgeInsets, we need to calculate vertical padding
      // Since padding is EdgeInsetsGeometry, we resolve it with a default TextDirection
      final resolvedPadding = padding.resolve(TextDirection.ltr);
      totalHeight += resolvedPadding.top + resolvedPadding.bottom;
    }

    // Apply maxHeight constraint
    final maxHeight = style?.maxHeight ?? 300.0;
    if (totalHeight > maxHeight) {
      totalHeight = maxHeight;
    }

    return Size(width, totalHeight);
  }
}
