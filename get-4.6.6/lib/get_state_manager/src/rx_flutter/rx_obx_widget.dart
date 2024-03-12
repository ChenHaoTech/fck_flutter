import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../../get_rx/src/rx_types/rx_types.dart';

typedef WidgetCallback = Widget Function();

/// The [ObxWidget] is the base for all GetX reactive widgets
///
/// See also:
/// - [Obx]
/// - [ObxValue]
abstract class ObxWidget extends StatefulWidget {
  final String? debug;
  final bool enable;

  const ObxWidget({Key? key, this.debug, this.enable = true}) : super(key: key);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty<Function>.has('builder', build));
  }

  @override
  ObxState createState() => ObxState();

  @protected
  Widget build();
}

class ObxState extends State<ObxWidget> {
  final _observer = RxNotifier();
  late StreamSubscription subs;

  @override
  void initState() {
    super.initState();
    _observer.debug = widget.debug;
    subs = _observer.listen((_) async {
      await _buildComplete?.future;
      _updateTree(_);
    }, cancelOnError: false);
  }

  void _updateTree(_) {
    if (mounted) {
      if (widget.debug != null) {
        debugPrint("[ObxWidget][${widget.debug}]update by rx($_observer)");
      }
      setState(() {});
    }
  }

  @override
  void dispose() {
    subs.cancel();
    _observer.close();
    super.dispose();
  }

  Completer? _buildComplete;

  @override
  Widget build(BuildContext context) {
    _buildComplete = Completer();
    Widget res;
    if (!widget.enable) res = widget.build();
    res = RxInterface.notifyChildren(_observer, widget.build);
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      if (_buildComplete?.isCompleted ?? false) return;
      _buildComplete?.complete();
    });
    return res;
  }
}

/// The simplest reactive widget in GetX.
///
/// Just pass your Rx variable in the root scope of the callback to have it
/// automatically registered for changes.
///
/// final _name = "GetX".obs;
/// Obx(() => Text( _name.value )),... ;
class Obx extends ObxWidget {
  final WidgetCallback builder;

  const Obx(this.builder, {Key? key, String? debug, bool enable = true}) : super(key: key, debug: debug, enable: enable);

  @override
  Widget build() => builder();
}

/// Similar to Obx, but manages a local state.
/// Pass the initial data in constructor.
/// Useful for simple local states, like toggles, visibility, themes,
/// button states, etc.
///  Sample:
///    ObxValue((data) => Switch(
///      value: data.value,
///      onChanged: (flag) => data.value = flag,
///    ),
///    false.obs,
///   ),
class ObxValue<T extends RxInterface> extends ObxWidget {
  final Widget Function(T) builder;
  final T data;

  const ObxValue(this.builder, this.data, {Key? key, String? debug}) : super(key: key, debug: debug);

  @override
  Widget build() => builder(data);
}
