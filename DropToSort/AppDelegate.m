//
//  AppDelegate.m
//  DropToSort
//
//  Created by yuedongkui on 2017/6/6.
//  Copyright © 2017年 LYue. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application

    NSMutableArray *a = [@[@"111", @"111", @"222", @"333"] mutableCopy];
    NSLog(@"a= %@", a);

    [a removeObject:@"222"];
    NSLog(@"a= %@", a);
    [a removeObject:@"111"];
    NSLog(@"a= %@", a);
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
