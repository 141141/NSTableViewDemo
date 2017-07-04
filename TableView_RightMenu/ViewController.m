//
//  ViewController.m
//  TableView_RightMenu
//
//  Created by 老岳 on 16/5/30.
//  Copyright © 2016年 LYue. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSTabViewDelegate, NSTableViewDataSource>

@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    NSTableColumn *column2 = [[NSTableColumn alloc] initWithIdentifier:@"Identifier2"];
    NSTableColumn *column3 = [[NSTableColumn alloc] initWithIdentifier:@"Identifier2"];
    
    [column1 setTitle:@"column1"];
    [column2 setTitle:@"column2"];
    [column3 setTitle:@"column3"];
    
    [column1 setMinWidth:40];
    [column1 setMaxWidth:100];
    [column2 setMinWidth:40];
    [column2 setMaxWidth:100];
    [column3 setMinWidth:40];
    [column3 setMaxWidth:100];

    [_table addTableColumn:column1];
    [_table addTableColumn:column2];
    [_table addTableColumn:column3];
    
    [scroll setDocumentView:_table];
    [self.view addSubview:scroll];
}

#pragma mark - NSTableViewDelegate & NSTableViewDataSource

//数组数量
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return 20;
}

//返回每一行的内容
- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    return [NSString stringWithFormat:@"cell NO. %ld", rowIndex];
}


//cell高度
- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
    return 30;
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

