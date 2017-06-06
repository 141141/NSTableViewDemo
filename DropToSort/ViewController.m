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
    
    // 1.设置 Table View 可以接受的 Drag Type
    [_table registerForDraggedTypes:@[NSStringPboardType]];
    // 2.设置一个拖动动画的参数
    _table.draggingDestinationFeedbackStyle = NSTableViewDraggingDestinationFeedbackStyleGap;
}

#pragma mark - 拖拽
// 3.此代理方法里写拖拽时的显示方式
- (NSDragOperation)tableView:(NSTableView *)tableView validateDrop:(id<NSDraggingInfo>)info proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)dropOperation
{
    if (dropOperation == NSTableViewDropAbove) {
        return NSDragOperationMove;
    }
    return NSDragOperationNone;
}

// 4.cell高度一定要加
- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
    return 30;
}

// 5.在用户 Drag 时，将需要的信息写到剪贴板上
- (BOOL)tableView:(NSTableView *)tableView writeRowsWithIndexes:(NSIndexSet *)rowIndexes toPasteboard:(NSPasteboard *)pboard
{
    [pboard declareTypes:[NSArray arrayWithObjects:NSStringPboardType, nil] owner:self];//定义存在剪切板的哪里，不加这句代码貌似拖拽不起作用
    NSArray *array = [_lists objectsAtIndexes:rowIndexes];//拖拽的列表数组
    [pboard setPropertyList:array forType:NSStringPboardType];
    
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSLog(@"%@ ", obj);
    }];

    return YES;
}

- (BOOL)tableView:(NSTableView *)tableView acceptDrop:(id<NSDraggingInfo>)info row:(NSInteger)row dropOperation:(NSTableViewDropOperation)dropOperation
{
    NSPasteboard *pboard = [info draggingPasteboard];
    NSArray *array = [pboard propertyListForType:NSStringPboardType];
    NSLog(@"array ===== %@， row=%ld", array, row);
    
    //将拖动中的元素都改为固定的字符串
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSUInteger index = [_lists indexOfObject:obj];
        [_lists replaceObjectAtIndex:index withObject:@"xxx"];
    }];
    NSLog(@"替换===%@,array =%@", _lists, array);
    
    //插入
    __block NSInteger index = row;
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [_lists insertObject:obj atIndex:index];
        index++;
    }];
    NSLog(@"插入====%@", _lists);
    
    //删除原来被替换的 @"xxx"
    [_lists removeObject:@"xxx"];
    NSLog(@"删除____%@", _lists);
    
    //刷新列表
    [_table reloadData];
    
    //取消选中
    [_table deselectAll:nil];
    
    return YES;
}


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

//选中时调用
- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
    NSTableView *table = notification.object;
    NSInteger index = table.selectedRow;
    NSLog(@"index --- %ld", index);
}

@end

