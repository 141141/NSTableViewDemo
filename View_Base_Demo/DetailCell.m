//
//  DetailCell.m
//  TableView_RightMenu
//
//  Created by yuedongkui on 2017/7/3.
//  Copyright © 2017年 LYue. All rights reserved.
//

#import "DetailCell.h"

@interface DetailCell ()

@property (nonatomic, strong) NSTextField *titleField;
@property (nonatomic, strong) NSTextField *detailField;

@end


@implementation DetailCell

- (instancetype)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _titleField = [[NSTextField alloc] initWithFrame:NSMakeRect(10, 10, self.bounds.size.width-20, 40)];
        _titleField.editable = NO;
        _detailField.bordered = NO;
        [self addSubview:_titleField];
        
        _detailField = [[NSTextField alloc] initWithFrame:NSMakeRect(10, 50, self.bounds.size.width-20, 160)];
        _detailField.editable = NO;
        _detailField.bordered = NO;
        [self addSubview:_detailField];
        
        //////////////
//        _titleField.backgroundColor = [NSColor redColor];
        //////////////
    }
    return self;
}

- (void)configContentWithTitle:(NSString *)title detail:(NSString *)detail
{
    self.titleField.stringValue = title;
    self.detailField.stringValue = detail;
}

- (BOOL)isFlipped
{
    return YES;
}

@end
