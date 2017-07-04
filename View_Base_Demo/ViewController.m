//
//  ViewController.m
//  View_Base_Demo
//
//  Created by yuedongkui on 2017/7/3.
//  Copyright © 2017年 LYue. All rights reserved.
//

#import "ViewController.h"
#import "DetailCell.h"
#import "MyItem.h"


@interface ViewController ()<NSTableViewDelegate, NSTableViewDataSource>
@property (nonatomic, strong) NSTableView *table;
@property (nonatomic, strong) NSArray *lists;
@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *mArr = [NSMutableArray array];
    for (int i=0; i<100; i++) {
        MyItem *item = [[MyItem alloc] init];
        item.title = [NSString stringWithFormat:@"第%d行 （双击缩放）", i];
        item.detail = @"松岛枫色看单价发了烧烤店讲故事了的空间发了可接受的离开家发送到了空间是看来大家发了可接受的看来就个了十大科技可连接发的是了健康发送到了看就富";
        [mArr addObject:item];
    }
    _lists = [mArr copy];
    
    //tableView必须放到一个ScrollView里作为容器
    NSScrollView *scroll = [[NSScrollView alloc] initWithFrame:NSMakeRect(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scroll.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;//放大缩小窗口时，tableview跟着动
    
    _table = [[NSTableView alloc] initWithFrame:NSMakeRect(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    //    [_table setHeaderView:nil]; //隐藏header
    _table.delegate = self;
    _table.dataSource = self;
    [_table setUsesAlternatingRowBackgroundColors:NO];//是否用渐变效果
    
    //
    NSTableColumn *column1 = [[NSTableColumn alloc] initWithIdentifier:@"Identifier1"];
//    NSTableColumn *column2 = [[NSTableColumn alloc] initWithIdentifier:@"Identifier2"];
//    NSTableColumn *column3 = [[NSTableColumn alloc] initWithIdentifier:@"Identifier2"];
    
    [column1 setTitle:@"column1"];
//    [column2 setTitle:@"column2"];
//    [column3 setTitle:@"column3"];
    
    [column1 setMinWidth:MAXFLOAT];
    [column1 setMaxWidth:MAXFLOAT];
//    [column2 setMinWidth:40];
//    [column2 setMaxWidth:100];
//    [column3 setMinWidth:40];
//    [column3 setMaxWidth:100];
    
    [_table addTableColumn:column1];
//    [_table addTableColumn:column2];
//    [_table addTableColumn:column3];
    
    [scroll setDocumentView:_table];
    [self.view addSubview:scroll];
    
    [self.table setDoubleAction:@selector(tableViewDidDoubleClickAction:)];

    [_table setAllowsMultipleSelection:YES];
//    [_table selectAll:nil];
}


#pragma mark - NSTableViewDelegate & NSTableViewDataSource

//数组数量
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return _lists.count;
}

//返回每一行的内容
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSLog(@"%s", __FUNCTION__);

    static NSString *indentifier = @"mycell";
    DetailCell *cell = [tableView makeViewWithIdentifier:indentifier owner:self];
    if (cell == nil) {
        cell = [[DetailCell alloc] initWithFrame:NSMakeRect(0, 0, _table.bounds.size.width, 300)];
        cell.identifier = indentifier;
    }
    
    MyItem *item = _lists[row];
    [cell configContentWithTitle:item.title
                          detail:item.detail];
    
    return cell;
}

//cell高度
- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
    NSLog(@"%s", __FUNCTION__);

    MyItem *item = _lists[row];
    return item.isSelected ? 200 : 40;
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

#pragma mark -
- (void)tableViewDidDoubleClickAction:(NSTableView *)table
{
    NSIndexSet *indexSet = [table.selectedRowIndexes copy];
    
    NSArray *items = [_lists objectsAtIndexes:table.selectedRowIndexes];
    if (items.count > 0) {
        MyItem *item = items.lastObject;
        item.isSelected = !item.isSelected;
        [table reloadData];
        
        [table selectRowIndexes:indexSet byExtendingSelection:NO];
    }
}


@end
