import 'package:flutter/material.dart';

import 'constants/presets.dart';
import 'models/demo_configuration.dart';
import 'widgets/customization_panel.dart';
import 'widgets/demo_button.dart';
import 'widgets/preset_buttons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Overlay Menu Playground',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      home: const PlaygroundPage(),
    );
  }
}

class PlaygroundPage extends StatefulWidget {
  const PlaygroundPage({super.key});

  @override
  State<PlaygroundPage> createState() => _PlaygroundPageState();
}

class _PlaygroundPageState extends State<PlaygroundPage> {
  late DemoConfiguration _config;
  String? _selectedPreset;
  String? _lastSelectedItem;

  @override
  void initState() {
    super.initState();
    _config = DemoPresets.material;
    _selectedPreset = 'Material';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Flutter Overlay Menu',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Interactive Playground',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _showInfoDialog,
            tooltip: 'About',
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Responsive layout
            final isWide = constraints.maxWidth > 800;

            if (isWide) {
              // Desktop/Tablet layout: Side by side
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left side: Demo button
                  Expanded(
                    flex: 2,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          const SizedBox(height: 40),
                          DemoButton(
                            config: _config,
                            onItemSelected: _handleItemSelected,
                          ),
                          const SizedBox(height: 40),
                          if (_lastSelectedItem != null) _buildResultCard(),
                        ],
                      ),
                    ),
                  ),

                  // Divider
                  Container(
                    width: 1,
                    color: Colors.grey.shade300,
                  ),

                  // Right side: Controls
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          PresetButtons(
                            selectedPreset: _selectedPreset,
                            onPresetSelected: _handlePresetSelected,
                          ),
                          const SizedBox(height: 16),
                          CustomizationPanel(
                            config: _config,
                            onConfigChanged: _handleConfigChanged,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              // Mobile layout: Stacked
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Demo button at top
                    DemoButton(
                      config: _config,
                      onItemSelected: _handleItemSelected,
                    ),
                    const SizedBox(height: 24),

                    // Result card
                    if (_lastSelectedItem != null) _buildResultCard(),
                    if (_lastSelectedItem != null) const SizedBox(height: 24),

                    // Presets
                    PresetButtons(
                      selectedPreset: _selectedPreset,
                      onPresetSelected: _handlePresetSelected,
                    ),
                    const SizedBox(height: 16),

                    // Customization
                    CustomizationPanel(
                      config: _config,
                      onConfigChanged: _handleConfigChanged,
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildResultCard() {
    final item = _config.items.firstWhere(
      (i) => i.id == _lastSelectedItem,
      orElse: () => _config.items.first,
    );

    return Card(
      color: Colors.green.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green.shade700,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Last Selection',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '"${item.label}"',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Config: ${_config.previewSummary}',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, size: 18),
              onPressed: () {
                setState(() {
                  _lastSelectedItem = null;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void _handlePresetSelected(String name, DemoConfiguration config) {
    setState(() {
      _config = config;
      _selectedPreset = name;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Applied "$name" preset'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _handleConfigChanged(DemoConfiguration config) {
    setState(() {
      _config = config;
      _selectedPreset = null; // Custom configuration
    });
  }

  void _handleItemSelected(String itemId) {
    setState(() {
      _lastSelectedItem = itemId;
    });

    final item = _config.items.firstWhere(
      (i) => i.id == itemId,
      orElse: () => _config.items.first,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check, color: Colors.white),
            const SizedBox(width: 8),
            Text('Selected: "${item.label}"'),
          ],
        ),
        backgroundColor: Colors.green.shade700,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.info_outline, color: Colors.blue),
            SizedBox(width: 8),
            Text('About'),
          ],
        ),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Flutter Overlay Menu Playground',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'This interactive demo showcases all the customization options available in the flutter_overlay_menu package.',
              ),
              SizedBox(height: 16),
              Text(
                'Features:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text('• Dynamic style customization'),
              Text('• Position & alignment control'),
              Text('• Animation configuration'),
              Text('• Menu item management'),
              Text('• Quick presets'),
              Text('• Responsive layout'),
              SizedBox(height: 16),
              Text(
                'Try changing the settings and tap the demo button to see the results!',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it!'),
          ),
        ],
      ),
    );
  }
}
