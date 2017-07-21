//
//  ViewController.m
//  TableView_RightMenu
//
//  Created by 老岳 on 16/5/30.
//  Copyright © 2016年 LYue. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSTabViewDelegate, NSTableViewDataSource>
{
    NSMutableArray *_lists;
}

@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _lists = [@[@"111", @"222", @"333", @"444", @"555", @"666"] mutableCopy];
    
    NSScrollView *scroll = [[NSScrollView alloc] initWithFrame:NSMakeRect(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scroll.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;//
    
    _table = [[NSTableView alloc] initWithFrame:NSMakeRect(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _table.delegate = self;
    _table.dataSource = self;
    _table.allowsMultipleSelection = YES;
    [_table setUsesAlternatingRowBackgroundColors:YES];
    
    
    //
    NSTableColumn *column1 = [[NSTableColumn alloc] initWithIdentifier:@"Identifier1"];
    [column1 setTitle:@"column1"];
    [column1 setMinWidth:40];
    [column1 setMaxWidth:100];
    [_table addTableColumn:column1];
    
    [scroll setDocumentView:_table];
    [self.view addSubview:scroll];
    
    // 1.将 _table 置为拖拽源
    [_table setDraggingSourceOperationMask:NSDragOperationEvery forLocal:NO];
}

#pragma mark - 拖拽

// 2.拖拽时需写入啥对象到剪贴板里，在拖拽某行时，告诉TableView应写入啥对象
// 该对象若是自定义对象，需要实现 NSPasteboardWriting 协议
- (id <NSPasteboardWriting>)tableView:(NSTableView *)tableView pasteboardWriterForRow:(NSInteger)row
{
    NSString *str = _lists[row];
    return str;
}

//- (BOOL)tableView:(NSTableView *)tv writeRowsWithIndexes:(NSIndexSet *)rowIndexes toPasteboard:(NSPasteboard*)pboard
//{
//    NSLog(@"%s", __FUNCTION__);
//
//    //需要把object转为data
////    [pboard declareTypes:[NSArray arrayWithObject:NSStringPboardType] owner:self];
//    
//
//    [pboard setPropertyList:@[@".mp3"] forType:NSFilenamesPboardType];
//
////    NSData *zNSIndexSetData = [NSKeyedArchiver archivedDataWithRootObject:rowIndexes];
////    [pboard declareTypes:[NSArray arrayWithObject:NSFilenamesPboardType] owner:self];
////    [pboard setData:zNSIndexSetData forType:NSFilenamesPboardType];
//    return YES;
//}222

//- (NSArray *)tableView:(NSTableView *)aTableView namesOfPromisedFilesDroppedAtDestination:(NSURL *)dropDestination forDraggedRowsWithIndexes:(NSIndexSet *)indexSet
//{
//    NSLog(@"%s", __FUNCTION__);
//
//    return nil;
//}

#pragma mark - NSTableViewDelegate & NSTableViewDataSource

//数组数量
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return _lists.count;
}

//返回每一行的内容
- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    return [NSString stringWithFormat:@"%@", _lists[rowIndex]];
}

//cell字体、字号等
- (void)tableView:(NSTableView *)aTableView willDisplayCell:(id)aCell forTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    NSTextFieldCell *tcell = (NSTextFieldCell*)aCell;
    [tcell setTextColor:[NSColor redColor]];
    [tcell setFont:[NSFont systemFontOfSize:14]];
    
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
    return 30;
}

//选中时调用
- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
    NSTableView *table = notification.object;
    NSInteger index = table.selectedRow;
    NSLog(@"index --- %ld", index);
}

@end

