import 'package:flutter/material.dart';
import 'package:flutter_overlay_menu/flutter_overlay_menu.dart';
import '../models/demo_configuration.dart';

/// Preset configurations for quick demo
class DemoPresets {
  DemoPresets._();

  /// Default menu items
  static List<DemoMenuItem> get defaultItems => [
        const DemoMenuItem(
          id: '1',
          label: 'Edit',
          leadingIcon: Icons.edit,
          trailingText: 'Ctrl+E',
        ),
        const DemoMenuItem(
          id: '2',
          label: 'Share',
          leadingIcon: Icons.share,
        ),
        const DemoMenuItem(
          id: '3',
          label: 'Delete',
          leadingIcon: Icons.delete,
          isDangerous: true,
          hasDividerAfter: false,
        ),
      ];

  /// Material Design preset (default)
  static DemoConfiguration get material => DemoConfiguration(
        borderRadius: 8.0,
        elevation: 8.0,
        backgroundColor: Colors.white,
        minWidth: 180.0,
        durationMs: 200,
        curve: Curves.easeOutCubic,
        positionPreference: PositionPreference.auto,
        alignment: MenuAlignment.start,
        items: defaultItems,
      );

  /// iOS Style preset
  static DemoConfiguration get ios => DemoConfiguration(
        borderRadius: 12.0,
        elevation: 4.0,
        backgroundColor: const Color(0xFFF5F5F5),
        minWidth: 200.0,
        durationMs: 250,
        curve: Curves.easeOut,
        positionPreference: PositionPreference.auto,
        alignment: MenuAlignment.center,
        items: defaultItems,
      );

  /// Dark Mode preset
  static DemoConfiguration get dark => DemoConfiguration(
        borderRadius: 16.0,
        elevation: 12.0,
        backgroundColor: const Color(0xFF212121),
        minWidth: 220.0,
        durationMs: 300,
        curve: Curves.elasticOut,
        positionPreference: PositionPreference.auto,
        alignment: MenuAlignment.start,
        items: defaultItems,
      );

  /// Minimal preset
  static DemoConfiguration get minimal => DemoConfiguration(
        borderRadius: 0.0,
        elevation: 2.0,
        backgroundColor: Colors.white,
        minWidth: 160.0,
        durationMs: 150,
        curve: Curves.linear,
        positionPreference: PositionPreference.auto,
        alignment: MenuAlignment.start,
        items: defaultItems,
      );

  /// Colorful preset
  static DemoConfiguration get colorful => DemoConfiguration(
        borderRadius: 24.0,
        elevation: 16.0,
        backgroundColor: const Color(0xFFE3F2FD),
        minWidth: 240.0,
        durationMs: 400,
        curve: Curves.bounceOut,
        positionPreference: PositionPreference.auto,
        alignment: MenuAlignment.center,
        items: defaultItems,
      );

  /// Styled Items preset - showcasing item styling
  static DemoConfiguration get styledItems => DemoConfiguration(
        borderRadius: 12.0,
        elevation: 8.0,
        backgroundColor: Colors.white,
        minWidth: 220.0,
        durationMs: 200,
        curve: Curves.easeOutCubic,
        positionPreference: PositionPreference.auto,
        alignment: MenuAlignment.start,
        items: defaultItems,
        itemStyle: OverlayMenuItemStyle(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          backgroundColor: Colors.transparent,
          hoverColor: Colors.blue.withOpacity(0.08),
          splashColor: Colors.blue.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8),
          textStyle: const TextStyle(fontSize: 14),
          leadingGap: 12,
          trailingGap: 12,
        ),
        dividerStyle: const OverlayMenuDividerStyle(
          height: 12,
          thickness: 1,
          indent: 16,
          endIndent: 16,
        ),
      );

  /// Selected Item preset - showcasing selected item styling
  static DemoConfiguration get selectedItem => DemoConfiguration(
        borderRadius: 12.0,
        elevation: 8.0,
        backgroundColor: Colors.white,
        minWidth: 220.0,
        durationMs: 200,
        curve: Curves.easeOutCubic,
        positionPreference: PositionPreference.auto,
        alignment: MenuAlignment.start,
        items: [
          const DemoMenuItem(
            id: '1',
            label: 'Normal Item',
            leadingIcon: Icons.circle_outlined,
          ),
          const DemoMenuItem(
            id: '2',
            label: 'Selected Item',
            leadingIcon: Icons.check_circle,
          ),
          const DemoMenuItem(
            id: '3',
            label: 'Another Item',
            leadingIcon: Icons.circle_outlined,
          ),
        ],
        itemStyle: OverlayMenuItemStyle(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          backgroundColor: Colors.transparent,
          hoverColor: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        selectedItemStyle: OverlayMenuItemStyle(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          backgroundColor: Colors.blue.withOpacity(0.1),
          hoverColor: Colors.blue.withOpacity(0.15),
          splashColor: Colors.blue.withOpacity(0.2),
          border: Border.all(color: Colors.blue, width: 1.5),
          borderRadius: BorderRadius.circular(8),
          textStyle: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.w600,
          ),
          iconColor: Colors.blue,
        ),
      );

  /// Custom Styles preset - showcasing individual item styles
  static DemoConfiguration get customStyles => DemoConfiguration(
        borderRadius: 12.0,
        elevation: 8.0,
        backgroundColor: Colors.white,
        minWidth: 220.0,
        durationMs: 200,
        curve: Curves.easeOutCubic,
        positionPreference: PositionPreference.auto,
        alignment: MenuAlignment.start,
        items: [
          const DemoMenuItem(
            id: '1',
            label: 'Edit',
            leadingIcon: Icons.edit,
            trailingText: 'Ctrl+E',
          ),
          const DemoMenuItem(
            id: '2',
            label: 'Share',
            leadingIcon: Icons.share,
          ),
          const DemoMenuItem(
            id: '3',
            label: 'Delete',
            leadingIcon: Icons.delete,
            isDangerous: true,
          ),
        ],
        itemStyle: OverlayMenuItemStyle(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          backgroundColor: Colors.transparent,
          hoverColor: Colors.grey.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8),
          textStyle: const TextStyle(fontSize: 14),
        ),
        dividerStyle: const OverlayMenuDividerStyle(
          height: 12,
          thickness: 1,
          color: Colors.grey,
          indent: 16,
          endIndent: 16,
        ),
      );

  /// Get all presets as a map
  static Map<String, DemoConfiguration> get all => {
        'Material': material,
        'iOS': ios,
        'Dark': dark,
        'Minimal': minimal,
        'Colorful': colorful,
        'Styled Items': styledItems,
        'Selected Item': selectedItem,
        'Custom Styles': customStyles,
      };
}

/// Available animation curves
class AnimationCurves {
  AnimationCurves._();

  static const Map<String, Curve> curves = {
    'easeOutCubic': Curves.easeOutCubic,
    'elasticOut': Curves.elasticOut,
    'bounceOut': Curves.bounceOut,
    'fastOutSlowIn': Curves.fastOutSlowIn,
    'linear': Curves.linear,
    'decelerate': Curves.decelerate,
    'easeOut': Curves.easeOut,
    'easeInOut': Curves.easeInOut,
  };

  static String getName(Curve curve) {
    return curves.entries
            .firstWhere(
              (entry) => entry.value == curve,
              orElse: () => const MapEntry('easeOutCubic', Curves.easeOutCubic),
            )
            .key;
  }
}
