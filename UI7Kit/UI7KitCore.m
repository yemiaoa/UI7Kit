//
//  UI7KitCore.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 18..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7KitCore.h"

@implementation UI7Kit

@synthesize tintColor=_tintColor;

UI7Kit *UI7KitSharedObject = nil;

- (id)init {
    self = [super init];
    if (self != nil) {
        self.tintColor = [UIColor colorWith8bitRed:0 green:126 blue:245 alpha:255];
    }
    return self;
}

+ (UI7Kit *)kit {
    return UI7KitSharedObject;
}

+ (void)initialize {
    if (self == [UI7Kit class]) {
        UI7KitSharedObject = [[UI7Kit alloc] init];
    }
}

+ (void)patch {
    for (NSString *className in @[
         @"UI7ViewController",
         @"UI7TableView",
         @"UI7TableViewCell",
         @"UI7BarButtonItem",
         @"UI7NavigationBar",
         @"UI7NavigationController",
         @"UI7Button",
         @"UI7Switch",
         @"UI7AlertView",
         @"UI7ActionSheet",
         @"UI7TabBar",
         @"UI7TabBarItem",
         @"UI7SegmentedControl",
         ]) {
        Class class = NSClassFromString(className);
        [class patch];
        #if DEBUG
        NSLog(@"patched? %@", [class name]);
        assert([class respondsToSelector:@selector(patchIfNeeded)]);
        #endif
    }
}

@end


@implementation NSObject (UI7KitPatch)

+ (void)patchIfNeeded {
    if ([[UIDevice currentDevice] needsUI7Kit]) {
        [(id<UI7Patch>)self patch];
    }
}

@end
