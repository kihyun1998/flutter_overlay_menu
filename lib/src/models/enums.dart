/// Position preference for the overlay menu.
///
/// Determines whether the menu should appear above or below the anchor widget.
enum PositionPreference {
  /// Automatically choose the best position based on available space.
  ///
  /// The menu will appear below if there's enough space, otherwise above.
  auto,

  /// Always display the menu below the anchor widget.
  below,

  /// Always display the menu above the anchor widget.
  above,
}

/// Alignment of the menu relative to the anchor widget.
///
/// This determines how the menu is horizontally aligned with the anchor.
enum MenuAlignment {
  /// Align the left edge of the menu with the left edge of the anchor.
  start,

  /// Center the menu over the anchor widget.
  center,

  /// Align the right edge of the menu with the right edge of the anchor.
  end,
}

/// Internal direction the menu was positioned.
///
/// This is calculated during positioning and is not directly specified by the user.
enum MenuDirection {
  /// Menu is positioned above the anchor.
  above,

  /// Menu is positioned below the anchor.
  below,
}
