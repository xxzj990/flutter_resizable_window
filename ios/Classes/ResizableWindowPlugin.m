#import "ResizableWindowPlugin.h"
#if __has_include(<resizable_window/resizable_window-Swift.h>)
#import <resizable_window/resizable_window-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "resizable_window-Swift.h"
#endif

@implementation ResizableWindowPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftResizableWindowPlugin registerWithRegistrar:registrar];
}
@end
