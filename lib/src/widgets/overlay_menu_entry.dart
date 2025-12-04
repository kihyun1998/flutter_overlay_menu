import 'package:flutter/widgets.dart';

/// Base class for all overlay menu entries.
///
/// This abstract class serves as the parent for all types of menu entries,
/// including [OverlayMenuItem], [OverlayMenuDivider], etc.
///
/// All menu entries must extend this class to be used in [OverlayMenu].
abstract class OverlayMenuEntry extends StatelessWidget {
  /// Creates an overlay menu entry.
  const OverlayMenuEntry({Key? key}) : super(key: key);
}
