# shared_preferences

a library that can read can write Android SharedPreference file use a fileName

#### 使用方法参考Android源生实现

```
    SharedPreferences.instance().setValue("string", "string-value");
    SharedPreferences.instance(sharedName: "shareName")
        .setValue("string", "string-value");

    SharedPreferences.instance().setValue("string", "string-value");
    SharedPreferences.instance().setValue("int", 10);
    SharedPreferences.instance().setValue("bool", true);
    SharedPreferences.instance().setValue("double", 1.01);

    String val1 = await SharedPreferences.instance().getValue("string");
    Double val2 = await SharedPreferences.instance().getValue("double");
    bool val3 = await SharedPreferences.instance().getValue("bool");
    int val4 = await SharedPreferences.instance().getValue("int");
```