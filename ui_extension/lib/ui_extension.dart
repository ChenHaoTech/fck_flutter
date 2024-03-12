library;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_extension/widget/fn_stateful_builder.dart';
import 'package:ui_extension/widget/swipe_detector.dart';

extension WidgetExt2 on Widget {
  //SwipeDetector
  Widget swipeDetector({
    void Function(Offset offset)? onSwipeUp,
    void Function(Offset offset)? onSwipeDown,
    void Function(Offset offset)? onSwipeLeft,
    void Function(Offset offset)? onSwipeRight,
  }) {
    return SwipeDetector(
      onSwipeUp: onSwipeUp,
      onSwipeDown: onSwipeDown,
      onSwipeLeft: onSwipeLeft,
      onSwipeRight: onSwipeRight,
      child: this,
    );
  }

  //WillPopScope
  Widget willPopScope({
    FutureOr<bool> Function()? onWillPop,
  }) {
    return WillPopScope(
      onWillPop: onWillPop == null ? null : () async => await onWillPop.call(),
      child: this,
    );
  }

  // Column Widget
  Widget col(
      {Key? key,
      MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
      MainAxisSize mainAxisSize = MainAxisSize.max,
      CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
      TextDirection? textDirection,
      VerticalDirection verticalDirection = VerticalDirection.down,
      TextBaseline? textBaseline,
      List<Widget> Function(Widget child)? supplier}) {
    return Column(
      key: key,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: supplier?.call(this) ?? [this],
    );
  }

// Row Widget
  Widget row(
      {Key? key,
      MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
      MainAxisSize mainAxisSize = MainAxisSize.max,
      CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
      TextDirection? textDirection,
      VerticalDirection verticalDirection = VerticalDirection.down,
      TextBaseline? textBaseline,
      List<Widget> Function(Widget child)? supplier}) {
    return Row(
      key: key,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: supplier?.call(this) ?? [this],
    );
  }

  Widget onDispose(void Function() onDispose) {
    return onLifeCycle(onDispose: onDispose);
  }

  Widget onInit(void Function() onInit) {
    return onLifeCycle(onInit: onInit);
  }

  Widget onLifeCycle({
    void Function()? onInit,
    void Function()? onDispose,
    void Function()? onReassemble,
    Widget Function()? supplier,
  }) {
    return FnStatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return supplier?.call() ?? this;
      },
      onInit: () => onInit?.call(),
      onDispose: () => onDispose?.call(),
      onReassemble: () => onReassemble?.call(),
    );
  }

  // Action
  Widget action(Map<Type, Action<Intent>> actions) {
    return Actions(actions: actions, child: this);
  }

  Widget inkWell({
    Key? key,
    GestureTapCallback? onTap,
    GestureTapCallback? onDoubleTap,
    GestureLongPressCallback? onLongPress,
    GestureTapDownCallback? onTapDown,
    GestureTapUpCallback? onTapUp,
    GestureTapCancelCallback? onTapCancel,
    GestureTapCallback? onSecondaryTap,
    GestureTapUpCallback? onSecondaryTapUp,
    GestureTapDownCallback? onSecondaryTapDown,
    GestureTapCancelCallback? onSecondaryTapCancel,
    ValueChanged<bool>? onHighlightChanged,
    ValueChanged<bool>? onHover,
    MouseCursor? mouseCursor,
    Color? focusColor,
    Color? hoverColor,
    Color? highlightColor,
    MaterialStateProperty<Color?>? overlayColor,
    Color? splashColor,
    InteractiveInkFeatureFactory? splashFactory,
    double? radius,
    BorderRadius? borderRadius,
    ShapeBorder? customBorder,
    bool? enableFeedback = true,
    bool excludeFromSemantics = false,
    FocusNode? focusNode,
    bool canRequestFocus = true,
    ValueChanged<bool>? onFocusChange,
    bool autofocus = false,
    MaterialStatesController? statesController,
  }) {
    return InkWell(
      key: key,
      child: this,
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      onSecondaryTap: onSecondaryTap,
      onSecondaryTapUp: onSecondaryTapUp,
      onSecondaryTapDown: onSecondaryTapDown,
      onSecondaryTapCancel: onSecondaryTapCancel,
      onHighlightChanged: onHighlightChanged,
      onHover: onHover,
      mouseCursor: mouseCursor,
      focusColor: focusColor,
      hoverColor: hoverColor,
      highlightColor: highlightColor,
      overlayColor: overlayColor,
      splashColor: splashColor,
      splashFactory: splashFactory,
      radius: radius,
      borderRadius: borderRadius,
      customBorder: customBorder,
      enableFeedback: enableFeedback,
      excludeFromSemantics: excludeFromSemantics,
      focusNode: focusNode,
      canRequestFocus: canRequestFocus,
      onFocusChange: onFocusChange,
      autofocus: autofocus,
      statesController: statesController,
    );
  }
}

