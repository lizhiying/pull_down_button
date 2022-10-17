import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../theme/default_theme.dart';
import '../theme/theme.dart';
import 'constants.dart';
import 'menu_item.dart';
import 'route.dart';

// ignore_for_file: public_member_api_docs, comment_references

/// Copy of [_PopupMenu] from [PopupMenuButton] implementation since it's
/// private there.
@immutable
@internal
class PullDownMenu extends StatelessWidget {
  const PullDownMenu({
    super.key,
    required this.route,
    this.borderRadius,
  });

  final PullDownMenuRoute route;
  final BorderRadius? borderRadius;

  static final _shadowTween = DecorationTween(
    begin: const BoxDecoration(
      boxShadow: [
        BoxShadow(color: Color.fromRGBO(0, 0, 0, 0)),
      ],
    ),
    end: const BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.1),
          blurRadius: 64,
          spreadRadius: 64,
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      for (var i = 0; i < route.items.length; i += 1)
        RenderMenuItem(
          onLayout: (size) => route.itemSizes[i] = size,
          child: route.items[i],
        ),
    ];

    final opacity = CurveTween(curve: const Interval(0, 1 / 3));

    final Widget menuBody = _MenuBody(
      widthConfiguration: route.widthConfiguration,
      children: children,
    );

    // split open/close animation into to parts to remove unnecessary rebuilds.
    // animation for menu content.
    final innerAnimation = AnimatedBuilder(
      animation: route.animation!,
      builder: (_, child) {
        final animate = route.animation!;
        final evaluate = animate.value;

        return Center(
          widthFactor: evaluate,
          heightFactor: evaluate,
          child: FadeTransition(opacity: animate, child: child),
        );
      },
      child: menuBody,
    );

    // animation for menu decoration.
    return AnimatedBuilder(
      animation: route.animation!,
      builder: (_, child) {
        final animate = route.animation!;

        return FadeTransition(
          opacity: opacity.animate(animate),
          child: DecoratedBoxTransition(
            decoration: _shadowTween.animate(animate),
            child: child!,
          ),
        );
      },
      child: _Decoration(
        backgroundColor: route.backgroundColor,
        borderRadius: borderRadius,
        child: innerAnimation,
      ),
    );
  }
}

/// Menu container - shape, blur, color.
@immutable
class _Decoration extends StatelessWidget {
  const _Decoration({
    required this.child,
    required this.backgroundColor,
    required this.borderRadius,
  });

  final Widget child;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = PullDownButtonTheme.of(context);
    final defaults = PullDownButtonThemeDefaults(context);

    final color = PullDownButtonTheme.getProperty(
      widgetProperty: backgroundColor,
      theme: theme,
      defaults: defaults,
      getThemeProperty: (theme) => theme?.backgroundColor,
    );

    return ClipRRect(
      borderRadius: borderRadius ?? kBorderRadius,
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: kBlurAmount, sigmaY: kBlurAmount),
        child: ColoredBox(
          color: color,
          child: child,
        ),
      ),
    );
  }
}

/// Menu body - constrained width, scrollbar, list of [PullDownMenuEntry].
@immutable
class _MenuBody extends StatelessWidget {
  const _MenuBody({required this.children, required this.widthConfiguration});

  final List<Widget> children;
  final PullDownMenuWidthConfiguration? widthConfiguration;

  @override
  Widget build(BuildContext context) {
    final theme = PullDownButtonTheme.of(context);
    final defaults = PullDownButtonThemeDefaults(context);

    final constraints = PullDownButtonTheme.getProperty(
      widgetProperty: widthConfiguration,
      theme: theme,
      defaults: defaults,
      getThemeProperty: (theme) => theme?.widthConfiguration,
    );

    return ConstrainedBox(
      constraints: constraints,
      child: Semantics(
        scopesRoute: true,
        namesRoute: true,
        explicitChildNodes: true,
        label: 'Pull-Down menu',
        child: CupertinoUserInterfaceLevel(
          data: CupertinoUserInterfaceLevelData.elevated,
          child: CupertinoScrollbar(
            child: SingleChildScrollView(
              child: ListBody(children: children),
            ),
          ),
        ),
      ),
    );
  }
}
