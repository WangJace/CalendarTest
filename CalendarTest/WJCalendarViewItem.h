//
//  WJCalendarViewItem.h
//  CalendarTest
//
//  Created by Jace on 06/07/16.
//  Copyright © 2016年 Jace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJCalendarItem.h"

IB_DESIGNABLE

@interface WJCalendarViewItem : UIView

@property (nonatomic, copy) void(^WJCalendarViewActionBlock)(NSUInteger, NSUInteger);
@property (nonatomic, strong) WJCalendarItem *model;

@end
