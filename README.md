# Flutter Overlay Menu

A flexible and customizable overlay menu package for Flutter.

## Features

- 📍 **Smart Positioning** - Auto-detects best position (above/below anchor)
- 🎨 **Fully Customizable** - Menu, items, dividers, scrollbar styles
- 🎯 **Selected State** - Built-in selected item styling
- 📌 **Pinned Button** - Fixed action button at top/bottom
- 📜 **Scrollbar** - Auto-scroll with customizable theme
- ⚡ **Animations** - Smooth transitions with custom curves
- 🎭 **Material Design** - Theme-aware defaults

## Installation

```yaml
dependencies:
  flutter_overlay_menu: ^0.1.1
```

## Quick Start

```dart
import 'package:flutter_overlay_menu/flutter_overlay_menu.dart';

final buttonKey = GlobalKey();

ElevatedButton(
  key: buttonKey,
  onPressed: () async {
    final result = await showOverlayMenu<String>(
      context: context,
      anchorKey: buttonKey,
      builder: (context) => OverlayMenu(
        items: [
          OverlayMenuItem(
            value: 'edit',
            leading: Icon(Icons.edit),
            child: Text('Edit'),
          ),
          OverlayMenuItem(
            value: 'delete',
            leading: Icon(Icons.delete),
            child: Text('Delete'),
          ),
        ],
      ),
    );
    
    if (result != null) {
      print('Selected: $result');
    }
  },
  child: Text('Show Menu'),
)
```

## Usage Examples

### Menu with Dividers

```dart
OverlayMenu(
  items: [
    OverlayMenuItem(value: 'copy', child: Text('Copy')),
    OverlayMenuItem(value: 'paste', child: Text('Paste')),
    OverlayMenuDivider(),
    OverlayMenuItem(value: 'delete', child: Text('Delete')),
  ],
)
```

### Selected State

```dart
OverlayMenuItem(
  value: 'option1',
  selected: currentValue == 'option1',
  child: Text('Option 1'),
)
```

### Custom Tap Handler

```dart
OverlayMenuItem(
  child: Text('Settings'),
  onTap: () {
    Navigator.pushNamed(context, '/settings');
  },
)
```

### Pinned Button

```dart
showOverlayMenu(
  context: context,
  anchorKey: buttonKey,
  style: OverlayMenuStyle(
    pinnedButtonHeight: 52.0,  // Required!
  ),
  pinnedButton: Material(
    color: Colors.blue.shade50,
    child: InkWell(
      onTap: () => Navigator.pushNamed(context, '/settings'),
      child: SizedBox(
        height: 52,
        child: Row(...),
      ),
    ),
  ),
  builder: (context) => OverlayMenu(items: [...]),
)
```

### Empty State

```dart
OverlayMenu(
  items: [],
  emptyWidget: Text('No items available'),
)
```

## Customization

### Basic Styling

```dart
showOverlayMenu(
  style: OverlayMenuStyle(
    backgroundColor: Colors.white,
    elevation: 8,
    borderRadius: BorderRadius.circular(12),
    minWidth: 200,
    maxHeight: 400,
  ),
  builder: (context) => OverlayMenu(...),
)
```

### Item Styling

```dart
OverlayMenuStyle(
  itemStyle: OverlayMenuItemStyle(
    height: 48,
    padding: EdgeInsets.symmetric(horizontal: 16),
    hoverColor: Colors.blue.withOpacity(0.1),
    borderRadius: BorderRadius.circular(8),
  ),
  selectedItemStyle: OverlayMenuItemStyle(
    backgroundColor: Colors.blue.withOpacity(0.1),
    textStyle: TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.w600,
    ),
  ),
)
```

### Position & Alignment

```dart
showOverlayMenu(
  positionPreference: PositionPreference.below,  // auto, above, below
  alignment: MenuAlignment.end,                   // start, center, end
  offset: Offset(10, 5),
  buttonGap: 8,
  screenMargin: 16,
  ...,
)
```

### Animations

```dart
showOverlayMenu(
  transitionDuration: Duration(milliseconds: 300),
  transitionCurve: Curves.easeOutCubic,
  ...,
)
```

## Key Parameters

### showOverlayMenu()

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `context` | `BuildContext` | required | Build context |
| `anchorKey` | `GlobalKey` | required | Anchor widget key |
| `builder` | `WidgetBuilder` | required | Menu builder |
| `positionPreference` | `PositionPreference` | `auto` | Position preference |
| `alignment` | `MenuAlignment` | `start` | Horizontal alignment |
| `style` | `OverlayMenuStyle?` | `null` | Menu styling |
| `pinnedButton` | `Widget?` | `null` | Fixed action button |
| `emptyWidget` | `Widget?` | `null` | Empty state widget |
| `transitionDuration` | `Duration` | `200ms` | Animation duration |
| `barrierDismissible` | `bool` | `true` | Tap outside to close |

### OverlayMenuItem

| Parameter | Type | Description |
|-----------|------|-------------|
| `value` | `T?` | Return value |
| `child` | `Widget` | Main content |
| `leading` | `Widget?` | Leading widget |
| `trailing` | `Widget?` | Trailing widget |
| `selected` | `bool` | Selected state |
| `enabled` | `bool` | Enabled state |
| `onTap` | `VoidCallback?` | Custom tap handler |

## Example App

```bash
cd example
flutter run
```

Interactive playground with 9 presets showcasing all features.

## License

MIT License - see [LICENSE](LICENSE) file for details.
