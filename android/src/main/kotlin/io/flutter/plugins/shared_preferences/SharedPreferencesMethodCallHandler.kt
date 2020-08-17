package io.flutter.plugins.shared_preferences

import android.content.Context
import android.content.SharedPreferences
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class SharedPreferencesMethodCallHandler(private var context: Context) : MethodChannel.MethodCallHandler {

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {

        val method: String = call.method
        val key: String? = call.argument("key")
        val value: Any? = call.argument("value")
        val sharedName: String? = call.argument("sharedName")
        val type: String? = call.argument("type")

        if (sharedName == null) {
            result.error("UNAVAILABLE", "没有获取到shareName参数", null)
            return
        }

        val sharedPreferences: SharedPreferences = context.getSharedPreferences(sharedName, Context.MODE_PRIVATE);

        when (method) {
            "getValue" -> {
                var defValue: Any? = call.argument("defValue")
                when (type) {
                    "String" -> {
                        if (defValue == null) {
                            defValue = "";
                        }
                        val value = sharedPreferences.getString(key, defValue as String);
                        result.success(value)
                    }
                    "int" -> {
                        try {
                            if (defValue == null) {
                                defValue = 0;
                            }
                            val value = sharedPreferences.getInt(key, defValue as Int)
                            result.success(value)
                        } catch (e: Exception) {
                            if (defValue == null) {
                                defValue = 0l;
                            }
                            val value = sharedPreferences.getLong(key, defValue as Long)
                            result.success(value)
                        }
                    }
                    "double" -> {
                        if (defValue == null) {
                            defValue = 0f;
                        }
                        val value = sharedPreferences.getFloat(key, defValue as Float)
                        result.success(value)
                    }
                    "bool" -> {
                        if (defValue == null) {
                            defValue = false;
                        }
                        val value = sharedPreferences.getBoolean(key, defValue as Boolean)
                        result.success(value)
                    }
                }
            }
            "setValue" -> {
                when (value) {
                    is String -> {
                        sharedPreferences.edit().putString(key, value).apply()
                    }
                    is Int -> {
                        sharedPreferences.edit().putInt(key, value).apply()
                    }
                    is Float -> {
                        sharedPreferences.edit().putFloat(key, value).apply()
                    }
                    is Long -> {
                        sharedPreferences.edit().putLong(key, value).apply()
                    }
                    is Boolean -> {
                        sharedPreferences.edit().putBoolean(key, value).apply()
                    }
                }
            }
            "remove" -> {
                sharedPreferences.edit().remove(key).apply()
            }
            "clear" -> {
                sharedPreferences.edit().clear().apply()
            }
        }

    }
}