extension IconDataExt on IconData {
  Icon asIcon({
    double? size,
    double? fill,
    double? weight,
    double? grade,
    double? opticalSize,
    Color? color,
    List<Shadow>? shadows,
    String? semanticLabel,
    TextDirection? textDirection,
  }) {
    return Icon(
      this,
      grade: grade,
      opticalSize: opticalSize,
      size: size,
      fill: fill,
      shadows: shadows,
      weight: weight,
      color: color,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );
  }
}

extension WidgetExt on Widget {
  // PreferredSize
  PreferredSize preferredSize(Size preferredSize) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: this,
    );
  }

  // absorbPointer
  Widget absorbPointer({bool absorbing = true}) {
    return AbsorbPointer(
      absorbing: absorbing,
      child: this,
    );
  }

  Widget ignorePointer({bool ignoring = true}) {
    return IgnorePointer(
      ignoring: ignoring,
      child: this,
    );
  }

  // Transform.rotate
  Widget rotate(double angle, {Offset origin = Offset.zero, AlignmentGeometry alignment = Alignment.center}) {
    return Transform.rotate(
      angle: angle,
      origin: origin,
      alignment: alignment,
      child: this,
    );
  }

  //tooltip
  Widget tooltip(String message, {Key? key}) {
    return Tooltip(
      message: message,
      key: key,
      child: this,
    );
  }

  Widget position({
    double? top,
    double? right,
    double? bottom,
    double? left,
    double? width,
    double? height,
  }) {
    return Positioned(
      top: top,
      right: right,
      bottom: bottom,
      left: left,
      width: width,
      height: height,
      child: this,
    );
  }

  Widget hero(
    Object tag, {
    Key? key,
    CreateRectTween? createRectTween,
    HeroFlightShuttleBuilder? flightShuttleBuilder,
    HeroPlaceholderBuilder? placeholderBuilder,
    bool transitionOnUserGestures = false,
  }) {
    return Hero(
      key: key,
      tag: tag,
      createRectTween: createRectTween,
      flightShuttleBuilder: flightShuttleBuilder,
      placeholderBuilder: placeholderBuilder,
      transitionOnUserGestures: transitionOnUserGestures,
      child: this,
    );
  }

