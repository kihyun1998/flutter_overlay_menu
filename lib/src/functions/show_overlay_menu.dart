import 'dart:async';
import 'package:flutter/material.dart';
import '../core/animated_overlay_menu.dart';
import '../core/menu_positioner.dart';
import '../core/menu_size_calculator.dart';
import '../models/enums.dart';
import '../models/menu_style.dart';
import '../widgets/overlay_menu.dart';

/// Displays an overlay menu anchored to a widget.
///
/// The menu appears near the widget identified by [anchorKey], with smart
/// positioning that automatically chooses the best direction (above or below)
/// based on available screen space.
///
/// Returns a [Future] that completes with the selected value when the menu
/// is dismissed. If the user taps outside the menu or the menu is closed
/// without selection, the future completes with `null`.
///
/// Example:
/// ```dart
/// final key = GlobalKey();
///
/// ElevatedButton(
///   key: key,
///   onPressed: () async {
///     final result = await showOverlayMenu<String>(
///       context: context,
///       anchorKey: key,
///       builder: (context) => OverlayMenu(
///         items: [
///           OverlayMenuItem(value: 'edit', child: Text('Edit')),
///           OverlayMenuItem(value: 'delete', child: Text('Delete')),
///         ],
///       ),
///     );
///     if (result != null) {
///       print('Selected: $result');
///     }
///   },
///   child: Text('Show Menu'),
/// )
/// ```
///
/// Parameters:
/// - [context]: Build context for overlay insertion
/// - [anchorKey]: GlobalKey of the widget to anchor the menu to
/// - [builder]: Builder function that returns the menu widget
/// - [positionPreference]: Preferred position (auto, below, or above)
/// - [alignment]: Horizontal alignment (start, center, or end)
/// - [offset]: Additional offset to apply to the menu position
/// - [buttonGap]: Gap between anchor and menu (default: 4.0)
/// - [screenMargin]: Margin from screen edges (default: 8.0)
/// - [transitionDuration]: Duration of open/close animations
/// - [transitionCurve]: Animation curve
/// - [style]: Style for the menu
/// - [barrierDismissible]: Whether tapping outside closes the menu
/// - [barrierColor]: Color of the barrier overlay
/// - [onOpen]: Called when the menu finishes opening
/// - [onClose]: Called when the menu starts closing
Future<T?> showOverlayMenu<T>({
  required BuildContext context,
  required GlobalKey anchorKey,
  required WidgetBuilder builder,
  PositionPreference positionPreference = PositionPreference.auto,
  MenuAlignment alignment = MenuAlignment.start,
  Offset offset = Offset.zero,
  double buttonGap = 4.0,
  double screenMargin = 8.0,
  Duration transitionDuration = const Duration(milliseconds: 200),
  Curve transitionCurve = Curves.easeOutCubic,
  OverlayMenuStyle? style,
  bool barrierDismissible = true,
  Color barrierColor = Colors.transparent,
  VoidCallback? onOpen,
  VoidCallback? onClose,
}) {
  // Get RenderBox of the anchor widget
  final renderBox = anchorKey.currentContext?.findRenderObject() as RenderBox?;
  if (renderBox == null) {
    throw FlutterError(
      'showOverlayMenu: anchorKey must be attached to a widget in the tree.\n'
      'Make sure the widget with anchorKey has been built before calling showOverlayMenu.',
    );
  }

  // Create completer for return value
  final completer = Completer<T?>();

  // Create overlay entry
  late final OverlayEntry overlayEntry;
  late final GlobalKey<AnimatedOverlayMenuState> animationKey;

  // Close menu function
  void closeMenu([T? value]) async {
    if (completer.isCompleted) return;

    // Start close animation
    onClose?.call();
    await animationKey.currentState?.close();

    // Remove overlay entry
    overlayEntry.remove();

    // Complete with value
    completer.complete(value);
  }

  // Create animation key
  animationKey = GlobalKey<AnimatedOverlayMenuState>();

  // Build menu widget early to estimate size
  Widget menuWidget = builder(context);
  
  // Estimate menu size BEFORE creating overlay
  Size menuSize;
  if (menuWidget is OverlayMenu) {
    menuSize = MenuSizeCalculator.estimateSize(
      items: menuWidget.items,
      anchorWidth: renderBox.size.width,
      style: style ?? menuWidget.style,
    );
  } else {
    // Custom widget, use default/style size
    menuSize = Size(
      style?.width ?? renderBox.size.width,
      style?.maxHeight ?? 300.0,
    );
  }

  // Calculate position BEFORE creating overlay (while renderBox is still attached)
  final position = MenuPositioner.calculatePosition(
    context: context,
    anchorBox: renderBox,
    menuSize: menuSize,
    preference: positionPreference,
    alignment: alignment,
    buttonGap: buttonGap,
    screenMargin: screenMargin,
    additionalOffset: offset,
  );

  // Create overlay entry with cached position and size
  overlayEntry = OverlayEntry(
    builder: (context) {
      // Rebuild menu widget in case it needs context
      Widget builtMenuWidget = builder(context);

      // If it's an OverlayMenu, wrap onItemSelected to call closeMenu
      if (builtMenuWidget is OverlayMenu) {
        final originalOnItemSelected = builtMenuWidget.onItemSelected;
        
        // Merge styles, ensuring maxHeight is constrained to available space
        final originalStyle = style ?? builtMenuWidget.style;
        final constrainedStyle = originalStyle?.copyWith(
          maxHeight: (originalStyle.maxHeight).clamp(0.0, position.availableHeight),
        ) ?? OverlayMenuStyle(
          maxHeight: position.availableHeight,
        );
        
        builtMenuWidget = OverlayMenu(
          items: builtMenuWidget.items,
          style: constrainedStyle,
          onItemSelected: (value) {
            originalOnItemSelected?.call(value);
            closeMenu(value as T?);
          },
        );
      }

      // Use cached position and size (no recalculation on rebuild)

      return GestureDetector(
        // Detect taps outside menu
        onTap: barrierDismissible ? () => closeMenu() : null,
        behavior: HitTestBehavior.translucent,
        child: Container(
          color: barrierColor,
          child: Stack(
            children: [ 
              Positioned(
                left: position.offset.dx,
                top: position.offset.dy,
                child: GestureDetector( 
                  // Absorb taps inside menu
                  onTap: () {},
                  child: AnimatedOverlayMenu(  
                    key: animationKey,
                    transformOrigin: position.transformOrigin,
                    duration: transitionDuration,
                    curve: transitionCurve,
                    onAnimationComplete: () {
                      onOpen?.call();
                    },
                    child: SizedBox(
                      width: menuSize.width,
                      // Height is controlled by OverlayMenu's maxHeight style
                      child: Material(
                        // Material handles backgroundColor, elevation, and shape
                        // This ensures consistent rendering across platforms
                        color: style?.backgroundColor ?? Colors.white,
                        elevation: style?.elevation ?? 8.0,
                        shadowColor: style?.shadowColor,
                        clipBehavior: Clip.antiAlias, // Clip content to shape
                        // Build shape from borderRadius and border
                        shape: style?.shape ??
                            RoundedRectangleBorder(
                              borderRadius: style?.borderRadius ??
                                  BorderRadius.circular(8.0),
                              side: style?.border ??
                                  BorderSide(
                                    color: Colors.grey.shade300,
                                    width: 1.0,
                                  ),
                            ),
                        // OverlayMenu only handles content layout
                        child: builtMenuWidget,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

  // Insert overlay
  Overlay.of(context).insert(overlayEntry);

  // Return future
  return completer.future;
}
