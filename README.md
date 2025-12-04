# Flutter Overlay Menu

A highly customizable overlay menu package for Flutter. Provides `showOverlayMenu()` function to display animated menus with smart positioning and Material Design styling.

[![pub package](https://img.shields.io/pub/v/flutter_overlay_menu.svg)](https://pub.dev/packages/flutter_overlay_menu)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Features

- 📱 **Flutter Standard Pattern**: Function-based API like `showDialog()` and `showMenu()`
- 🎨 **Rich Animations**: Customizable scale and fade animations
- 📍 **Smart Positioning**: Automatic direction selection based on available screen space
- 🎯 **Flexible Alignment**: Start, center, or end horizontal alignment
- 🔧 **Fully Customizable**: Control size, style, animation, and behavior
- 💎 **Material Design**: Built-in Material Design styling with theme support

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_overlay_menu: ^0.1.0
```

Then run:

```bash
flutter pub get
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
          OverlayMenuItem(value: 'edit', child: Text('Edit')),
          OverlayMenuItem(value: 'delete', child: Text('Delete')),
        ],
      ),
    );
    
    if (result == 'edit') handleEdit();
  },
  child: Text('Show Menu'),
)
```

## Usage

### Basic Dropdown Menu

```dart
final key = GlobalKey();

TextButton(
  key: key,
  onPressed: () async {
    final result = await showOverlayMenu<String>(
      context: context,
      anchorKey: key,
      builder: (context) => OverlayMenu(
        items: [
          OverlayMenuItem(value: 'Apple', child: Text('🍎 Apple')),
          OverlayMenuItem(value: 'Banana', child: Text('🍌 Banana')),
          OverlayMenuItem(value: 'Orange', child: Text('🍊 Orange')),
        ],
      ),
    );
    
    print('Selected: $result');
  },
  child: Text('Select a fruit'),
)
```

### Menu with Icons and Actions

```dart
IconButton(
  key: iconKey,
  icon: Icon(Icons.more_vert),
  onPressed: () {
    showOverlayMenu(
      context: context,
      anchorKey: iconKey,
      alignment: MenuAlignment.end,  // Right-align menu
      builder: (context) => OverlayMenu(
        items: [
          OverlayMenuItem(
            leading: Icon(Icons.edit),
            trailing: Text('Ctrl+E'),
            child: Text('Edit'),
            onTap: () {
              handleEdit();
              Navigator.pop(context);
            },
          ),
          OverlayMenuItem(
            leading: Icon(Icons.share),
            child: Text('Share'),
            onTap: () {
              handleShare();
              Navigator.pop(context);
            },
          ),
          OverlayMenuDivider(),
          OverlayMenuItem(
            leading: Icon(Icons.delete, color: Colors.red),
            child: Text('Delete', style: TextStyle(color: Colors.red)),
            onTap: () {
              handleDelete();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  },
)
```

### Custom Styling

```dart
showOverlayMenu(
  context: context,
  anchorKey: buttonKey,
  transitionDuration: Duration(milliseconds: 300),
  transitionCurve: Curves.elasticOut,
  style: OverlayMenuStyle(
    minWidth: 200,
    backgroundColor: Colors.grey[900],
    elevation: 12,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
  builder: (context) => OverlayMenu(
    items: [
      OverlayMenuItem(
        child: Text('Item 1', style: TextStyle(color: Colors.white)),
      ),
      OverlayMenuItem(
        child: Text('Item 2', style: TextStyle(color: Colors.white)),
      ),
    ],
  ),
)
```

### Position Preference

```dart
// Always show below
showOverlayMenu(
  positionPreference: PositionPreference.below,
  ...
)

// Always show above
showOverlayMenu(
  positionPreference: PositionPreference.above,
  ...
)

// Auto (default) - chooses best position
showOverlayMenu(
  positionPreference: PositionPreference.auto,
  ...
)
```

### Different Alignments

```dart
// Left-align menu (default)
showOverlayMenu(
  alignment: MenuAlignment.start,
  ...
)

// Center menu over button
showOverlayMenu(
  alignment: MenuAlignment.center,
  ...
)

// Right-align menu
showOverlayMenu(
  alignment: MenuAlignment.end,
  ...
)
```

## API Reference

### showOverlayMenu<T>()

Main function to display an overlay menu.

**Parameters:**
- `context` (`BuildContext`, required): Build context
- `anchorKey` (`GlobalKey`, required): Key of the anchor widget
- `builder` (`WidgetBuilder`, required): Builder function returning the menu widget
- `positionPreference` (`PositionPreference`): auto, below, or above (default: auto)
- `alignment` (`MenuAlignment`): start, center, or end (default: start)
- `offset` (`Offset`): Additional offset (default: Offset.zero)
- `buttonGap` (`double`): Gap between anchor and menu (default: 4.0)
- `screenMargin` (`double`): Margin from screen edges (default: 8.0)
- `transitionDuration` (`Duration`): Animation duration (default: 200ms)
- `transitionCurve` (`Curve`): Animation curve (default: Curves.easeOutCubic)
- `style` (`OverlayMenuStyle?`): Menu style configuration
- `barrierDismissible` (`bool`): Close menu on outside tap (default: true)
- `barrierColor` (`Color`): Barrier overlay color (default: Colors.transparent)
- `onOpen` (`VoidCallback?`): Called when menu finishes opening
- `onClose` (`VoidCallback?`): Called when menu starts closing

**Returns:**
- `Future<T?>`: Completes with selected value or null

### OverlayMenu

Widget to display menu content.

**Properties:**
- `items` (`List<OverlayMenuEntry>`): List of menu items
- `onItemSelected` (`Function(T)?`): Called when item with value is selected
- `style` (`OverlayMenuStyle?`): Menu style

### OverlayMenuItem<T>

Individual menu item widget.

**Properties:**
- `value` (`T?`): Value to return when selected
- `child` (`Widget`): Primary content
- `leading` (`Widget?`): Widget before child (typically Icon)
- `trailing` (`Widget?`): Widget after child
- `onTap` (`VoidCallback?`): Custom tap handler
- `enabled` (`bool`): Whether item is enabled (default: true)

**Behavior:**
- If `onTap` is provided: executes `onTap` (menu doesn't auto-close)
- If `onTap` is null and `value` is provided: returns `value` and auto-closes menu

### OverlayMenuStyle

Style configuration for overlay menus.

**Properties:**
- `width`, `minWidth`, `maxWidth`: Width constraints
- `maxHeight`: Maximum height (default: 300.0)
- `backgroundColor`: Background color
- `elevation`: Shadow elevation (default: 8.0)
- `shadowColor`: Shadow color
- `shape`: Border shape
- `padding`: Internal padding
- `scrollbarTheme`: Scrollbar theme (Phase 2+)

## Example

Check out the [example](example/) directory for a complete demo app with 5 different examples:

1. Basic dropdown menu
2. Icon menu with actions
3. Custom styling with dark theme
4. Different alignment options
5. Position preference options

To run the example:

```bash
cd example
flutter run
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a detailed list of changes and version history.
