//
//  DetailCell.h
//  TableView_RightMenu
//
//  Created by yuedongkui on 2017/7/3.
//  Copyright © 2017年 LYue. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DetailCell : NSTableCellView

- (void)configContentWithTitle:(NSString *)title detail:(NSString *)detail;

@end
