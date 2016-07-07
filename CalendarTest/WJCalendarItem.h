//
//  WJCalendarItem.h
//  CalendarTest
//
//  Created by Jace on 06/07/16.
//  Copyright © 2016年 Jace. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJCalendarItem : NSObject

@property (nonatomic, assign) NSUInteger year;
@property (nonatomic, assign) NSUInteger month;
@property (nonatomic, assign) NSUInteger day;
@property (nonatomic, assign) NSUInteger weekday;
@property (nonatomic, assign) NSUInteger row;
@property (nonatomic, assign) NSUInteger column;
@property (nonatomic, assign) BOOL isCurrentMonthItem;

- (instancetype)initWithYear:(NSUInteger)year
                       month:(NSUInteger)month
                         day:(NSUInteger)day
                     weekday:(NSUInteger)weekday
                         row:(NSUInteger)row
                      column:(NSUInteger)column
          isCurrentMonthItem:(BOOL)isCurrentMonthItem;

@end
