#import "SharedPreferencesPlugin.h"
#if __has_include(<shared_preferences/shared_preferences-Swift.h>)
#import <shared_preferences/shared_preferences-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "shared_preferences-Swift.h"
#endif

@implementation SharedPreferencesPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSharedPreferencesPlugin registerWithRegistrar:registrar];
}
@end
