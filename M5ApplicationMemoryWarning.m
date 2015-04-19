//
//  M5ApplicationMemoryWarning.m
//  M5ApplicationMemoryWarning
//

#import "M5ApplicationMemoryWarning.h"

#import <TargetConditionals.h>

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#else
#import <Cocoa/Cocoa.h>
#endif

@implementation M5ApplicationMemoryWarning

#pragma mark - M5ApplicationMemoryWarning -

#pragma mark Properties

+ (NSString *)notificationName {
    return NSStringFromClass(self);
}

#pragma mark -

#pragma mark - NSObject -

#pragma mark Methods

+ (void)initialize {
    if (self == M5ApplicationMemoryWarning.class) {
        #if TARGET_OS_IPHONE
        [NSNotificationCenter.defaultCenter addObserverForName:UIApplicationDidReceiveMemoryWarningNotification object:UIApplication.sharedApplication queue:nil usingBlock:^(NSNotification *note) {
            [NSNotificationCenter.defaultCenter postNotificationName:self.notificationName object:nil userInfo:nil];
        }];
        #else
        static dispatch_source_t source = nil;
        source = dispatch_source_create(DISPATCH_SOURCE_TYPE_MEMORYPRESSURE, 0, DISPATCH_MEMORYPRESSURE_WARN | DISPATCH_MEMORYPRESSURE_CRITICAL, dispatch_get_main_queue());
        
        dispatch_source_set_event_handler(source, ^{
            dispatch_source_memorypressure_flags_t pressureLevel = dispatch_source_get_data(source);
            
            [NSNotificationCenter.defaultCenter postNotificationName:self.notificationName object:nil userInfo:@{ @"pressure": @(pressureLevel) }];
        });
        
        dispatch_resume(source);
        #endif
    }
}

#pragma mark -

@end
