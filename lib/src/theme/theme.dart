import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:pull_down_button/pull_down_button.dart';

import 'default_theme.dart';

/// Width configuration for pull-down menu.
///
/// Only `width` is passed to [BoxConstraints] so that `height` is always
/// unconstrained.
@immutable
class PullDownMenuWidthConfiguration extends BoxConstraints {
  /// Creates pull-down menu width configuration.
  const PullDownMenuWidthConfiguration(double width)
      : super.tightFor(width: width);
}

/// Defines the visual properties of the routes used to display pull-down menus
/// as well as any widgets that extend [PullDownMenuEntry].
///
/// Widgets that extend [PullDownMenuEntry] obtain current
/// [PullDownButtonTheme] object using
/// `PullDownButtonTheme.of(context)`.
///
/// [PullDownButtonTheme] should be specified in [ThemeData.extensions] or
/// using [PullDownButtonInheritedTheme] in `builder` property in [MaterialApp]
/// or [CupertinoApp].
///
/// All [PullDownButtonTheme] properties are `null` by default.
/// If any of these properties are null, the pull-down menu will use iOS 15
/// defaults specified in [PullDownButtonThemeDefaults].
@immutable
class PullDownButtonTheme extends ThemeExtension<PullDownButtonTheme>
    with Diagnosticable {
  /// Creates the set of properties used to configure [PullDownButtonTheme].
  const PullDownButtonTheme({
    this.backgroundColor,
    this.dividerColor,
    this.largeDividerColor,
    this.destructiveColor,
    this.iconSize,
    this.checkmark,
    this.checkmarkWeight,
    this.checkmarkSize,
    this.textStyle,
    this.iconActionTextStyle,
    this.titleStyle,
    this.widthConfiguration,
    this.applyOpacity,
    this.onHoverColor,
    this.onHoverTextStyle,
  });

  /// The background color of the pull-down menu.
  final Color? backgroundColor;

  /// The divider color of the pull-down menu divider [PullDownMenuDivider].
  final Color? dividerColor;

  /// The large divider color of the pull-down menu
  /// divider [PullDownMenuDivider.large].
  final Color? largeDividerColor;

  /// The destructive color of items in the pull-down menu.
  final Color? destructiveColor;

  /// The size of trailing icons of items in the pull-down menu.
  final double? iconSize;

  /// The selection icon for selected [SelectablePullDownMenuItem]s.
  final IconData? checkmark;

  /// The font weight of selection icon for selected
  /// [SelectablePullDownMenuItem]s.
  final FontWeight? checkmarkWeight;

  /// The size of chevron icons of items in the pull-down menu.
  final double? checkmarkSize;

  /// The text style of items in the pull-down menu.
  final TextStyle? textStyle;

  /// The text style of [PullDownMenuIconAction] items in the pull-down menu.
  final TextStyle? iconActionTextStyle;

  /// The text style of title in the pull-down menu.
  final TextStyle? titleStyle;

  /// The width configuration for pull-down menu.
  final PullDownMenuWidthConfiguration? widthConfiguration;

  /// Whether to apply opacity on [PullDownButton.buttonBuilder] as it is in iOS
  /// or not.
  final bool? applyOpacity;

  /// The on hover color of [PullDownMenuItem].
  final Color? onHoverColor;

  /// The on hover text style of items in the pull-down menu.
  final TextStyle? onHoverTextStyle;

  /// Get [PullDownButtonTheme] from [PullDownButtonInheritedTheme].
  ///
  /// If that's null get [PullDownButtonTheme] from [ThemeData.extensions]
  /// property of the ambient [Theme].
  static PullDownButtonTheme? of(BuildContext context) =>
      PullDownButtonInheritedTheme.of(context) ??
      Theme.of(context).extensions[PullDownButtonTheme] as PullDownButtonTheme?;

  /// Helper method to get required theme property.
  ///
  /// Inspired by [ButtonStyleButton] `effectiveValue` function.
  @internal
  static T getProperty<T>({
    T? widgetProperty,
    required PullDownButtonTheme? theme,
    required PullDownButtonThemeDefaults defaults,
    required T? Function(PullDownButtonTheme? theme) getThemeProperty,
  }) {
    if (widgetProperty != null) return widgetProperty;

    final themeValue = getThemeProperty(theme);
    final defaultValue = getThemeProperty(defaults) as T;

    return themeValue ?? defaultValue;
  }

  /// Creates a copy of this object with the given fields replaced with the
  /// new values.
  @override
  PullDownButtonTheme copyWith({
    Color? backgroundColor,
    Color? dividerColor,
    Color? largeDividerColor,
    Color? destructiveColor,
    double? iconSize,
    IconData? checkmark,
    FontWeight? checkmarkWeight,
    double? checkmarkSize,
    TextStyle? textStyle,
    TextStyle? iconActionTextStyle,
    TextStyle? titleStyle,
    PullDownMenuWidthConfiguration? widthConfiguration,
    bool? applyOpacity,
    Color? onHoverColor,
    TextStyle? onHoverTextStyle,
  }) =>
      PullDownButtonTheme(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        dividerColor: dividerColor ?? this.dividerColor,
        largeDividerColor: largeDividerColor ?? this.largeDividerColor,
        destructiveColor: destructiveColor ?? this.destructiveColor,
        iconSize: iconSize ?? this.iconSize,
        checkmark: checkmark ?? this.checkmark,
        checkmarkWeight: checkmarkWeight ?? this.checkmarkWeight,
        checkmarkSize: checkmarkSize ?? this.checkmarkSize,
        textStyle: textStyle ?? this.textStyle,
        iconActionTextStyle: iconActionTextStyle ?? this.iconActionTextStyle,
        titleStyle: titleStyle ?? this.titleStyle,
        widthConfiguration: widthConfiguration ?? this.widthConfiguration,
        applyOpacity: applyOpacity ?? this.applyOpacity,
        onHoverColor: onHoverColor ?? this.onHoverColor,
        onHoverTextStyle: onHoverTextStyle ?? this.onHoverTextStyle,
      );

  /// Linearly interpolate between two pull-down menu themes.
  @override
  PullDownButtonTheme lerp(
    ThemeExtension<PullDownButtonTheme>? other,
    double t,
  ) {
    if (other is! PullDownButtonTheme) {
      return this;
    }

    return PullDownButtonTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t),
      largeDividerColor: Color.lerp(
        largeDividerColor,
        other.largeDividerColor,
        t,
      ),
      destructiveColor: Color.lerp(destructiveColor, other.destructiveColor, t),
      iconSize: ui.lerpDouble(iconSize, other.iconSize, t),
      checkmark: other.checkmark,
      checkmarkWeight: FontWeight.lerp(
        checkmarkWeight,
        other.checkmarkWeight,
        t,
      ),
      checkmarkSize: ui.lerpDouble(checkmarkSize, other.checkmarkSize, t),
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t),
      iconActionTextStyle: TextStyle.lerp(
        iconActionTextStyle,
        other.iconActionTextStyle,
        t,
      ),
      titleStyle: TextStyle.lerp(titleStyle, other.titleStyle, t),
      widthConfiguration: other.widthConfiguration,
      applyOpacity: other.applyOpacity,
      onHoverColor: Color.lerp(onHoverColor, other.onHoverColor, t),
      onHoverTextStyle:
          TextStyle.lerp(onHoverTextStyle, other.onHoverTextStyle, t),
    );
  }

  @override
  int get hashCode => Object.hash(
        backgroundColor,
        dividerColor,
        largeDividerColor,
        destructiveColor,
        iconSize,
        checkmark,
        checkmarkWeight,
        checkmarkSize,
        textStyle,
        iconActionTextStyle,
        titleStyle,
        widthConfiguration,
        applyOpacity,
        onHoverColor,
        onHoverTextStyle,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is PullDownButtonTheme &&
        other.backgroundColor == backgroundColor &&
        other.dividerColor == dividerColor &&
        other.largeDividerColor == largeDividerColor &&
        other.destructiveColor == destructiveColor &&
        other.iconSize == iconSize &&
        other.checkmark == checkmark &&
        other.checkmarkWeight == checkmarkWeight &&
        other.checkmarkSize == checkmarkSize &&
        other.titleStyle == titleStyle &&
        other.iconActionTextStyle == iconActionTextStyle &&
        other.textStyle == textStyle &&
        other.widthConfiguration == widthConfiguration &&
        other.applyOpacity == applyOpacity &&
        other.onHoverColor == onHoverColor &&
        other.onHoverTextStyle == onHoverTextStyle;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        ColorProperty('backgroundColor', backgroundColor, defaultValue: null),
      )
      ..add(
        ColorProperty('dividerColor', dividerColor, defaultValue: null),
      )
      ..add(
        ColorProperty(
          'largeDividerColor',
          largeDividerColor,
          defaultValue: null,
        ),
      )
      ..add(
        ColorProperty('destructiveColor', destructiveColor, defaultValue: null),
      )
      ..add(DoubleProperty('iconSize', iconSize, defaultValue: null))
      ..add(
        DiagnosticsProperty<IconData>(
          'checkmark',
          checkmark,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<FontWeight>(
          'checkmarkWeight',
          checkmarkWeight,
          defaultValue: null,
        ),
      )
      ..add(DoubleProperty('checkmarkSize', checkmarkSize, defaultValue: null))
      ..add(
        DiagnosticsProperty<TextStyle>(
          'textStyle',
          textStyle,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<TextStyle>(
          'iconButtonTextStyle',
          iconActionTextStyle,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<TextStyle>(
          'titleStyle',
          titleStyle,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<PullDownMenuWidthConfiguration>(
          'widthConfiguration',
          widthConfiguration,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<bool>(
          'applyOpacity',
          applyOpacity,
          defaultValue: null,
        ),
      )
      ..add(
        ColorProperty('onHoverColor', onHoverColor, defaultValue: null),
      )
      ..add(
        DiagnosticsProperty<TextStyle>(
          'onHoverTextStyle',
          onHoverTextStyle,
          defaultValue: null,
        ),
      );
  }
}
