/// 和UI 无关的扩展
///
library;

// 模仿 kotlin 实现 let、also、apply、run、with、takeIf、takeUnless
import 'dart:convert';
import 'package:collection/collection.dart';

extension ObjectExtensions<T> on T {
  R fnmap<R>(R mapper(T val)) {
    return mapper(this);
  }

  Future<T> asFuture() {
    return Future.value(this);
  }

  T addTo(List<T> iter) {
    iter.add(this);
    return this;
  }

  R let<R>(R Function(T it) block) => block(this);

  T apply(void Function(T it) block) {
    block(this);
    return this;
  }

  R run<R>(R Function(T it) block) => block(this);

  T? takeIf(bool Function(T it) predicate) {
    if (predicate(this)) {
      return this;
    }
    return null;
  }

  T? takeUnless(bool Function(T it) predicate) {
    if (!predicate(this)) {
      return this;
    }
    return null;
  }

  String toJsonStr() {
    return json.encode(this);
  }

  String get debugKey => "${this.runtimeType}_${this.hashCode}";
}

// 对于字符串 强转的 工具 toIntOrNull toFloatOrNull 等
extension FnStringExtension on String {
  int? toIntOrNull() {
    try {
      return int.parse(this);
    } catch (e) {
      return null;
    }
  }

  double? toDoubleOrNull() {
    try {
      return double.parse(this);
    } catch (e) {
      return null;
    }
  }
}

extension ListExt<T> on List<T> {
  // sum(int Function(T))
  num sum(num Function(T) func) {
    if (this.isEmpty) return 0;
    return this.map(func).reduce((value, element) => value + element);
  }

  // 保序 唯一
  List<T> unique({Set<T>? set, dynamic Function(T)? keyMapper}) {
    if (keyMapper != null) {
      //todo 待测试
      final ids = this.map((e) => keyMapper.call(e)).toSet();
      return this.toList(growable: true)..retainWhere((x) => ids.remove(keyMapper.call(x)));
    }
    return (set ?? this.toSet()).toList()..sort((a, b) => this.indexOf(a).compareTo(this.indexOf(b)));
  }

  void removeIn(Iterable iterable) {
    this.removeWhere((element) => iterable.contains(element));
  }

  int removeWhereExt(bool Function(T) predict) {
    var cnt = 0;
    this.removeWhere((item) {
      var res = predict.call(item);
      if (res) {
        cnt++;
      }
      return res;
    });
    return cnt;
  }

  //containWhere(bool Function(T) predict)
  bool replace(T origin, T target) {
    int index = this.indexOf(origin);
    if (index != -1) {
      this[index] = target;
      return true;
    }
    return false;
  }

  bool replaceWhere(bool Function(T) predict, T target) {
    int index = this.indexWhere(predict);
    if (index != -1) {
      this[index] = target;
      return true;
    }
    return false;
  }

  List<T> whereToList(bool Function(T) predict) {
    return this.where(predict).toList();
  }

  // checkIllegal({int idx}){
  bool checkIllegal({int idx = 0}) {
    if (idx < 0 || idx >= this.length) {
      return false;
    }
    return true;
  }

  // getNullable
  T? getNullable(int index) {
    return (index >= 0 && index < length) ? this[index] : null;
  }

  List<T> growable() {
    return this.toList(growable: true);
  }

  // justRange: 忽略 start 和 end 的相对大小, 取范围
  List<T> justRange(int start, int end) {
    start = start.clamp(0, this.length - 1);
    end = end.clamp(0, this.length - 1);
    return (start <= end) ? this.sublist(start, end) : this.sublist(end, start);
  }

  // containsAll(List<T> children)
  // 判断当前列表是否包含所有的子元素
  bool containsAll(List<T> children) {
    return children.every((child) => this.contains(child));
  }
}

extension IterableExt<T> on Iterable<T> {
  bool deepEqual<R>(Iterable<T> other, [R Function(T)? mapper]) {
    return DeepCollectionEquality().equals(() {
      if (mapper != null) {
        return this.map(mapper);
      } else {
        return this;
      }
    }(), () {
      if (mapper != null) {
        return other.map(mapper);
      } else {
        return other;
      }
    }());
  }

  //toggle(Item) 存在就删除, 不存在就加入
  void toggle(T? item) {
    if (item == null) return;
    if (this.contains(item)) {
      if (this is List) {
        (this as List).remove(item);
      } else if (this is Set) {
        (this as Set).remove(item);
      } else {
        throw "暂未实现";
      }
    } else {
      if (this is List) {
        (this as List).add(item);
      } else if (this is Set) {
        (this as Set).add(item);
      } else {
        throw "暂未实现";
      }
    }
  }