// asScaffoldBody
  Widget asScaffoldBody({bool? resizeToAvoidBottomInset}) {
    return Scaffold(
      body: this,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }

  // opacity
  Widget opacity(double opacity) {
    return Opacity(
      opacity: opacity,
      child: this,
    );
  }

  Widget cover(Widget widget) {
    return widget;
  }

  // defaultTextStyle
  Widget defaultTextStyle({
    TextStyle? style,
  }) {
    if (style == null) return this;
    return DefaultTextStyle(style: style, child: this);
  }

  // Material
  Widget material({
    Color? color,
    double? elevation,
    ShapeBorder? shape,
    BorderRadius? borderRadius,
    double? radius,
    Clip clipBehavior = Clip.none,
  }) {
    assert([shape, borderRadius, radius].where((e) => e != null).length <= 1, "只可以有一个不为空");
    ;
    return Material(
      color: color,
      elevation: elevation ?? 0.0,
      shape: shape ??
          () {
            return RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(32.0),
            );
          }(),
      clipBehavior: clipBehavior,
      child: this,
    );
  }

  // IntrinsicWidth
  Widget intrinsicWidth({
    double? stepWidth,
    double? stepHeight,
  }) {
    return IntrinsicWidth(
      stepWidth: stepWidth,
      stepHeight: stepHeight,
      child: this,
    );
  }

  //IntrinsicHeight
  Widget intrinsicHeight() {
    return IntrinsicHeight(
      child: this,
    );
  }

  //ClipRRect
  Widget clipRRect({double radius = 2, Clip clipBehavior = Clip.antiAlias}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      clipBehavior: clipBehavior,
      child: this,
    );
  }

  //FittedBox
  Widget fittedBox({
    BoxFit fit = BoxFit.contain,
    Alignment alignment = Alignment.center,
    Clip clipBehavior = Clip.hardEdge,
  }) {
    return FittedBox(
      fit: fit,
      alignment: alignment,
      clipBehavior: clipBehavior,
      child: this,
    );
  }

  // ClipRect
  Widget clipRect({
    Clip clipBehavior = Clip.hardEdge,
    CustomClipper<Rect>? clipper,
  }) {
    return ClipRect(
      clipBehavior: clipBehavior,
      clipper: clipper,
      child: this,
    );
  }

  // SizedBox
  Widget sizedBox({
    double? width,
    double? height,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: this,
    );
  }

  Widget container({
    BorderRadius? borderRadius,
    double? radius,
    Color? color,
    Decoration? decoration,
    double? width,
    List<BoxShadow>? boxShadow,
    double? height,
    EdgeInsetsGeometry? padding,
  }) {
    assert([decoration, borderRadius, radius].where((e) => e != null).length <= 1, "只可以有一个不为空");
    var nopDecoration = decoration == null && borderRadius == null && radius == null && boxShadow == null;
    return Container(
      color: nopDecoration && color != null ? color : null,
      decoration: () {
        if (nopDecoration) {
          return null;
        }
        return decoration ??
            BoxDecoration(
              borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 10),
              color: color,
              boxShadow: boxShadow,
            );
      }(),
      width: width,
      height: height,
      padding: padding,
      child: this,
    );
  }

  Widget expand({int? flex}) {
    return Expanded(
      flex: flex ?? 1,
      child: this,
    );
  }

  //card
  Widget card({
    Color? color,
    double? elevation,
    ShapeBorder? shape,
    bool borderOnForeground = true,
    EdgeInsetsGeometry? margin,
    Clip? clipBehavior,
    BorderRadius? borderRadius,
    double? radius,
  }) {
    assert([shape, borderRadius, radius].where((e) => e != null).length <= 1, "只可以有一个不为空");
    return Card(
      color: color,
      elevation: elevation ?? 1.0,
      shape: shape ??
          () {
            return RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(4.0),
            );
          }(),
      borderOnForeground: borderOnForeground,
      margin: margin,
      clipBehavior: clipBehavior ?? Clip.none,
      child: this,
    );
  }

  // safeArea
  Widget safeArea({
    bool top = true,
    bool bottom = true,
    bool left = true,
    bool right = true,
  }) {
    return SafeArea(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: this,
    );
  }

  //UnconstrainedBox
  Widget unconstrainedBox({
    TextDirection? textDirection,
    AlignmentGeometry alignment = Alignment.center,
    Axis? constrainedAxis,
  }) {
    return UnconstrainedBox(
      textDirection: textDirection,
      alignment: alignment,
      constrainedAxis: constrainedAxis,
      child: this,
    );
  }

  // anicontianer
  Widget animatedContainer({
    Duration? duration,
  }
      /*补齐参数
    super.key,
    this.alignment,
    this.padding,
    Color? color,
    Decoration? decoration,
    this.foregroundDecoration,
    double? width,
    double? height,
    BoxConstraints? constraints,
    this.margin,
    this.transform,
    this.transformAlignment,
    this.child,
    this.clipBehavior = Clip.none,
    super.curve,
    required super.duration,
  */
      ) {
    return AnimatedContainer(
      duration: duration ?? Duration(seconds: 1),
      child: this,
      /*  super.key,
    this.alignment,
    this.padding,
    Color? color,
    Decoration? decoration,
    this.foregroundDecoration,
    double? width,
    double? height,
    BoxConstraints? constraints,
    this.margin,
    this.transform,
    this.transformAlignment,
    this.child,
    this.clipBehavior = Clip.none,
    super.curve,
    required super.duration,/)*/
    );
  }

  Widget boxConstraints({
    double? minWidth,
    double? maxWidth,
    double? minHeight,
    double? maxHeight,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minWidth ?? 0.0,
        maxWidth: maxWidth ?? double.infinity,
        minHeight: minHeight ?? 0.0,
        maxHeight: maxHeight ?? double.infinity,
      ),
      child: this,
    );
  }

  Widget constrained(BoxConstraints? constraints) {
    if (constraints == null) return this;
    return ConstrainedBox(
      constraints: constraints,
      child: this,
    );
  }

  Widget limitBox({
    double? maxWidth,
    double? maxHeight,
  }) {
    return LimitedBox(
      maxWidth: maxWidth ?? double.infinity,
      maxHeight: maxHeight ?? double.infinity,
      child: this,
    );
  }

  Widget align({
    AlignmentGeometry alignment = Alignment.center,
    double? widthFactor,
    double? heightFactor,
  }) {
    return Align(
      alignment: alignment,
      widthFactor: widthFactor,
      heightFactor: heightFactor,
      child: this,
    );
  }

  // stack
  Widget stack({
    AlignmentGeometry alignment = AlignmentDirectional.topStart,
    TextDirection? textDirection,
    StackFit fit = StackFit.loose,
    Clip clipBehavior = Clip.none,
    required List<Widget> Function(Widget child) supplier,
  }) {
    return Stack(
      alignment: alignment,
      textDirection: textDirection,
      fit: fit,
      clipBehavior: clipBehavior,
      children: supplier(this),
    );
  }

  // textFieldTapRegion
  Widget textFieldTapRegion({
    TapRegionCallback? onTapOutside,
    TapRegionCallback? onTapInside,
  }) {
    return TextFieldTapRegion(
      onTapOutside: onTapOutside,
      onTapInside: onTapInside,
      child: this,
    );
  }

