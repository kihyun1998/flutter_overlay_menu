import 'package:flutter/widgets.dart';
import '../models/enums.dart';
import '../models/menu_position.dart';

/// Calculates the optimal position for an overlay menu.
///
/// This class handles smart positioning logic, including:
/// - Automatic direction selection based on available space
/// - Horizontal alignment (start, center, end)
/// - Screen boundary checking and adjustment
class MenuPositioner {
  /// Calculates the optimal position for the menu.
  ///
  /// Parameters:
  /// - [context]: Build context for screen size calculation
  /// - [anchorBox]: RenderBox of the anchor widget
  /// - [menuSize]: Estimated size of the menu
  /// - [preference]: Preferred position (auto, below, or above)
  /// - [alignment]: Horizontal alignment (start, center, or end)
  /// - [buttonGap]: Gap between anchor and menu (default: 4.0)
  /// - [screenMargin]: Margin from screen edges (default: 8.0)
  /// - [additionalOffset]: Additional offset to apply
  ///
  /// Returns: [MenuPosition] with calculated offset, direction, and transform origin
  static MenuPosition calculatePosition({
    required BuildContext context,
    required RenderBox anchorBox,
    required Size menuSize,
    required PositionPreference preference,
    required MenuAlignment alignment,
    required double buttonGap,
    required double screenMargin,
    Offset additionalOffset = Offset.zero,
  }) {
    final screenSize = MediaQuery.of(context).size;
    final anchorOffset = anchorBox.localToGlobal(Offset.zero);
    final anchorSize = anchorBox.size;

    // Determine direction (above or below)
    final direction = _determineDirection(
      preference: preference,
      anchorY: anchorOffset.dy,
      anchorHeight: anchorSize.height,
      menuHeight: menuSize.height,
      screenHeight: screenSize.height,
      screenMargin: screenMargin,
    );

    // Calculate horizontal position
    final left = _calculateHorizontalPosition(
      anchorX: anchorOffset.dx,
      anchorWidth: anchorSize.width,
      menuWidth: menuSize.width,
      alignment: alignment,
      screenWidth: screenSize.width,
      screenMargin: screenMargin,
    );

    // Calculate vertical position
    final top = direction == MenuDirection.below
        ? anchorOffset.dy + anchorSize.height + buttonGap
        : anchorOffset.dy - menuSize.height - buttonGap;

    // Apply additional offset
    final finalOffset = Offset(left, top) + additionalOffset;

    // Determine transform origin for animations
    final transformOrigin = direction == MenuDirection.below
        ? Alignment.topCenter
        : Alignment.bottomCenter;

    // Calculate available height for the menu
    final availableHeight = direction == MenuDirection.below
        ? screenSize.height -
            (anchorOffset.dy + anchorSize.height + buttonGap) -
            screenMargin
        : anchorOffset.dy - buttonGap - screenMargin;

    return MenuPosition(
      offset: finalOffset,
      direction: direction,
      transformOrigin: transformOrigin,
      availableHeight: availableHeight,
    );
  }

  /// Determines whether the menu should appear above or below the anchor.
  static MenuDirection _determineDirection({
    required PositionPreference preference,
    required double anchorY,
    required double anchorHeight,
    required double menuHeight,
    required double screenHeight,
    required double screenMargin,
  }) {
    switch (preference) {
      case PositionPreference.below:
        return MenuDirection.below;

      case PositionPreference.above:
        return MenuDirection.above;

      case PositionPreference.auto:
        // Calculate available space
        final spaceAbove = anchorY - screenMargin;
        final spaceBelow =
            screenHeight - (anchorY + anchorHeight) - screenMargin;

        // Prefer below if there's enough space
        if (spaceBelow >= menuHeight) {
          return MenuDirection.below;
        }

        // Otherwise use above if there's enough space
        if (spaceAbove >= menuHeight) {
          return MenuDirection.above;
        }

        // If neither has enough space, choose the larger one
        return spaceBelow > spaceAbove
            ? MenuDirection.below
            : MenuDirection.above;
    }
  }

  /// Calculates the horizontal (left) position for the menu.
  static double _calculateHorizontalPosition({
    required double anchorX,
    required double anchorWidth,
    required double menuWidth,
    required MenuAlignment alignment,
    required double screenWidth,
    required double screenMargin,
  }) {
    // Calculate initial left position based on alignment
    double left;

    switch (alignment) {
      case MenuAlignment.start:
        // Left edges align
        left = anchorX;
        break;

      case MenuAlignment.center:
        // Center menu over anchor
        left = anchorX + (anchorWidth - menuWidth) / 2;
        break;

      case MenuAlignment.end:
        // Right edges align
        left = anchorX + anchorWidth - menuWidth;
        break;
    }

    // Ensure menu stays within screen bounds
    // Check right edge
    if (left + menuWidth > screenWidth - screenMargin) {
      left = screenWidth - screenMargin - menuWidth;
    }

    // Check left edge
    if (left < screenMargin) {
      left = screenMargin;
    }

    return left;
  }
}
