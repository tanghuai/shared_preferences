import 'dart:async';

import 'package:flutter/services.dart';

/// 缓存类，对应源生缓存
/// android--------直接访问android源生sharePres缓存
/// ios---------待完善
class SharedPreferences {
  static const MethodChannel _channel =
      const MethodChannel("plugins.flutter.io/shared_preferences");
  static Map<String, SharedPreferences> _singletons = Map();

  static SharedPreferences instance({String sharedName = "parameter"}) {
    if (_singletons.containsKey(sharedName)) {
    } else {
      _singletons[sharedName] = SharedPreferences._initWithName(sharedName);
    }
    return _singletons[sharedName];
  }

  //对应android源生 SharePreferences 文件名
  final String _sharedName;

  SharedPreferences._initWithName(this._sharedName) {
    _singletons[_sharedName] = this;
  }

  Map<String, dynamic> _buildArguments<T>(String key,
      {T defValue, String sharedName}) {
    if (defValue == null) {
      return {"key": key, "sharedName": sharedName, "type": T.toString()};
    }
    return {
      "key": key,
      "defValue": defValue,
      "sharedName": sharedName,
      "type": T.toString()
    };
  }

  /// 获取key对应value值
  /// @key 缓存key值
  /// @defaultValue 默认值
  /// @return 返回值<T>
  Future<T> getValue<T>(String key, {T defValue}) async {
    final T value = await _channel.invokeMethod(
        'getValue',
        _buildArguments(
          key,
          defValue: defValue,
          sharedName: _sharedName,
        ));
    return value;
  }

  /// 添加key-value对
  /// @key 缓存key值
  /// @value<T> 缓存值
  Future<void> setValue<T>(String key, T value) async {
    await _channel.invokeMethod("setValue", <String, dynamic>{
      "key": key,
      "value": value,
      "sharedName": _sharedName
    });
  }

  /// 根据key移除对应value
  /// @key 缓存key值
  Future<void> remove(String key) async {
    await _channel.invokeMethod("remove", <String, dynamic>{"key": key});
  }

  /// 清空所有缓存键值对
  Future<void> clear() async {
    await _channel.invokeMethod(
      "clear",
    );
  }
}

///缓存文件的名称维护
///可以添加不同的缓存文件 直接加就可以
///调用方式SharedPreferences.instance() 可以从默认的parameter.xml缓存文件中取值了
///参数shareName非必传，不传取默认值
class SharedNames {
  static const defaultName = "parameter";
}