// center
  Widget center({double? widthFactor, double? heightFactor}) {
    return Center(
      widthFactor: widthFactor,
      heightFactor: heightFactor,
      child: this,
    );
  }

  // LayoutBuilder
  Widget layoutBuilder(void Function(BoxConstraints) onConstraints, [Widget Function(Widget)? builder]) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        onConstraints.call(constraints);
        return builder?.call(this) ?? this;
      },
    );
  }

  //FocusScope
  Widget focusScope({
    FocusScopeNode? node,
    bool autofocus = false,
    bool canRequestFocus = true,
    bool skipTraversal = false,
    String? debugLabel,
  }) {
    return FocusScope(
      node: node,
      autofocus: autofocus,
      canRequestFocus: canRequestFocus,
      skipTraversal: skipTraversal,
      debugLabel: debugLabel,
      child: this,
    );
  }

  Widget doublePress(bool Function(RawKeyEvent) predict, void Function(RawKeyEvent) onHint) {
    final maxHint = 2;
    var hint = maxHint;
    DateTime? lastTime;
    return Focus(
      child: this,
      onKey: (focusNode, key) {
        if (key is RawKeyDownEvent && predict.call(key)) {
          hint--;
          late var res = KeyEventResult.ignored;
          if (lastTime != null && DateTime.now().difference(lastTime!) <= Duration(milliseconds: 300) && hint <= 0) {
            onHint.call(key);
            hint = maxHint;
            res = KeyEventResult.handled;
          } else if /*时间间隔过长*/ (lastTime != null && DateTime.now().difference(lastTime!) > Duration(milliseconds: 300)) {
            hint = maxHint - 1;
          }
          lastTime = DateTime.now();
          return res;
        } else {
          return KeyEventResult.ignored;
        }
      },
    );
  }

  // Focus
  Widget focus({
    FocusNode? focusNode,
    FocusNode? parentNode,
    bool autofocus = false,
    ValueChanged<bool>? onFocusChange,
    FocusOnKeyEventCallback? onKeyEvent,
    FocusOnKeyCallback? onKey,
    bool? canRequestFocus,
    bool? skipTraversal,
    bool? descendantsAreFocusable,
    bool? descendantsAreTraversable,
    bool includeSemantics = true,
    String? debugLabel,
  }) {
    return Focus(
        focusNode: focusNode,
        parentNode: parentNode,
        autofocus: autofocus,
        onFocusChange: onFocusChange,
        onKeyEvent: onKeyEvent,
        onKey: onKey,
        canRequestFocus: canRequestFocus,
        skipTraversal: skipTraversal,
        descendantsAreFocusable: descendantsAreFocusable,
        descendantsAreTraversable: descendantsAreTraversable,
        includeSemantics: includeSemantics,
        debugLabel: debugLabel,
        child: this);
  }

  // FocusTraversalGroup
  Widget easyFocusTraversal({
    FocusTraversalPolicy? policy,
    bool descendantsAreFocusable = true,
    bool descendantsAreTraversable = true,
  }) {
    return FocusTraversalGroup(
      descendantsAreFocusable: descendantsAreFocusable,
      policy: policy,
      descendantsAreTraversable: descendantsAreTraversable,
      child: this,
    );
  }

  Widget easyTap({
    VoidCallback? onTap,
    VoidCallback? onDoubleTap,
    VoidCallback? onLongPress,
    VoidCallback? onSecondaryTap,
    GestureDragUpdateCallback? onPanUpdate,
    String? tooltip,
  }) {
    return GestureDetector(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      onSecondaryTap: onSecondaryTap,
      onPanUpdate: onPanUpdate,
      child: () {
        if (tooltip == null) return this;
        return Tooltip(
          message: tooltip,
          child: this,
        );
      }(),
    );
  }
}

/// add Padding Property to widget
extension WidgetPaddingX on Widget {
  Widget paddingAll(double padding) => Padding(padding: EdgeInsets.all(padding), child: this);

  Widget paddingSymmetric({double horizontal = 0.0, double vertical = 0.0}) =>
      Padding(padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical), child: this);

  Widget paddingOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) =>
      Padding(padding: EdgeInsets.only(top: top, left: left, right: right, bottom: bottom), child: this);

  Widget get paddingZero => Padding(padding: EdgeInsets.zero, child: this);
}

/// Add margin property to widget
extension WidgetMarginX on Widget {
  Widget marginAll(double margin) => Container(margin: EdgeInsets.all(margin), child: this);

  Widget marginSymmetric({double horizontal = 0.0, double vertical = 0.0}) =>
      Container(margin: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical), child: this);

  Widget marginOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) =>
      Container(margin: EdgeInsets.only(top: top, left: left, right: right, bottom: bottom), child: this);

  Widget get marginZero => Container(margin: EdgeInsets.zero, child: this);
}

/// Allows you to insert widgets inside a CustomScrollView
extension WidgetSliverBoxX on Widget {
  Widget get sliverBox => SliverToBoxAdapter(child: this);
}
