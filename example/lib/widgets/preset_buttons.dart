import 'package:flutter/material.dart';
import '../models/demo_configuration.dart';
import '../constants/presets.dart';

/// Quick preset buttons for changing configuration
class PresetButtons extends StatelessWidget {
  final String? selectedPreset;
  final Function(String name, DemoConfiguration config) onPresetSelected;

  const PresetButtons({
    Key? key,
    this.selectedPreset,
    required this.onPresetSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.palette_outlined,
                  size: 20,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 8),
                const Text(
                  '📋 Quick Presets',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: DemoPresets.all.entries.map((entry) {
                final isSelected = selectedPreset == entry.key;
                return _PresetChip(
                  label: entry.key,
                  isSelected: isSelected,
                  onTap: () => onPresetSelected(entry.key, entry.value),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _PresetChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _PresetChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  IconData _getIcon(String label) {
    switch (label) {
      case 'Material':
        return Icons.layers;
      case 'iOS':
        return Icons.phone_iphone;
      case 'Dark':
        return Icons.dark_mode;
      case 'Minimal':
        return Icons.minimize;
      case 'Colorful':
        return Icons.gradient;
      default:
        return Icons.style;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected
          ? Theme.of(context).primaryColor
          : Colors.grey.shade100,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _getIcon(label),
                size: 18,
                color: isSelected ? Colors.white : Colors.grey.shade700,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected ? Colors.white : Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
