import 'package:flutter/material.dart';
import 'package:flutter_overlay_menu/flutter_overlay_menu.dart';
import '../models/demo_configuration.dart';
import '../constants/presets.dart';

/// Customization panel for all overlay menu settings
class CustomizationPanel extends StatelessWidget {
  final DemoConfiguration config;
  final Function(DemoConfiguration) onConfigChanged;

  const CustomizationPanel({
    Key? key,
    required this.config,
    required this.onConfigChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Menu Style Panel
        _buildPanel(
          title: '🎨 Menu Style',
          icon: Icons.style,
          child: _MenuStyleSection(
            config: config,
            onConfigChanged: onConfigChanged,
          ),
        ),
        const SizedBox(height: 12),

        // Item Style Panel
        _buildPanel(
          title: '🖌️ Item Style',
          icon: Icons.format_paint,
          child: _ItemStyleSection(
            config: config,
            onConfigChanged: onConfigChanged,
          ),
        ),
        const SizedBox(height: 12),

        // Divider Style Panel
        _buildPanel(
          title: '➖ Divider Style',
          icon: Icons.horizontal_rule,
          child: _DividerStyleSection(
            config: config,
            onConfigChanged: onConfigChanged,
          ),
        ),
        const SizedBox(height: 12),

        // Scrollbar Style Panel
        _buildPanel(
          title: '📜 Scrollbar Style',
          icon: Icons.view_day,
          child: _ScrollbarStyleSection(
            config: config,
            onConfigChanged: onConfigChanged,
          ),
        ),
        const SizedBox(height: 12),

        // Position & Alignment Panel
        _buildPanel(
          title: '📍 Position & Alignment',
          icon: Icons.place,
          child: _PositionSection(
            config: config,
            onConfigChanged: onConfigChanged,
          ),
        ),
        const SizedBox(height: 12),

        // Animation Panel
        _buildPanel(
          title: '✨ Animation',
          icon: Icons.animation,
          child: _AnimationSection(
            config: config,
            onConfigChanged: onConfigChanged,
          ),
        ),
        const SizedBox(height: 12),

        // Menu Items Panel
        _buildPanel(
          title: '📋 Menu Items',
          icon: Icons.list,
          child: _MenuItemsSection(
            config: config,
            onConfigChanged: onConfigChanged,
          ),
        ),
        const SizedBox(height: 12),

        // Advanced Options Panel
        _buildPanel(
          title: '⚙️ Advanced Options',
          icon: Icons.tune,
          child: _AdvancedSection(
            config: config,
            onConfigChanged: onConfigChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildPanel({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Card(
      elevation: 2,
      child: ExpansionTile(
        leading: Icon(icon, color: Colors.blue.shade700),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: child,
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Menu Style Section
// ============================================================================

class _MenuStyleSection extends StatelessWidget {
  final DemoConfiguration config;
  final Function(DemoConfiguration) onConfigChanged;

  const _MenuStyleSection({
    required this.config,
    required this.onConfigChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Border Radius
        _SliderSetting(
          label: 'Border Radius',
          value: config.borderRadius,
          min: 0,
          max: 32,
          divisions: 32,
          unit: 'px',
          onChanged: (value) {
            onConfigChanged(config.copyWith(borderRadius: value));
          },
        ),
        const SizedBox(height: 12),

        // Elevation
        _SliderSetting(
          label: 'Elevation',
          value: config.elevation,
          min: 0,
          max: 24,
          divisions: 24,
          onChanged: (value) {
            onConfigChanged(config.copyWith(elevation: value));
          },
        ),
        const SizedBox(height: 12),

        // Background Color
        _ColorSetting(
          label: 'Background Color',
          color: config.backgroundColor,
          onChanged: (color) {
            onConfigChanged(config.copyWith(backgroundColor: color));
          },
        ),
        const SizedBox(height: 12),

        // Shadow Color
        _ColorSetting(
          label: 'Shadow Color',
          color: config.shadowColor ?? Colors.black.withOpacity(0.2),
          onChanged: (color) {
            onConfigChanged(config.copyWith(shadowColor: color));
          },
        ),
        const SizedBox(height: 12),

        // Min Width
        _SliderSetting(
          label: 'Min Width',
          value: config.minWidth,
          min: 120,
          max: 400,
          divisions: 28,
          unit: 'px',
          onChanged: (value) {
            onConfigChanged(config.copyWith(minWidth: value));
          },
        ),
        const SizedBox(height: 12),

        // Max Height
        _SliderSetting(
          label: 'Max Height',
          value: config.maxHeight,
          min: 100,
          max: 600,
          divisions: 50,
          unit: 'px',
          onChanged: (value) {
            onConfigChanged(config.copyWith(maxHeight: value));
          },
        ),
        const SizedBox(height: 12),

        // Menu Padding Vertical
        _SliderSetting(
          label: 'Menu Padding (Vertical)',
          value: config.menuPaddingVertical,
          min: 0,
          max: 24,
          divisions: 24,
          unit: 'px',
          onChanged: (value) {
            onConfigChanged(config.copyWith(menuPaddingVertical: value));
          },
        ),
        const SizedBox(height: 12),

        // Menu Padding Horizontal
        _SliderSetting(
          label: 'Menu Padding (Horizontal)',
          value: config.menuPaddingHorizontal,
          min: 0,
          max: 24,
          divisions: 24,
          unit: 'px',
          onChanged: (value) {
            onConfigChanged(config.copyWith(menuPaddingHorizontal: value));
          },
        ),
      ],
    );
  }
}

// ============================================================================
// Item Style Section
// ============================================================================

class _ItemStyleSection extends StatelessWidget {
  final DemoConfiguration config;
  final Function(DemoConfiguration) onConfigChanged;

  const _ItemStyleSection({
    required this.config,
    required this.onConfigChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Item Height
        _SliderSetting(
          label: 'Item Height',
          value: config.itemHeight,
          min: 32,
          max: 72,
          divisions: 40,
          unit: 'px',
          onChanged: (value) {
            onConfigChanged(config.copyWith(itemHeight: value));
          },
        ),
        const SizedBox(height: 12),

        // Padding Horizontal
        _SliderSetting(
          label: 'Padding (Horizontal)',
          value: config.itemPaddingHorizontal,
          min: 0,
          max: 32,
          divisions: 32,
          unit: 'px',
          onChanged: (value) {
            onConfigChanged(config.copyWith(itemPaddingHorizontal: value));
          },
        ),
        const SizedBox(height: 12),

        // Padding Vertical
        _SliderSetting(
          label: 'Padding (Vertical)',
          value: config.itemPaddingVertical,
          min: 0,
          max: 24,
          divisions: 24,
          unit: 'px',
          onChanged: (value) {
            onConfigChanged(config.copyWith(itemPaddingVertical: value));
          },
        ),
        const SizedBox(height: 12),

        // Item Margin
        _SliderSetting(
          label: 'Item Margin',
          value: config.itemMargin,
          min: 0,
          max: 8,
          divisions: 16,
          unit: 'px',
          onChanged: (value) {
            onConfigChanged(config.copyWith(itemMargin: value));
          },
        ),
        const SizedBox(height: 12),

        // Background Color
        _ColorSetting(
          label: 'Background Color',
          color: config.itemBackgroundColor ?? Colors.transparent,
          onChanged: (color) {
            onConfigChanged(config.copyWith(itemBackgroundColor: color));
          },
        ),
        const SizedBox(height: 12),

        // Hover Color
        _ColorSetting(
          label: 'Hover Color',
          color: config.itemHoverColor ?? Colors.grey.shade200,
          onChanged: (color) {
            onConfigChanged(config.copyWith(itemHoverColor: color));
          },
        ),
        const SizedBox(height: 12),

        // Splash Color
        _ColorSetting(
          label: 'Splash Color',
          color: config.itemSplashColor ?? Colors.grey.shade300,
          onChanged: (color) {
            onConfigChanged(config.copyWith(itemSplashColor: color));
          },
        ),
        const SizedBox(height: 12),

        // Highlight Color
        _ColorSetting(
          label: 'Highlight Color',
          color: config.itemHighlightColor ?? Colors.grey.shade200,
          onChanged: (color) {
            onConfigChanged(config.copyWith(itemHighlightColor: color));
          },
        ),
        const SizedBox(height: 12),

        // Item Border Radius
        _SliderSetting(
          label: 'Border Radius',
          value: config.itemBorderRadius,
          min: 0,
          max: 16,
          divisions: 16,
          unit: 'px',
          onChanged: (value) {
            onConfigChanged(config.copyWith(itemBorderRadius: value));
          },
        ),
        const SizedBox(height: 12),

        // Text Size
        _SliderSetting(
          label: 'Text Size',
          value: config.itemTextSize,
          min: 10,
          max: 20,
          divisions: 20,
          unit: 'px',
          onChanged: (value) {
            onConfigChanged(config.copyWith(itemTextSize: value));
          },
        ),
        const SizedBox(height: 12),

        // Icon Size
        _SliderSetting(
          label: 'Icon Size',
          value: config.itemIconSize,
          min: 16,
          max: 32,
          divisions: 16,
          unit: 'px',
          onChanged: (value) {
            onConfigChanged(config.copyWith(itemIconSize: value));
          },
        ),
        const SizedBox(height: 12),

        // Icon Color
        _ColorSetting(
          label: 'Icon Color',
          color: config.itemIconColor ?? Colors.grey.shade700,
          onChanged: (color) {
            onConfigChanged(config.copyWith(itemIconColor: color));
          },
        ),
        const SizedBox(height: 12),

        // Leading Gap
        _SliderSetting(
          label: 'Leading Gap',
          value: config.itemLeadingGap,
          min: 0,
          max: 24,
          divisions: 24,
          unit: 'px',
          onChanged: (value) {
            onConfigChanged(config.copyWith(itemLeadingGap: value));
          },
        ),
        const SizedBox(height: 12),

        // Trailing Gap
        _SliderSetting(
          label: 'Trailing Gap',
          value: config.itemTrailingGap,
          min: 0,
          max: 24,
          divisions: 24,
          unit: 'px',
          onChanged: (value) {
            onConfigChanged(config.copyWith(itemTrailingGap: value));
          },
        ),
        const SizedBox(height: 16),

        // Selected Item Section Header
        const Divider(),
        const SizedBox(height: 8),
        const Text(
          'Selected Item Style',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),

        // Selected Background Color
        _ColorSetting(
          label: 'Selected Background',
          color: config.selectedItemBackgroundColor ??
              Theme.of(context).colorScheme.primary.withOpacity(0.08),
          onChanged: (color) {
            onConfigChanged(
                config.copyWith(selectedItemBackgroundColor: color));
          },
        ),
        const SizedBox(height: 12),

        // Selected Hover Color
        _ColorSetting(
          label: 'Selected Hover',
          color: config.selectedItemHoverColor ??
              Theme.of(context).colorScheme.primary.withOpacity(0.12),
          onChanged: (color) {
            onConfigChanged(config.copyWith(selectedItemHoverColor: color));
          },
        ),
        const SizedBox(height: 12),

        // Selected Text Color
        _ColorSetting(
          label: 'Selected Text Color',
          color: config.selectedItemTextColor ??
              Theme.of(context).colorScheme.primary,
          onChanged: (color) {
            onConfigChanged(config.copyWith(selectedItemTextColor: color));
          },
        ),
        const SizedBox(height: 12),

        // Selected Icon Color
        _ColorSetting(
          label: 'Selected Icon Color',
          color: config.selectedItemIconColor ??
              Theme.of(context).colorScheme.primary,
          onChanged: (color) {
            onConfigChanged(config.copyWith(selectedItemIconColor: color));
          },
        ),
      ],
    );
  }
}

// ============================================================================
// Divider Style Section
// ============================================================================

class _DividerStyleSection extends StatelessWidget {
  final DemoConfiguration config;
  final Function(DemoConfiguration) onConfigChanged;

  const _DividerStyleSection({
    required this.config,
    required this.onConfigChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Get current divider style or use defaults
    final currentDividerStyle =
        config.dividerStyle ?? OverlayMenuDividerStyle.defaultStyle(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Divider Height
        _SliderSetting(
          label: 'Divider Height',
          value: currentDividerStyle.height ?? 16.0,
          min: 8,
          max: 32,
          divisions: 24,
          unit: 'px',
          onChanged: (value) {
            onConfigChanged(config.copyWith(
              dividerStyle: currentDividerStyle.copyWith(height: value),
            ));
          },
        ),
        const SizedBox(height: 12),

        // Divider Thickness
        _SliderSetting(
          label: 'Divider Thickness',
          value: currentDividerStyle.thickness ?? 1.0,
          min: 0.5,
          max: 4,
          divisions: 7,
          unit: 'px',
          onChanged: (value) {
            onConfigChanged(config.copyWith(
              dividerStyle: currentDividerStyle.copyWith(thickness: value),
            ));
          },
        ),
        const SizedBox(height: 12),

        // Divider Color
        _ColorSetting(
          label: 'Divider Color',
          color: currentDividerStyle.color ?? Theme.of(context).dividerColor,
          onChanged: (color) {
            onConfigChanged(config.copyWith(
              dividerStyle: currentDividerStyle.copyWith(color: color),
            ));
          },
        ),
        const SizedBox(height: 12),

        // Left Indent
        _SliderSetting(
          label: 'Left Indent',
          value: currentDividerStyle.indent ?? 16.0,
          min: 0,
          max: 32,
          divisions: 32,
          unit: 'px',
          onChanged: (value) {
            onConfigChanged(config.copyWith(
              dividerStyle: currentDividerStyle.copyWith(indent: value),
            ));
          },
        ),
        const SizedBox(height: 12),

        // Right Indent
        _SliderSetting(
          label: 'Right Indent',
          value: currentDividerStyle.endIndent ?? 16.0,
          min: 0,
          max: 32,
          divisions: 32,
          unit: 'px',
          onChanged: (value) {
            onConfigChanged(config.copyWith(
              dividerStyle: currentDividerStyle.copyWith(endIndent: value),
            ));
          },
        ),
        const SizedBox(height: 12),

        // Reset Button
        Center(
          child: TextButton.icon(
            onPressed: () {
              onConfigChanged(config.copyWith(
                dividerStyle: OverlayMenuDividerStyle.defaultStyle(context),
              ));
            },
            icon: const Icon(Icons.refresh, size: 18),
            label: const Text('Reset to Default'),
            style: TextButton.styleFrom(
              foregroundColor: Colors.orange,
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// Scrollbar Style Section
// ============================================================================

class _ScrollbarStyleSection extends StatelessWidget {
  final DemoConfiguration config;
  final Function(DemoConfiguration) onConfigChanged;

  const _ScrollbarStyleSection({
    required this.config,
    required this.onConfigChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Always Visible Toggle
        SwitchListTile(
          title: const Text('Always Visible', style: TextStyle(fontSize: 13)),
          subtitle: const Text('Show scrollbar even when not scrolling',
              style: TextStyle(fontSize: 11)),
          value: config.scrollbarAlwaysVisible,
          onChanged: (value) {
            onConfigChanged(config.copyWith(scrollbarAlwaysVisible: value));
          },
          contentPadding: EdgeInsets.zero,
          dense: true,
        ),
        const SizedBox(height: 12),

        // Thickness
        _SliderSetting(
          label: 'Thickness',
          value: config.scrollbarThickness,
          min: 2,
          max: 12,
          divisions: 10,
          unit: 'px',
          onChanged: (value) {
            onConfigChanged(config.copyWith(scrollbarThickness: value));
          },
        ),
        const SizedBox(height: 12),

        // Color
        _ColorSetting(
          label: 'Thumb Color',
          color: config.scrollbarColor,
          onChanged: (color) {
            onConfigChanged(config.copyWith(scrollbarColor: color));
          },
        ),
        const SizedBox(height: 12),

        // Thumb Radius
        _SliderSetting(
          label: 'Thumb Radius',
          value: config.scrollbarRadius,
          min: 0,
          max: 10,
          divisions: 20,
          unit: 'px',
          onChanged: (value) {
            onConfigChanged(config.copyWith(scrollbarRadius: value));
          },
        ),
        const SizedBox(height: 16),

        // Track Section
        const Text(
          'Track Style',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),

        // Track Visible Toggle
        SwitchListTile(
          title: const Text('Show Track', style: TextStyle(fontSize: 13)),
          subtitle: const Text('Display scrollbar track background',
              style: TextStyle(fontSize: 11)),
          value: config.scrollbarTrackVisible,
          onChanged: (value) {
            onConfigChanged(config.copyWith(scrollbarTrackVisible: value));
          },
          contentPadding: EdgeInsets.zero,
          dense: true,
        ),
        const SizedBox(height: 12),

        // Track Color
        _ColorSetting(
          label: 'Track Color',
          color: config.scrollbarTrackColor ?? Colors.grey.shade200,
          onChanged: (color) {
            onConfigChanged(config.copyWith(scrollbarTrackColor: color));
          },
        ),
        const SizedBox(height: 12),

        // Track Border Color
        _ColorSetting(
          label: 'Track Border Color',
          color: config.scrollbarTrackBorderColor ?? Colors.grey.shade400,
          onChanged: (color) {
            onConfigChanged(config.copyWith(scrollbarTrackBorderColor: color));
          },
        ),
      ],
    );
  }
}

// ============================================================================
// Position & Alignment Section
// ============================================================================

class _PositionSection extends StatelessWidget {
  final DemoConfiguration config;
  final Function(DemoConfiguration) onConfigChanged;

  const _PositionSection({
    required this.config,
    required this.onConfigChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Position Preference
        const Text('Position Preference:', style: TextStyle(fontSize: 13)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            _ChoiceChip(
              label: 'Auto',
              isSelected: config.positionPreference == PositionPreference.auto,
              onTap: () {
                onConfigChanged(
                  config.copyWith(positionPreference: PositionPreference.auto),
                );
              },
            ),
            _ChoiceChip(
              label: 'Below',
              isSelected: config.positionPreference == PositionPreference.below,
              onTap: () {
                onConfigChanged(
                  config.copyWith(positionPreference: PositionPreference.below),
                );
              },
            ),
            _ChoiceChip(
              label: 'Above',
              isSelected: config.positionPreference == PositionPreference.above,
              onTap: () {
                onConfigChanged(
                  config.copyWith(positionPreference: PositionPreference.above),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Alignment
        const Text('Horizontal Alignment:', style: TextStyle(fontSize: 13)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            _ChoiceChip(
              label: 'Start',
              isSelected: config.alignment == MenuAlignment.start,
              onTap: () {
                onConfigChanged(
                  config.copyWith(alignment: MenuAlignment.start),
                );
              },
            ),
            _ChoiceChip(
              label: 'Center',
              isSelected: config.alignment == MenuAlignment.center,
              onTap: () {
                onConfigChanged(
                  config.copyWith(alignment: MenuAlignment.center),
                );
              },
            ),
            _ChoiceChip(
              label: 'End',
              isSelected: config.alignment == MenuAlignment.end,
              onTap: () {
                onConfigChanged(
                  config.copyWith(alignment: MenuAlignment.end),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

// ============================================================================
// Animation Section
// ============================================================================

class _AnimationSection extends StatelessWidget {
  final DemoConfiguration config;
  final Function(DemoConfiguration) onConfigChanged;

  const _AnimationSection({
    required this.config,
    required this.onConfigChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Duration
        _SliderSetting(
          label: 'Duration',
          value: config.durationMs.toDouble(),
          min: 100,
          max: 1000,
          divisions: 18,
          unit: 'ms',
          onChanged: (value) {
            onConfigChanged(config.copyWith(durationMs: value.toInt()));
          },
        ),
        const SizedBox(height: 12),

        // Curve
        const Text('Animation Curve:', style: TextStyle(fontSize: 13)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButton<Curve>(
            value: config.curve,
            isExpanded: true,
            underline: const SizedBox(),
            items: AnimationCurves.curves.entries.map((entry) {
              return DropdownMenuItem(
                value: entry.value,
                child: Text(entry.key),
              );
            }).toList(),
            onChanged: (curve) {
              if (curve != null) {
                onConfigChanged(config.copyWith(curve: curve));
              }
            },
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// Menu Items Section
// ============================================================================

class _MenuItemsSection extends StatelessWidget {
  final DemoConfiguration config;
  final Function(DemoConfiguration) onConfigChanged;

  const _MenuItemsSection({
    required this.config,
    required this.onConfigChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '${config.items.length} items',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            if (config.items.length < 10)
              TextButton.icon(
                onPressed: () => _addItem(),
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add'),
              ),
            if (config.items.length > 1)
              TextButton.icon(
                onPressed: () => _removeItem(),
                icon: const Icon(Icons.remove, size: 18),
                label: const Text('Remove'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        ...config.items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return _MenuItemTile(
            item: item,
            onToggleDivider: () => _toggleDivider(index),
          );
        }).toList(),
      ],
    );
  }

  void _addItem() {
    final newItem = DemoMenuItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      label: 'Item ${config.items.length + 1}',
      leadingIcon: Icons.star,
    );
    onConfigChanged(
      config.copyWith(items: [...config.items, newItem]),
    );
  }

  void _removeItem() {
    if (config.items.isNotEmpty) {
      onConfigChanged(
        config.copyWith(
            items: config.items.sublist(0, config.items.length - 1)),
      );
    }
  }

  void _toggleDivider(int index) {
    final updatedItems = List<DemoMenuItem>.from(config.items);
    updatedItems[index] = updatedItems[index].copyWith(
      hasDividerAfter: !updatedItems[index].hasDividerAfter,
    );
    onConfigChanged(config.copyWith(items: updatedItems));
  }
}

class _MenuItemTile extends StatelessWidget {
  final DemoMenuItem item;
  final VoidCallback onToggleDivider;

  const _MenuItemTile({
    required this.item,
    required this.onToggleDivider,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          if (item.leadingIcon != null)
            Icon(item.leadingIcon, size: 18, color: Colors.grey.shade600),
          if (item.leadingIcon != null) const SizedBox(width: 8),
          Expanded(
            child: Text(
              item.label,
              style: TextStyle(
                fontSize: 13,
                color: item.isDangerous ? Colors.red : Colors.black87,
              ),
            ),
          ),
          if (item.trailingText != null)
            Text(
              item.trailingText!,
              style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
            ),
          IconButton(
            icon: Icon(
              item.hasDividerAfter ? Icons.more_horiz : Icons.remove,
              size: 18,
            ),
            tooltip: 'Toggle divider',
            onPressed: onToggleDivider,
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.all(4),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Advanced Options Section
// ============================================================================

class _AdvancedSection extends StatelessWidget {
  final DemoConfiguration config;
  final Function(DemoConfiguration) onConfigChanged;

  const _AdvancedSection({
    required this.config,
    required this.onConfigChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Barrier Dismissible
        SwitchListTile(
          title:
              const Text('Barrier Dismissible', style: TextStyle(fontSize: 13)),
          value: config.barrierDismissible,
          onChanged: (value) {
            onConfigChanged(config.copyWith(barrierDismissible: value));
          },
          contentPadding: EdgeInsets.zero,
          dense: true,
        ),

        // Button Gap
        _SliderSetting(
          label: 'Button Gap',
          value: config.buttonGap,
          min: 0,
          max: 20,
          divisions: 20,
          unit: 'px',
          onChanged: (value) {
            onConfigChanged(config.copyWith(buttonGap: value));
          },
        ),
        const SizedBox(height: 12),

        // Screen Margin
        _SliderSetting(
          label: 'Screen Margin',
          value: config.screenMargin,
          min: 0,
          max: 32,
          divisions: 32,
          unit: 'px',
          onChanged: (value) {
            onConfigChanged(config.copyWith(screenMargin: value));
          },
        ),
      ],
    );
  }
}

// ============================================================================
// Helper Widgets
// ============================================================================

class _SliderSetting extends StatelessWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final String? unit;
  final Function(double) onChanged;

  const _SliderSetting({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    this.unit,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 13)),
            Text(
              '${value.toInt()}${unit ?? ''}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _ColorSetting extends StatelessWidget {
  final String label;
  final Color color;
  final Function(Color) onChanged;

  const _ColorSetting({
    required this.label,
    required this.color,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final presetColors = [
      Colors.white,
      const Color(0xFFF5F5F5),
      const Color(0xFF212121),
      const Color(0xFFE3F2FD),
      const Color(0xFFFCE4EC),
      const Color(0xFFF3E5F5),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: presetColors.map((presetColor) {
            final isSelected = color.value == presetColor.value;
            return GestureDetector(
              onTap: () => onChanged(presetColor),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: presetColor,
                  border: Border.all(
                    color: isSelected ? Colors.blue : Colors.grey.shade300,
                    width: isSelected ? 3 : 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _ChoiceChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ChoiceChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? Colors.blue : Colors.grey.shade200,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              color: isSelected ? Colors.white : Colors.grey.shade700,
            ),
          ),
        ),
      ),
    );
  }
}
