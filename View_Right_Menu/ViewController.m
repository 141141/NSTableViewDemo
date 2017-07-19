//
//  ViewController.m
//  View_Right_Menu
//
//  Created by yuedongkui on 2017/7/18.
//  Copyright © 2017年 LYue. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSMenuDelegate>

@property (weak) IBOutlet NSView *customView;
@property (nonatomic, strong) NSMenu *rightClickMenu;

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.customView.wantsLayer = YES;
    self.customView.layer.backgroundColor = [[NSColor redColor] CGColor];
    
    self.rightClickMenu = [[NSMenu alloc] init];
    self.rightClickMenu.delegate = self;
    NSMenuItem *item1 = [[NSMenuItem alloc] initWithTitle:@"打开" action:@selector(oepnFile:) keyEquivalent:@""];
    NSMenuItem *item2 = [[NSMenuItem alloc] initWithTitle:@"删除" action:@selector(deleteMusic:) keyEquivalent:@""];
    NSMenuItem *item3 = [[NSMenuItem alloc] initWithTitle:@"下一首" action:@selector(playNextMusic:) keyEquivalent:@""];
    [item1 setTarget:self];
    [item2 setTarget:self];
    [item3 setTarget:self];
    [self.rightClickMenu addItem:item1];
    [self.rightClickMenu addItem:[NSMenuItem separatorItem]];
    [self.rightClickMenu addItem:item2];
    [self.rightClickMenu addItem:[NSMenuItem separatorItem]];
    [self.rightClickMenu addItem:item3];
    self.customView.menu = self.rightClickMenu;
}

#pragma mark -
- (void)oepnFile:(id)sender
{
    NSOpenPanel* panel = [NSOpenPanel openPanel];
    [panel setAllowsMultipleSelection:NO];
    [panel setCanChooseDirectories:YES];
    [panel setCanChooseFiles:NO];
    [panel setCanCreateDirectories:YES];
    [panel setAllowsMultipleSelection:NO];
    [panel setPrompt:@"打开文件"];
    [panel beginSheetModalForWindow: self.view.window completionHandler:^(NSModalResponse returnCode) {
        if (returnCode == NSFileHandlingPanelOKButton) {
            NSLog(@"---打开文件---， %@", [panel URLs]);
        }
    }];
}

- (void)deleteMusic:(id)sender
{
    NSLog(@"---删除---");
}

- (void)playNextMusic:(id)sender
{
    NSLog(@"---下一首---");
}

#pragma mark -
//决定菜单是否可用（置灰），每次右键都会调用，有几个 item 就调用几次
- (BOOL)validateMenuItem:(NSMenuItem *)menuItem
{
    NSLog(@"%s", __FUNCTION__);
    if ([menuItem.title isEqualToString:@"删除"]) {
        return NO;
    }
    return YES;
}
@end
