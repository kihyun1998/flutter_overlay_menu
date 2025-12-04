import 'package:flutter/material.dart';
import 'package:flutter_overlay_menu/flutter_overlay_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Overlay Menu Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _selectedFruit;
  String? _lastAction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Flutter Overlay Menu Examples'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Example 1: Basic Dropdown
            _buildSectionTitle('1. Basic Dropdown'),
            _buildExample1(),
            const SizedBox(height: 32),

            // Example 2: Icon Menu
            _buildSectionTitle('2. Icon Menu with Actions'),
            _buildExample2(),
            const SizedBox(height: 32),

            // Example 3: Custom Style
            _buildSectionTitle('3. Custom Style'),
            _buildExample3(),
            const SizedBox(height: 32),

            // Example 4: Alignment Options
            _buildSectionTitle('4. Alignment Options'),
            _buildExample4(),
            const SizedBox(height: 32),

            // Example 5: Position Preference
            _buildSectionTitle('5. Position Preference'),
            _buildExample5(),
            const SizedBox(height: 32),

            // Status Display
            if (_selectedFruit != null || _lastAction != null)
              Card(
                color: Colors.blue.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Status:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (_selectedFruit != null)
                        Text('Selected fruit: $_selectedFruit'),
                      if (_lastAction != null)
                        Text('Last action: $_lastAction'),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Example 1: Basic Dropdown
  Widget _buildExample1() {
    final key = GlobalKey();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Simple fruit selector with value return'),
            const SizedBox(height: 12),
            TextButton(
              key: key,
              onPressed: () async {
                final result = await showOverlayMenu<String>(
                  context: context,
                  anchorKey: key,
                  builder: (context) => OverlayMenu(
                    items: [
                      OverlayMenuItem(
                        value: 'Apple',
                        child: const Text('🍎 Apple'),
                      ),
                      OverlayMenuItem(
                        value: 'Banana',
                        child: const Text('🍌 Banana'),
                      ),
                      OverlayMenuItem(
                        value: 'Orange',
                        child: const Text('🍊 Orange'),
                      ),
                      OverlayMenuItem(
                        value: 'Grape',
                        child: const Text('🍇 Grape'),
                      ),
                    ],
                  ),
                );

                if (result != null) {
                  setState(() => _selectedFruit = result);
                }
              },
              child: Text(
                _selectedFruit ?? 'Select a fruit',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Example 2: Icon Menu with Actions
  Widget _buildExample2() {
    final key = GlobalKey();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Menu with icons and onTap handlers'),
            const SizedBox(height: 12),
            IconButton(
              key: key,
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                showOverlayMenu(
                  context: context,
                  anchorKey: key,
                  alignment: MenuAlignment.end,
                  builder: (context) => OverlayMenu(
                    items: [
                      OverlayMenuItem(
                        leading: const Icon(Icons.edit, size: 20),
                        trailing: const Text(
                          'Ctrl+E',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        child: const Text('Edit'),
                        onTap: () {
                          setState(() => _lastAction = 'Edit');
                          Navigator.pop(context);
                        },
                      ),
                      OverlayMenuItem(
                        leading: const Icon(Icons.share, size: 20),
                        child: const Text('Share'),
                        onTap: () {
                          setState(() => _lastAction = 'Share');
                          Navigator.pop(context);
                        },
                      ),
                      const OverlayMenuDivider(),
                      OverlayMenuItem(
                        leading: const Icon(
                          Icons.delete,
                          size: 20,
                          color: Colors.red,
                        ),
                        child: const Text(
                          'Delete',
                          style: TextStyle(color: Colors.red),
                        ),
                        onTap: () {
                          setState(() => _lastAction = 'Delete');
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Example 3: Custom Style
  Widget _buildExample3() {
    final key = GlobalKey();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Dark theme with custom animation'),
            const SizedBox(height: 12),
            ElevatedButton(
              key: key,
              onPressed: () {
                showOverlayMenu(
                  context: context,
                  anchorKey: key,
                  transitionDuration: const Duration(milliseconds: 300),
                  transitionCurve: Curves.elasticOut,
                  style: const OverlayMenuStyle(
                    minWidth: 200,
                    backgroundColor: Color(0xFF212121),
                    elevation: 12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                  builder: (context) => OverlayMenu(
                    items: [
                      OverlayMenuItem(
                        value: 'dark1',
                        child: const Text(
                          'Dark Item 1',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          setState(() => _lastAction = 'Dark Item 1');
                          Navigator.pop(context);
                        },
                      ),
                      OverlayMenuItem(
                        value: 'dark2',
                        child: const Text(
                          'Dark Item 2',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          setState(() => _lastAction = 'Dark Item 2');
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Show Dark Menu'),
            ),
          ],
        ),
      ),
    );
  }

  // Example 4: Different Alignments
  Widget _buildExample4() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Test different horizontal alignments'),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAlignmentButton('Start', MenuAlignment.start),
                _buildAlignmentButton('Center', MenuAlignment.center),
                _buildAlignmentButton('End', MenuAlignment.end),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlignmentButton(String label, MenuAlignment alignment) {
    final key = GlobalKey();

    return ElevatedButton(
      key: key,
      onPressed: () {
        showOverlayMenu(
          context: context,
          anchorKey: key,
          alignment: alignment,
          builder: (context) => OverlayMenu(
            items: [
              OverlayMenuItem(
                child: Text('$label aligned'),
                onTap: () {
                  setState(() => _lastAction = '$label alignment');
                  Navigator.pop(context);
                },
              ),
              OverlayMenuItem(
                child: const Text('Item 2'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
      child: Text(label),
    );
  }

  // Example 5: Position Preference
  Widget _buildExample5() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Force menu to appear above or below'),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPositionButton('Auto', PositionPreference.auto),
                _buildPositionButton('Below', PositionPreference.below),
                _buildPositionButton('Above', PositionPreference.above),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPositionButton(String label, PositionPreference preference) {
    final key = GlobalKey();

    return ElevatedButton(
      key: key,
      onPressed: () {
        showOverlayMenu(
          context: context,
          anchorKey: key,
          positionPreference: preference,
          builder: (context) => OverlayMenu(
            items: [
              OverlayMenuItem(
                child: Text('Position: $label'),
                onTap: () {
                  setState(() => _lastAction = 'Position: $label');
                  Navigator.pop(context);
                },
              ),
              OverlayMenuItem(
                child: const Text('Item 2'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
      child: Text(label),
    );
  }
}
