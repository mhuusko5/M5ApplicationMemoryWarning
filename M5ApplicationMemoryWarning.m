//
//  M5ApplicationMemoryWarning.m
//  M5ApplicationMemoryWarning
//
//  Created by Mathew Huusko V.
//  Copyright (c) 2015 Radeeus. All rights reserved.
//

#import "M5ApplicationMemoryWarning.h"

#import "TargetConditionals.h"

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#else
#import <Cocoa/Cocoa.h>
#endif

#pragma mark - M5ApplicationMemoryWarning -

#pragma mark Fields

NSString* const kM5ApplicationDidReceiveMemoryWarningNotification = @"M5ApplicationDidReceiveMemoryWarningNotification";

#pragma mark -

#pragma mark - M5ApplicationMemoryWarning (Private) -

#pragma mark Functions

__attribute__((constructor)) static void M5InstallLowMemoryNotification(void) {
    #if TARGET_OS_IPHONE
    [NSNotificationCenter.defaultCenter addObserverForName:UIApplicationDidReceiveMemoryWarningNotification object:UIApplication.sharedApplication queue:nil usingBlock:^(NSNotification *note) {
        [NSNotificationCenter.defaultCenter postNotificationName:kM5ApplicationDidReceiveMemoryWarningNotification object:nil userInfo:nil];
    }];
    #else
    static dispatch_source_t source = nil;
    source = dispatch_source_create(DISPATCH_SOURCE_TYPE_MEMORYPRESSURE, 0, DISPATCH_MEMORYPRESSURE_WARN | DISPATCH_MEMORYPRESSURE_CRITICAL, dispatch_get_main_queue());
    
    dispatch_source_set_event_handler(source, ^{
        dispatch_source_memorypressure_flags_t pressureLevel = dispatch_source_get_data(source);
        
        [NSNotificationCenter.defaultCenter postNotificationName:kM5ApplicationDidReceiveMemoryWarningNotification object:nil userInfo:@{ @"pressure": @(pressureLevel) }];
    });
    
    dispatch_resume(source);
    #endif
}

#pragma mark -
