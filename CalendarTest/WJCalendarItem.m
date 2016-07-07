//
//  WJCalendarItem.m
//  CalendarTest
//
//  Created by Jace on 06/07/16.
//  Copyright © 2016年 Jace. All rights reserved.
//

#import "WJCalendarItem.h"
#import "NSDate+WJCalendar.h"

@implementation WJCalendarItem

- (instancetype)initWithYear:(NSUInteger)year
                       month:(NSUInteger)month
                         day:(NSUInteger)day
                     weekday:(NSUInteger)weekday
                         row:(NSUInteger)row
                      column:(NSUInteger)column
          isCurrentMonthItem:(BOOL)isCurrentMonthItem
{
    if ((self = [super init])) {
        _year = year;
        _month = month;
        _day = day;
        _weekday = weekday;
        _row = row;
        _column = column;
        _isCurrentMonthItem = isCurrentMonthItem;
    }
    return self;
}

@end
