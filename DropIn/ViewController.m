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
    
    // 1.设置 Table View 可以接收的 Drag Type，对应 accept 的代理方法
    // NSFilenamesPboardType : 拖文件进来会执行代理
    // NSStringPboardType : 拖字符串进来会执行代理
    [_table registerForDraggedTypes:@[NSFilenamesPboardType, NSStringPboardType]];
}

#pragma mark - 拖拽
// 2.此代理方法里写拖拽时的显示方式
- (NSDragOperation)tableView:(NSTableView *)tableView validateDrop:(id<NSDraggingInfo>)info proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)dropOperation
{
//    NSLog(@"%s", __FUNCTION__);
//    NSPasteboard *pasteBoard = [info draggingPasteboard];
//    
//    //只支持某种文件格式的拖拽，如zip
//    if ([[pasteBoard types] containsObject:NSFilenamesPboardType])
//    {
//        NSString *supportFormat = @"zip"; //拉进来的文件只能为zip格式文件；
//        NSArray *paths = [pasteBoard propertyListForType:NSFilenamesPboardType];//将剪贴板上的url传进一个数组中
//        for (NSString *path in paths)
//        { //遍历
//            if ([supportFormat containsString:[path pathExtension]]) {
                return NSDragOperationCopy;//是zip文件，高亮状态；
//            }
//        }
//    }
    return NSDragOperationNone;
}

// 3.拖拽完成时的数据操作
- (BOOL)tableView:(NSTableView *)tableView acceptDrop:(id<NSDraggingInfo>)info row:(NSInteger)row dropOperation:(NSTableViewDropOperation)dropOperation
{
    NSLog(@"%s", __FUNCTION__);
    NSPasteboard *pasteBoard = [info draggingPasteboard];
    if ([[pasteBoard types] containsObject:NSFilenamesPboardType])
    {
        NSArray *paths = [pasteBoard propertyListForType:NSFilenamesPboardType];
        
        for (NSString *path in paths)
        {
            // 对路径中的汉字等特殊字符转码：stringByAddingPercentEscapesUsingEncoding:
            NSURL *url = [[NSURL alloc] initWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            NSLog(@"url = %@", url);
            //更新数据，刷新页面...
        }
        return YES;
    }
    return NO;
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

