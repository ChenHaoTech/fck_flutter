import 'package:flutter/material.dart';

class FnStatefulBuilder extends StatefulWidget {
  final void Function()? onInit;
  final Function()? onDispose;
  final Function()? onReassemble;
  final Function()? onChangeDependencies;
  final Function()? onUpdateWidget;
  final bool wantKeepAlive;
  final StatefulWidgetBuilder builder;

  const FnStatefulBuilder({
    super.key,
    this.onInit,
    this.onDispose,
    required this.builder,
    this.wantKeepAlive = false,
    this.onReassemble,
    this.onChangeDependencies,
    this.onUpdateWidget,
  });

  @override
  State<FnStatefulBuilder> createState() => FnStatefulBuilderState();
}

typedef FnStatefulWidgetBuilder = Widget Function(BuildContext context, StateSetter setState);

class FnStatefulBuilderState extends State<FnStatefulBuilder> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.builder(context, setState);
  }

  @override
  void didUpdateWidget(FnStatefulBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.onUpdateWidget?.call();
  }

  @override
  void initState() {
    super.initState();
    widget.onInit?.call();
  }

  @override
  void dispose() {
    super.dispose();
    widget.onDispose?.call();
  }

  @override
  bool get wantKeepAlive => widget.wantKeepAlive;

  @override
  void reassemble() {
    super.reassemble();
    widget.onReassemble?.call();
  }

  @override
  void activate() {
    super.activate();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.onChangeDependencies?.call();
  }
}