  Map<K, V> mapToMap<K, V>(K Function(T) keyMapper, V Function(T) valueMapper) {
    return {for (var item in this) keyMapper(item): valueMapper(item)};
  }

  // 根据自定义的function 校验获取两个列表的相同对象
  Iterable<T> fnIntersection(Iterable<T> other, bool Function(T a, T b)? predict) {
    return this.where((item) => other.any((otherItem) => predict?.call(item, otherItem) ?? item == otherItem));
  }

  // 每隔一个插入一个对象 T, 两两之间有 T
  List<T> insertBetween(T Function() element, {bool needSide = false}) {
    List<T> result = [];
    if (needSide) result.add(element.call());
    for (var item in this) {
      result
        ..add(item)
        ..add(element.call());
    }
    if (!needSide) result.removeLast(); // 移除最后一个多余的元素
    return result;
  }

  Iterable<T> combine(Iterable<T> other) {
    return this.followedBy(other);
  }

  // diff(List<T> other,Function(List<T>) onAdd,Function(List<T>) onDelete), 比对两个 this 列表的差异, 对其中的新增和 删除, 调用对应的回调函数
  void diff(Iterable<T> other, Function(List<T>) onAdd, Function(List<T>) onDelete) {
    final addedItems = other.where((item) => !contains(item)).toList();
    final deletedItems = where((item) => !other.contains(item)).toList();
    if (addedItems.isNotEmpty) {
      onAdd.call(addedItems);
    }
    if (deletedItems.isNotEmpty) {
      onDelete.call(deletedItems);
    }
  }

  void diffWithIdx(
    Iterable<T> other,
    Function(List<(int, T)>) onAdd,
    Function(List<(int, T)>) onDelete,
    Function(List<(int, int, T)>) onMove, {
    bool Function(T a, T b)? equalPredict,
  }) {
    List<(int, T)> addedItemsWithIdx = [];
    List<(int, T)> deletedItemsWithIdx = [];
    List<(int, int, T)> moveItemsWithIdx = [];
    List<T> thisList = this.toList();
    List<T> otherList = other.toList();
    bool _equal(T a, T b) {
      if (equalPredict != null) return equalPredict.call(a, b);
      return a == b;
    }

    for (int i = 0; i < thisList.length; i++) {
      var cur = thisList[i];
      var idx = otherList.indexWhere((i) => _equal(cur, i));
      if (idx == -1) {
        deletedItemsWithIdx.add((i, cur));
      } else if (idx != i) {
        moveItemsWithIdx.add((i, idx, cur));
      }
    }

    for (int i = 0; i < otherList.length; i++) {
      if (!thisList.any((element) => _equal(element, otherList[i]))) {
        addedItemsWithIdx.add((i, otherList[i]));
      }
    }

    onAdd.call(addedItemsWithIdx);
    onDelete.call(deletedItemsWithIdx);
    onMove.call(moveItemsWithIdx);
  }

  // diffReturn: 比对两个 this 列表的差异, 返回其中的新增和删除的元素
  (
    List<T> /*add*/,
    List<T> /*delete*/,
  ) diffReturnNewDelete(
    List<T> other, {
    bool Function(T a, T b)? equalPredict,
  }) {
    final addedItems = other.where((item) {
      if (equalPredict != null) {
        return !any((element) => equalPredict(element, item));
      }
      return !contains(item);
    }).toList();
    final deletedItems = where((item) {
      if (equalPredict != null) {
        return !other.any((element) => equalPredict(element, item));
      }
      return !other.contains(item);
    }).toList();
    return (addedItems, deletedItems);
  }
}

extension MapExt<K, V> on Map<K, V> {
  List<V> batchGet(Iterable<K> keys) {
    List<V> res = [];
    for (var key in keys) {
      this[key]?.let((it) {
        res.add(it);
      });
    }
    return res;
  }

  List<R> mapToList<R>(R Function(K, V) mapper) {
    return this.entries.map((entry) => mapper(entry.key, entry.value)).toList();
  }

  // 模仿 java compute
  Map<K, V> compute(K key, V Function(K key, V? value) computer) {
    var value = this[key];
    var res = computer.call(key, value);
    this[key] = res;
    return this;
  }

  Map<K, V> copyUpdate(K key, V Function(V?) mapper) {
    var res = Map<K, V>.from(this);
    res[key] = mapper(res[key]);
    return res;
  }
}

extension FutureExt<T> on Future<T> {
  void predictThen(bool Function(T) predict, T Function(T) then) {
    this.then((value) {
      if (predict(value)) {
        then(value);
      }
    });
  }
}

extension SetExt<T> on Set<T> {
  bool containsAny(Iterable<T> iterable) {
    return this.any((element) => iterable.contains(element));
  }
}
