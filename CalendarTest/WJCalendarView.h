//
//  WJCalendarView.h
//  CalendarTest
//
//  Created by Jace on 05/07/16.
//  Copyright © 2016年 Jace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJCalendarViewItem.h"

IB_DESIGNABLE

@class WJCalendarView;

@protocol WJCalendarViewDataSource <NSObject>

@required
- (NSUInteger)numberOfRowsInCalendarView:(WJCalendarView *)calendarView;
- (WJCalendarViewItem *)calendarView:(WJCalendarView *)calendarView titleForRow:(NSUInteger)row column:(NSUInteger)column;

@optional
- (CGFloat)heightForRowInCalendarView:(WJCalendarView *)calendarView;

@end

@protocol WJCalendarViewDelegate <NSObject>

- (void)calendarView:(WJCalendarView *)calendarView didSelectAtRow:(NSUInteger)row column:(NSUInteger)column;

@end

@interface WJCalendarView : UIView
/**
 *  数据源
 */
@property (nonatomic, weak) id<WJCalendarViewDataSource> dataSource;
/**
 *  代理
 */
@property (nonatomic, weak) id<WJCalendarViewDelegate> delegate;
/**
 *  日历线框颜色
 */
@property (nonatomic, strong) IBInspectable UIColor *lineColor;
/**
 *  左右滑动响应的代码块
 */
@property (nonatomic, copy) void (^swipeActionBlock)(UISwipeGestureRecognizerDirection);
/**
 *  当前显示的日历的年份和月份
 */
@property (nonatomic, copy) IBInspectable NSString *year_month;
/**
 *  重载数据
 */
- (void)reloadData;

@end
