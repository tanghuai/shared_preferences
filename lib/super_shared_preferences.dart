import 'dart:async';

import 'package:flutter/services.dart';

class SharedPreferences {
  static const MethodChannel _channel =
      const MethodChannel("plugin.flutter.io/shared_preferences");
  static Map<String, SharedPreferences> _singletons = Map();

  static SharedPreferences instance({String sharedName = "parameter"}) {
    if (_singletons.containsKey(sharedName)) {
    } else {
      _singletons[sharedName] = SharedPreferences.initWithName(sharedName);
    }
    return _singletons[sharedName];
  }

  String sharedName = SharedNames.defaultName;

  SharedPreferences.initWithName(String sharedName) {
    this.sharedName = sharedName;
    _singletons[sharedName] = this;
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

  Future<T> getValue<T>(String key, {T defValue}) async {
    final T value = await _channel.invokeMethod(
        'getValue',
        _buildArguments(
          key,
          defValue: defValue,
          sharedName: sharedName,
        ));
    return value;
  }

  Future<void> setValue<T>(String key, T value) async {
    await _channel.invokeMethod("setValue", <String, dynamic>{
      "key": key,
      "value": value,
      "sharedName": sharedName
    });
  }
}

///缓存文件的名称维护
///可以添加不同的缓存文件 直接加就可以
///调用方式SharedPreferences.instance() 可以从默认的parameter.xml缓存文件中取值了
///参数shareName非必传，不传取默认值
class SharedNames {
  static const defaultName = "parameter";
}
