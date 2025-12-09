import 'package:flutter/widgets.dart';
import 'enums.dart';

/// Result of menu position calculation.
///
/// Contains the calculated position, direction, and transform origin
/// for displaying the overlay menu.
class MenuPosition {
  /// Creates a menu position result.
  const MenuPosition({
    required this.offset,
    required this.direction,
    required this.transformOrigin,
    required this.availableHeight,
  });

  /// The calculated position offset for the menu.
  ///
  /// This is the top-left corner of the menu in global coordinates.
  final Offset offset;

  /// The direction the menu was positioned (above or below the anchor).
  final MenuDirection direction;

  /// The transform origin for menu animations.
  ///
  /// This determines the point from which scale animations originate.
  /// Typically [Alignment.topCenter] for menus below, and
  /// [Alignment.bottomCenter] for menus above.
  final Alignment transformOrigin;

  /// The maximum available height for the menu in this position.
  ///
  /// This is the actual space available on screen, considering screen margins.
  /// The menu should constrain its height to this value to avoid overflow.
  final double availableHeight;
}
