import 'package:flutter/material.dart';

/// Customize the intro here.
const String kIntroText = 'POLylINGUA';
const String kIntroPlus = '+';
const Duration kIntroDuration = Duration(milliseconds: 2500);
const Duration kIntroReducedDuration = Duration(milliseconds: 800);
const List<Color> kIntroGradient = [Color(0xFF1B1B3A), Color(0xFF5B5BD6)];

/// Launch animation: wordmark fades/slides in, then "+" pops last.
/// Tap to skip. [onFinished] is called once, and should replace this route.
class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key, required this.onFinished});

  final void Function(BuildContext context) onFinished;

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this)..addStatusListener(_onStatus);
  late Animation<double> _word;
  late Animation<double> _plus;
  bool _reduced = false;
  bool _started = false;
  bool _done = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    _reduced = MediaQuery.of(context).disableAnimations;
    _controller.duration = _reduced ? kIntroReducedDuration : kIntroDuration;
    _word = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.65, curve: Curves.easeOutCubic),
    );
    _plus = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.65, 1.0, curve: Curves.elasticOut),
    );
    _controller.forward();
  }

  void _onStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) _finish();
  }

  void _finish() {
    if (_done || !mounted) return;
    _done = true;
    widget.onFinished(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.w700,
      letterSpacing: 1.5,
      color: Colors.white,
    );
    // Back is blocked so the intro can't be returned to or bypassed oddly.
    return PopScope(
      canPop: false,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _finish,
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: kIntroGradient,
              ),
            ),
            child: Center(
              child: Semantics(
                label: '$kIntroText$kIntroPlus',
                excludeSemantics: true,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    final w = _word.value;
                    final p = _plus.value.clamp(0.0, 1.5);
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Opacity(
                          opacity: w.clamp(0.0, 1.0),
                          child: Transform.translate(
                            offset: Offset(0, _reduced ? 0 : 20 * (1 - w)),
                            child: Transform.scale(
                              scale: _reduced ? 1 : 0.9 + 0.1 * w,
                              child: const Text(kIntroText, style: style),
                            ),
                          ),
                        ),
                        Opacity(
                          opacity: _plus.value.clamp(0.0, 1.0),
                          child: Transform.scale(
                            scale: _reduced ? 1 : p,
                            child: const Text(
                              kIntroPlus,
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFFFD166),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
