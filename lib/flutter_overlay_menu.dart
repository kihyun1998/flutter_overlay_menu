/// A highly customizable overlay menu package for Flutter.
///
/// This package provides a function-based API for displaying animated overlay
/// menus with smart positioning and Material Design styling.
///
/// ## Main Components
///
/// ### Functions
/// - [showOverlayMenu] - Display an overlay menu anchored to a widget
///
/// ### Widgets
/// - [OverlayMenu] - Menu container widget
/// - [OverlayMenuItem] - Individual menu item
/// - [OverlayMenuDivider] - Menu divider line
///
/// ### Models
/// - [OverlayMenuStyle] - Style configuration for menus
/// - [PositionPreference] - Position preference enum
/// - [MenuAlignment] - Menu alignment enum
///
/// ## Quick Start
///
/// ```dart
/// import 'package:flutter_overlay_menu/flutter_overlay_menu.dart';
///
/// final buttonKey = GlobalKey();
///
/// ElevatedButton(
///   key: buttonKey,
///   onPressed: () async {
///     final result = await showOverlayMenu<String>(
///       context: context,
///       anchorKey: buttonKey,
///       builder: (context) => OverlayMenu(
///         items: [
///           OverlayMenuItem(value: 'edit', child: Text('Edit')),
///           OverlayMenuItem(value: 'delete', child: Text('Delete')),
///         ],
///       ),
///     );
///     print('Selected: $result');
///   },
///   child: Text('Show Menu'),
/// )
/// ```
library flutter_overlay_menu;

// Functions
export 'src/functions/show_overlay_menu.dart';

// Widgets
export 'src/widgets/overlay_menu.dart';
export 'src/widgets/overlay_menu_item.dart';
export 'src/widgets/overlay_menu_divider.dart';
export 'src/widgets/overlay_menu_entry.dart';

// Models
export 'src/models/menu_style.dart';
export 'src/models/menu_item_style.dart';
export 'src/models/menu_divider_style.dart';
export 'src/models/enums.dart';
// Note: menu_position.dart is internal only, not exported
