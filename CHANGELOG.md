# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0]

### Added

#### Core Functions
- `showOverlayMenu()` function for displaying overlay menus with type-safe generics
- Smart positioning system with automatic direction selection (above/below)
- Horizontal alignment options (start, center, end)
- Custom offset support for fine-tuned positioning
- Barrier tap handling with configurable dismissal behavior

#### Widgets
- `OverlayMenu` - Main menu container with scrolling support
- `OverlayMenuItem<T>` - Individual menu items with type-safe value handling
- `OverlayMenuDivider` - Customizable menu divider
- `OverlayMenuEntry` - Base class for menu entries

#### Menu Styling
- `OverlayMenuStyle` with comprehensive configuration:
  - Size constraints (width, minWidth, maxWidth, maxHeight)
  - Background color and shadow color
  - Elevation control
  - Border radius with proper clipping
  - Custom border styling
  - Internal padding (vertical and horizontal)
  - Scrollbar theme support

#### Item Styling
- `OverlayMenuItemStyle` with full customization:
  - Layout: height, padding (horizontal/vertical), margin
  - Colors: backgroundColor, hoverColor, splashColor, highlightColor
  - Border: custom border and borderRadius
  - Content: textStyle, iconColor, iconSize
  - Spacing: leadingGap, trailingGap
  - Effects: elevation, shadowColor
- Selected item state with dedicated styling (`selectedItemStyle`)
- Per-item style override support

#### Divider Styling
- `OverlayMenuDividerStyle` with options:
  - Height and thickness control
  - Custom color
  - Left and right indents

#### Menu Items Features
- Leading and trailing widget support
- Selected state indication
- Enabled/disabled state with visual feedback
- Two interaction modes:
  - Value-based (auto-close on selection)
  - Callback-based (custom tap handling)

#### Animation System
- Customizable transition duration
- Configurable animation curves
- Scale and fade combined animations
- Transform origin based on menu position

#### Scrollbar Support
- Automatic scrolling when content exceeds maxHeight
- Fully customizable scrollbar theme:
  - Visibility control (always visible or on-demand)
  - Thickness and radius
  - Thumb color and track color
  - Track border color and visibility

#### Developer Experience
- Type-safe API with generic support
- Material Design compliance
- Theme-aware defaults
- Automatic screen boundary detection
- Content clipping for border radius
- Hot reload support

#### Example App
- Comprehensive demo application
- 8 preset configurations:
  - Material Design
  - iOS Style
  - Dark Mode
  - Minimal
  - Colorful
  - Styled Items
  - Selected Item
  - Custom Styles
- Interactive customization panel with real-time preview
- All styling options controllable via UI

### Technical Details

#### Architecture
- Clean separation: Functions, Widgets, Models, Core
- Position calculation separated from rendering
- Size estimation for optimal positioning
- Overlay-based implementation for maximum flexibility

#### Performance
- Lazy menu building
- Efficient scroll controller management
- Optimized rebuild behavior
- Cached position calculations

### Notes

This is the initial release of flutter_overlay_menu, providing a complete foundation for overlay menus with extensive customization options. The API follows Flutter's standard patterns (similar to `showDialog`, `showMenu`) for familiar developer experience.

## [Unreleased]

### Planned Features
- Additional animation types (slide, spring, custom)
- Left/right positioning support
- Keyboard navigation
- Nested menus (submenus)
- Convenience widgets (OverlayMenuButton, OverlayMenuRegion)
- Accessibility improvements

[0.1.0]: https://github.com/kihyun1998/flutter_overlay_menu/releases/tag/v0.1.0
