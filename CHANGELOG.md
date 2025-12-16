# Changelog

## 0.1.1

### Added

- **Pinned Button**: Fixed action button that appears at top/bottom of menu based on opening direction
  - `pinnedButton` parameter in `showOverlayMenu()`
  - `pinnedButtonHeight` and `showPinnedButtonDivider` in `OverlayMenuStyle`
  - Direction-aware positioning (top when menu opens below, bottom when opens above)
  - Development-mode assertion to ensure height is specified
- **Empty State**: Custom widget display when menu has no items
  - `emptyWidget` parameter in `showOverlayMenu()` and `OverlayMenu`
- **Example App**: Added "Pinned Button" preset to showcase the new feature

### Documentation

- Updated README with pinned button and empty state examples
- Added usage warnings for pinned button height requirements

## 0.1.0

Initial release of `flutter_overlay_menu`.

### Features

- **Core API**: `showOverlayMenu()` with type-safe generics and smart positioning
- **Widgets**: `OverlayMenu`, `OverlayMenuItem<T>`, `OverlayMenuDivider`
- **Comprehensive Styling**:
  - Menu: size constraints, colors, elevation, border, padding, scrollbar theme
  - Items: layout, colors (hover/splash/highlight), border, text/icon styling, selected state
  - Divider: height, thickness, color, indents
- **Positioning**: Auto direction (above/below), horizontal alignment (start/center/end), custom offset
- **Animation**: Customizable duration, curves, scale & fade transitions
- **Item Features**: Leading/trailing widgets, enabled/disabled states, value or callback modes
- **Scrollbar**: Auto-scroll when needed, fully customizable theme
- **Developer Experience**: Type-safe API, Material Design compliance, theme-aware defaults
- **Example App**: Interactive playground with 8 presets
