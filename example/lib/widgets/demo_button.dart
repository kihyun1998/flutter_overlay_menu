import 'package:flutter/material.dart';
import 'package:flutter_overlay_menu/flutter_overlay_menu.dart';

import '../models/demo_configuration.dart';

/// Main demo button that shows the overlay menu with current configuration
class DemoButton extends StatelessWidget {
  final DemoConfiguration config;
  final Function(String) onItemSelected;

  const DemoButton({
    super.key,
    required this.config,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Main demo button
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor.withValues(alpha: 0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              key: key,
              onTap: () => _showMenu(context, key),
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 48,
                  vertical: 24,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.touch_app,
                      size: 48,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '🎯 Demo Menu Button',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Tap to test current settings',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Preview summary
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.blue.shade200,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.info_outline,
                size: 16,
                color: Colors.blue.shade700,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  config.previewSummary,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue.shade900,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _showMenu(BuildContext context, GlobalKey key) async {
    final result = await showOverlayMenu<String>(
      context: context,
      anchorKey: key,
      positionPreference: config.positionPreference,
      alignment: config.alignment,
      offset: config.offset,
      buttonGap: config.buttonGap,
      screenMargin: config.screenMargin,
      transitionDuration: Duration(milliseconds: config.durationMs),
      transitionCurve: config.curve,
      style: config.toMenuStyle(context),
      barrierDismissible: config.barrierDismissible,
      barrierColor: config.barrierColor,
      pinnedButton:
          config.showPinnedButton ? _buildPinnedButton(context) : null,
      builder: (context) => OverlayMenu(
        items: _buildMenuItems(context),
        emptyWidget: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.inbox_outlined, size: 48, color: Colors.grey),
              SizedBox(height: 8),
              Text('No items found', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );

    if (result != null) {
      onItemSelected(result);
    }
  }

  Widget _buildPinnedButton(BuildContext context) {
    return Material(
      color: Colors.blue.shade50,
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Row(
                children: [
                  Icon(Icons.settings, color: Colors.white),
                  SizedBox(width: 8),
                  Text('Pinned button clicked!'),
                ],
              ),
              duration: Duration(seconds: 2),
            ),
          );
        },
        child: Container(
          height: config.pinnedButtonHeight,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(Icons.settings, size: 20, color: Colors.blue.shade700),
              const SizedBox(width: 12),
              Text(
                'Settings',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade900,
                ),
              ),
              const Spacer(),
              Icon(Icons.arrow_forward, size: 16, color: Colors.blue.shade700),
            ],
          ),
        ),
      ),
    );
  }

  List<OverlayMenuEntry> _buildMenuItems(BuildContext context) {
    final isDarkBg = config.backgroundColor.computeLuminance() < 0.5;
    final textColor = isDarkBg ? Colors.white : Colors.black87;
    final dangerColor = isDarkBg ? Colors.redAccent : Colors.red;

    final items = <OverlayMenuEntry>[];

    for (int i = 0; i < config.items.length; i++) {
      final item = config.items[i];
      final isSelected = item.id == '2'; // Demo: Mark second item as selected

      // Custom style for dangerous items (always applied if item is dangerous)
      OverlayMenuItemStyle? customStyle;
      if (item.isDangerous) {
        customStyle = OverlayMenuItemStyle(
          backgroundColor: dangerColor.withValues(alpha: 0.05),
          hoverColor: dangerColor.withValues(alpha: 0.1),
          splashColor: dangerColor.withValues(alpha: 0.2),
          border: Border.all(color: dangerColor.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(8),
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        );
      }

      items.add(
        OverlayMenuItem(
          value: item.id,
          selected: isSelected,
          itemStyle: customStyle,
          leading: item.leadingIcon != null
              ? Icon(
                  item.leadingIcon,
                  size: 20,
                  color: item.isDangerous ? dangerColor : null,
                )
              : null,
          trailing: item.trailingText != null
              ? Text(
                  item.trailingText!,
                  style: TextStyle(
                    fontSize: 12,
                    color: textColor.withValues(alpha: 0.6),
                  ),
                )
              : null,
          child: Text(
            item.label,
            style: TextStyle(
              color: item.isDangerous ? dangerColor : textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );

      // Add divider if specified
      if (item.hasDividerAfter && i < config.items.length - 1) {
        items.add(const OverlayMenuDivider());
      }
    }

    return items;
  }
}
