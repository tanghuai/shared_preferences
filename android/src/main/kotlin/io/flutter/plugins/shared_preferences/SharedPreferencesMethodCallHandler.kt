package io.flutter.plugin.shared_preferences

import android.content.Context
import android.content.SharedPreferences
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class SharedPreferencesMethodCallHandler(var context: Context) : MethodChannel.MethodCallHandler {


    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {

        val method: String = call.method
        val key: String? = call.argument("key")
        val sharedName: String? = call.argument("sharedName")
        val type: String? = call.argument("type")

        if (sharedName == null) {
            result.error("UNAVAILABLE", "没有获取到shareName参数", null)
            return
        }

        val sharedPreferences: SharedPreferences = context.getSharedPreferences(sharedName, Context.MODE_PRIVATE);

        if (method == "getValue") {
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
                    if (defValue == null) {
                        defValue = 0;
                    }
                    val value = try {
                        sharedPreferences.getInt(key, defValue as Int)
                    } catch (e: Exception) {
                        sharedPreferences.getLong(key, defValue as Long)
                    }
                    result.success(value)
                }
                "double" -> {
                    if (defValue == null) {
                        defValue = false;
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
        } else if (method == "setValue") {
            when (val value: Any? = call.argument("value")) {
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

    }
}