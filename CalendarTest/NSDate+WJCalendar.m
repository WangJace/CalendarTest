//
//  NSDate+WJCalendar.m
//  CalendarTest
//
//  Created by Jace on 05/07/16.
//  Copyright © 2016年 Jace. All rights reserved.
//

#import "NSDate+WJCalendar.h"
#import <UIKit/UIKit.h>

@implementation NSDate (WJCalendar)

- (NSUInteger)numberOfDaysInCurrentMonth
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        return [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
    }
    else {
        return [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self].length;
    }
}

- (NSDate *)getFirstDayOfCurrentMonth
{
    NSDate *firstDay = nil;
    BOOL flag = NO;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        flag = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitMonth startDate:&firstDay interval:NULL forDate:self];
    }
    else {
        flag = [[NSCalendar currentCalendar] rangeOfUnit:NSMonthCalendarUnit startDate:&firstDay interval:NULL forDate:self];
    }
    NSAssert(flag, @"Failed to get the firsst day of %@",self);
    return firstDay;
}

- (NSDate *)getLastDayOfCurrentMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componets;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        componets = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:self];
    }
    else {
        componets = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:self];
    }
    
    componets.timeZone = [NSTimeZone systemTimeZone];
    componets.day = [self numberOfDaysInCurrentMonth];
    componets.hour = 8;
    componets.minute = 0;
    componets.second = 0;
    NSDate *test = [calendar dateFromComponents:componets];
    
    return [calendar dateFromComponents:componets];
}

- (NSUInteger)getMonthOfCurrentDate
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        return [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    }
    else {
        return [[NSCalendar currentCalendar] ordinalityOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self];
    }
}

- (NSUInteger)getDayOfCurrentDate
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        return [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitDay forDate:self];
    }
    else {
        return [[NSCalendar currentCalendar] ordinalityOfUnit:NSDayCalendarUnit inUnit:NSDayCalendarUnit forDate:self];
    }
}

- (NSUInteger)getWeekdayOfCurrentDate
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        return [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:self];
    }
    else {
        return [[NSCalendar currentCalendar] ordinalityOfUnit:NSDayCalendarUnit inUnit:NSWeekCalendarUnit forDate:self];
    }
}

- (NSUInteger)numberOfWeekInCurrentMonth
{
    NSUInteger weekday = [[self getFirstDayOfCurrentMonth] getWeekdayOfCurrentDate];
    NSUInteger numberOfDays = [self numberOfDaysInCurrentMonth];
    NSUInteger numberOfWeeks = 0;
    if (weekday > 1) {
        numberOfWeeks += 1;
        numberOfDays -= (7-weekday + 1);
    }
    numberOfWeeks += numberOfDays/7;
    numberOfWeeks += (numberOfDays%7) > 0 ? 1 : 0;
    return numberOfWeeks;
}

- (NSDate *)getPreviousMonthFinalDay;
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componets;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        componets = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:self];
    }
    else {
        componets = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:self];
    }
    
    componets.day = 1;
    componets.month = componets.month-1;
    NSUInteger days = [[calendar dateFromComponents:componets] numberOfDaysInCurrentMonth];
    componets.day = days;
    componets.hour = 8;
    componets.minute = 0;
    componets.second = 0;
    return [calendar dateFromComponents:componets];
}

- (NSDate *)getFollowMonthFirstDay
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componets;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        componets = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:self];
    }
    else {
        componets = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:self];
    }
    
    componets.day = 1;
    componets.hour = 8;
    componets.minute = 0;
    componets.second = 0;
    componets.month = componets.month+1;
    return [calendar dateFromComponents:componets];
}

@end
