//
//  NSDate+WJCalendar.h
//  CalendarTest
//
//  Created by Jace on 05/07/16.
//  Copyright © 2016年 Jace. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (WJCalendar)
/**
 *  计算当前月份有多少天
 *
 *  @return 当前月份天数
 */
- (NSUInteger)numberOfDaysInCurrentMonth;

/**
 *  获取当前月份的第一天
 *
 *  @return 当前月份的第一天
 */
- (NSDate *)getFirstDayOfCurrentMonth;

/**
 *  获取当前月份的最后一天
 *
 *  @return 当前月份的最后一天
 */
- (NSDate *)getLastDayOfCurrentMonth;

/**
 *  获取当前时间是哪个月份
 *
 *  @return 当前时间的月份
 */
- (NSUInteger)getMonthOfCurrentDate;

/**
 *  获取当前时间是当前月份的几号
 *
 *  @return 当前时间是某月几号
 */
- (NSUInteger)getDayOfCurrentDate;

/**
 *  获取当前时间是星期几
 *
 *  @return 星期几
 */
- (NSUInteger)getWeekdayOfCurrentDate;

/**
 *  计算当前月份跨越了多少个星期
 *
 *  @return 当前月份跨越的星期数
 */
- (NSUInteger)numberOfWeekInCurrentMonth;

/**
 *  获取上个月的最后一天的日期
 *
 *  @return 上个月最后一天日期
 */
- (NSDate *)getPreviousMonthFinalDay;

/**
 *  获取下个月第一天的日期
 *
 *  @return 下个月第一天日期
 */
- (NSDate *)getFollowMonthFirstDay;

@end
