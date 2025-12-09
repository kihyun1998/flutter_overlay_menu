# Flutter Overlay Menu

A customizable overlay menu package inspired by Flutter's standard patterns (`showDialog`, `showMenu`).

## Features

- 📍 **Smart Positioning** - Auto-detects best position (above/below)
- 🎨 **Fully Customizable** - Control every aspect: colors, sizes, animations
- 🎯 **Selected State** - Built-in support for selected items
- 📜 **Scrollbar Support** - Customizable scrollbar when content overflows
- ⚡ **Smooth Animations** - Scale + fade transitions with custom curves
- 🎭 **Material Design** - Follows Material Design guidelines

## Installation

```yaml
dependencies:
  flutter_overlay_menu: ^0.1.0
```

## Quick Start

```dart
import 'package:flutter_overlay_menu/flutter_overlay_menu.dart';

// 1. Create a GlobalKey for your button
final buttonKey = GlobalKey();

// 2. Show menu on button tap
ElevatedButton(
  key: buttonKey,
  onPressed: () async {
    final result = await showOverlayMenu<String>(
      context: context,
      anchorKey: buttonKey,
      builder: (context) => OverlayMenu(
        items: [
          OverlayMenuItem(value: 'edit', child: Text('Edit')),
          OverlayMenuItem(value: 'delete', child: Text('Delete')),
        ],
      ),
    );
    
    if (result == 'edit') {
      // Handle edit
    }
  },
  child: Text('Show Menu'),
)
```

## Basic Usage

### Simple Menu

```dart
showOverlayMenu<String>(
  context: context,
  anchorKey: buttonKey,
  builder: (context) => OverlayMenu(
    items: [
      OverlayMenuItem(value: 'copy', child: Text('Copy')),
      OverlayMenuItem(value: 'paste', child: Text('Paste')),
      OverlayMenuDivider(),
      OverlayMenuItem(value: 'delete', child: Text('Delete')),
    ],
  ),
)
```

### Menu with Icons

```dart
OverlayMenu(
  items: [
    OverlayMenuItem(
      value: 'edit',
      leading: Icon(Icons.edit),
      trailing: Text('Ctrl+E'),
      child: Text('Edit'),
    ),
    OverlayMenuItem(
      value: 'share',
      leading: Icon(Icons.share),
      child: Text('Share'),
    ),
  ],
)
```

### Menu with Selection

```dart
OverlayMenu(
  items: [
    OverlayMenuItem(
      value: 'small',
      selected: currentSize == 'small',
      child: Text('Small'),
    ),
    OverlayMenuItem(
      value: 'medium',
      selected: currentSize == 'medium',
      child: Text('Medium'),
    ),
    OverlayMenuItem(
      value: 'large',
      selected: currentSize == 'large',
      child: Text('Large'),
    ),
  ],
)
```

### Custom Tap Handler

If you need custom behavior instead of returning a value:

```dart
OverlayMenuItem(
  leading: Icon(Icons.settings),
  child: Text('Settings'),
  onTap: () {
    openSettings();
    Navigator.pop(context);  // Manual close
  },
)
```

## Customization

### Menu Style

```dart
showOverlayMenu(
  context: context,
  anchorKey: buttonKey,
  style: OverlayMenuStyle(
    backgroundColor: Colors.grey[900],
    elevation: 12,
    borderRadius: BorderRadius.circular(16),
    padding: EdgeInsets.symmetric(vertical: 8),
    minWidth: 200,
    maxHeight: 400,
  ),
  builder: (context) => OverlayMenu(...),
)
```

### Item Style

```dart
OverlayMenuStyle(
  itemStyle: OverlayMenuItemStyle(
    height: 48,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    backgroundColor: Colors.transparent,
    hoverColor: Colors.blue.withOpacity(0.1),
    borderRadius: BorderRadius.circular(8),
    textStyle: TextStyle(fontSize: 14),
    iconColor: Colors.grey,
  ),
  selectedItemStyle: OverlayMenuItemStyle(
    backgroundColor: Colors.blue.withOpacity(0.1),
    textStyle: TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.w600,
    ),
    iconColor: Colors.blue,
  ),
)
```

### Divider Style

```dart
OverlayMenuStyle(
  dividerStyle: OverlayMenuDividerStyle(
    height: 16,
    thickness: 1,
    color: Colors.grey,
    indent: 16,
    endIndent: 16,
  ),
)
```

### Scrollbar Style

