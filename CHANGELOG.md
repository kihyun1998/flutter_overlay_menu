# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2025-12-04

### Added
- Initial release of flutter_overlay_menu
- `showOverlayMenu()` function for displaying overlay menus
- `OverlayMenu` widget for menu container
- `OverlayMenuItem` widget for individual menu items
- `OverlayMenuDivider` widget for menu dividers
- Smart positioning with automatic direction selection (above/below)
- Horizontal alignment options (start, center, end)
- Customizable animations (scale + fade)
- Material Design styling with theme support
- Size constraints (width, minWidth, maxWidth, maxHeight)
- Customizable elevation, shadows, and border radius
- Support for both value-based and onTap-based item selection
- Barrier dismissal on outside tap
- Leading and trailing widgets for menu items
- Enabled/disabled state for menu items
- Example app with 5 different usage scenarios

### Features
- Function-based API following Flutter standard pattern
- Automatic screen boundary detection and adjustment
- Customizable animation duration and curves
- Support for custom menu content
- Full TypeScript-like type safety with generics

## [Unreleased]

### Planned for Future Releases
- Phase 2: Additional animation types (slide, spring, etc.)
- Phase 2: Left/right positioning
- Phase 2: Scrollbar theme customization
- Phase 3: Convenience widgets (OverlayMenuButton, OverlayMenuRegion)
- Phase 4: Keyboard navigation support
- Phase 5: Nested menus (submenus)

[0.1.0]: https://github.com/kihyun1998/flutter_overlay_menu/releases/tag/v0.1.0
