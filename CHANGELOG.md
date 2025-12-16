# Changelog

## 0.1.0

Initial release of `flutter_overlay_menu` - A flexible overlay menu package for Flutter.

### Features

- **Core API**: `showOverlayMenu()` with type-safe generics and smart positioning
- **Widgets**: `OverlayMenu`, `OverlayMenuItem<T>`, `OverlayMenuDivider`
- **Comprehensive Styling**:
  - Menu: size constraints, colors, elevation, border, padding, scrollbar theme
  - Items: layout, colors (hover/splash/highlight), border, text/icon styling, selected state
  - Divider: height, thickness, color, indents
- **Positioning**: Auto direction (above/below), horizontal alignment (start/center/end), custom offset
- **Animation**: Customizable duration, curves, scale & fade transitions
- **Pinned Button**: Fixed action button at top/bottom of menu (direction-aware positioning)
- **Empty State**: Custom widget display when menu has no items
- **Item Features**: Leading/trailing widgets, enabled/disabled states, value or callback modes
- **Scrollbar**: Auto-scroll when needed, fully customizable theme
- **Developer Experience**: Type-safe API, Material Design compliance, theme-aware defaults
- **Example App**: Interactive playground with 9 presets including pinned button demo