```dart
OverlayMenuStyle(
  scrollbarTheme: ScrollbarThemeData(
    thumbVisibility: WidgetStateProperty.all(true),
    thickness: WidgetStateProperty.all(6),
    thumbColor: WidgetStateProperty.all(Colors.grey),
    radius: Radius.circular(3),
  ),
)
```

## Positioning & Alignment

### Position Preference

```dart
showOverlayMenu(
  positionPreference: PositionPreference.below,  // Always below
  // PositionPreference.above   // Always above
  // PositionPreference.auto    // Auto (default)
  ...
)
```

### Horizontal Alignment

```dart
showOverlayMenu(
  alignment: MenuAlignment.end,  // Right-align
  // MenuAlignment.start   // Left-align (default)
  // MenuAlignment.center  // Center-align
  ...
)
```

### Custom Offset

```dart
showOverlayMenu(
  offset: Offset(10, 5),  // Additional offset
  buttonGap: 8,           // Gap between button and menu
  screenMargin: 16,       // Margin from screen edges
  ...
)
```

## Animations

```dart
showOverlayMenu(
  transitionDuration: Duration(milliseconds: 300),
  transitionCurve: Curves.elasticOut,
  ...
)
```

Available curves: `easeOutCubic`, `elasticOut`, `bounceOut`, `fastOutSlowIn`, etc.

## API Reference

### showOverlayMenu()

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `context` | `BuildContext` | required | Build context |
| `anchorKey` | `GlobalKey` | required | Key of anchor widget |
| `builder` | `WidgetBuilder` | required | Menu builder function |
| `positionPreference` | `PositionPreference` | `auto` | Position preference |
| `alignment` | `MenuAlignment` | `start` | Horizontal alignment |
| `offset` | `Offset` | `Offset.zero` | Additional offset |
| `buttonGap` | `double` | `4.0` | Gap from anchor |
| `screenMargin` | `double` | `8.0` | Screen edge margin |
| `transitionDuration` | `Duration` | `200ms` | Animation duration |
| `transitionCurve` | `Curve` | `easeOutCubic` | Animation curve |
| `style` | `OverlayMenuStyle?` | `null` | Menu style |
| `barrierDismissible` | `bool` | `true` | Tap outside to close |
| `barrierColor` | `Color` | `transparent` | Barrier color |

### OverlayMenuItem

| Parameter | Type | Description |
|-----------|------|-------------|
| `value` | `T?` | Value to return when selected |
| `child` | `Widget` | Main content |
| `leading` | `Widget?` | Leading widget (icon) |
| `trailing` | `Widget?` | Trailing widget (shortcut) |
| `selected` | `bool` | Whether item is selected |
| `enabled` | `bool` | Whether item is enabled |
| `onTap` | `VoidCallback?` | Custom tap handler |
| `itemStyle` | `OverlayMenuItemStyle?` | Custom item style |

**Behavior:**
- If `onTap` is null and `value` exists → returns value and closes menu
- If `onTap` is provided → executes `onTap` (doesn't auto-close)

### OverlayMenuStyle Properties

**Size:**
- `width`, `minWidth`, `maxWidth` - Width constraints
- `maxHeight` - Maximum height (enables scrolling)

**Appearance:**
- `backgroundColor` - Menu background color
- `elevation` - Shadow elevation
- `shadowColor` - Shadow color
- `borderRadius` - Corner radius
- `border` - Border style
- `padding` - Internal padding

**Sub-styles:**
- `itemStyle` - Default item style
- `selectedItemStyle` - Selected item style
- `dividerStyle` - Divider style
- `scrollbarTheme` - Scrollbar theme

### OverlayMenuItemStyle Properties

**Layout:**
- `height` - Item height
- `padding` - Internal padding
- `margin` - External margin

**Colors:**
- `backgroundColor` - Background color
- `hoverColor` - Hover color
- `splashColor` - Splash color
- `highlightColor` - Highlight color

**Border:**
- `border` - Border
- `borderRadius` - Corner radius

**Content:**
- `textStyle` - Text style
- `iconColor` - Icon color
- `iconSize` - Icon size
- `leadingGap` - Gap after leading widget
- `trailingGap` - Gap before trailing widget

**Effects:**
- `elevation` - Shadow elevation
- `shadowColor` - Shadow color

## Example App

Run the example to see all features in action:

```bash
cd example
flutter run
```

The example includes:
- Basic menus
- Styled items
- Selected states
- Custom animations
- Different positions and alignments

## License

MIT License - see [LICENSE](LICENSE) file for details.
