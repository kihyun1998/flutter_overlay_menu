import 'package:flutter/material.dart';

/// Internal widget that handles menu animation.
///
/// This widget manages the lifecycle of the menu animation, including
/// forward and reverse animations, using Scale and Fade transforms.
class AnimatedOverlayMenu extends StatefulWidget {
  /// Creates an animated overlay menu.
  const AnimatedOverlayMenu({
    super.key,
    required this.child,
    required this.transformOrigin,
    required this.duration,
    required this.curve,
    required this.onAnimationComplete,
  });

  /// The menu content to animate.
  final Widget child;

  /// The transform origin for scale animation.
  ///
  /// Typically [Alignment.topCenter] for menus below the anchor,
  /// and [Alignment.bottomCenter] for menus above.
  final Alignment transformOrigin;

  /// Duration of the animation.
  final Duration duration;

  /// Animation curve.
  final Curve curve;

  /// Callback when the forward animation completes.
  final VoidCallback onAnimationComplete;

  @override
  State<AnimatedOverlayMenu> createState() => AnimatedOverlayMenuState();
}

/// State for [AnimatedOverlayMenu].
///
/// This is exposed as a public class so that [showOverlayMenu] can
/// access the [close] method via GlobalKey.
class AnimatedOverlayMenuState extends State<AnimatedOverlayMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Create animation controller
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    // Create curved animation
    final curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    // Scale animation: 0.8 → 1.0
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(curvedAnimation);

    // Fade animation: 0.0 → 1.0
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(curvedAnimation);

    // Start forward animation
    _controller.forward().then((_) {
      if (mounted) {
        widget.onAnimationComplete();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Closes the menu with reverse animation.
  ///
  /// This is called by [showOverlayMenu] when the menu needs to close.
  /// Returns a future that completes when the animation finishes.
  Future<void> close() async {
    if (!mounted) return;
    await _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          alignment: widget.transformOrigin,
          child: Opacity(
            opacity: _fadeAnimation.value.clamp(0.0, 1.0),
            child: child,
          ),
        );
      },
    );
  }
}
