//
//  ViewController.m
//  CalendarTest
//
//  Created by Jace on 05/07/16.
//  Copyright © 2016年 Jace. All rights reserved.
//

#import "ViewController.h"
#import "WJCalendarView.h"
#import "NSDate+WJCalendar.h"

@interface ViewController ()<WJCalendarViewDelegate,WJCalendarViewDataSource>
{
    NSMutableArray *_dataSource;
}
@property (weak, nonatomic) IBOutlet WJCalendarView *myCalendarView;
@property (strong, nonatomic) NSDate *showDate;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _dataSource = [[NSMutableArray alloc] init];
    _showDate = [NSDate date];
    
    _myCalendarView.delegate = self;
    _myCalendarView.dataSource = self;
    
    __weak ViewController *weakSelf = self;
    [_myCalendarView setSwipeActionBlock:^(UISwipeGestureRecognizerDirection derection) {
        switch (derection) {
            case UISwipeGestureRecognizerDirectionLeft:
            {
                weakSelf.showDate = [[weakSelf.showDate getLastDayOfCurrentMonth] dateByAddingTimeInterval:3600*24];
                [weakSelf setDataSource];
            }
                break;
            case UISwipeGestureRecognizerDirectionRight:
            {
                weakSelf.showDate = [[weakSelf.showDate getFirstDayOfCurrentMonth] dateByAddingTimeInterval:-3600*24];
                [weakSelf setDataSource];
            }
                break;
            default:
                break;
        }
    }];
    
    
    [self setDataSource];
}

- (void)setDataSource
{
    [_dataSource removeAllObjects];
    [self calculateDaysInPreviousMonthWithDate:_showDate];
    [self calculateDaysInCurrentMonthWithDate:_showDate];
    [self calculateDaysInFollowMonthWithDate:_showDate];
    [_myCalendarView reloadData];
}

- (void)calculateDaysInPreviousMonthWithDate:(NSDate *)date
{
    NSDate *firstDay = [date getFirstDayOfCurrentMonth];
    NSUInteger firstWeekday = [firstDay getWeekdayOfCurrentDate]-1;
    NSDate *dateInPreviousMonth = [firstDay dateByAddingTimeInterval:-3600*24];
    NSUInteger numberOfDaysInPreviousMonth = [dateInPreviousMonth numberOfDaysInCurrentMonth];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    }
    else {
        unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit;
    }
    NSDateComponents *components = [calendar components:unitFlags fromDate:dateInPreviousMonth];
    
    for (int i = 0; i < firstWeekday; i++) {
        WJCalendarItem *item = [[WJCalendarItem alloc] initWithYear:components.year month:components.month day:numberOfDaysInPreviousMonth-firstWeekday+i+1 weekday:i+1 row:0 column:i isCurrentMonthItem:NO];
        [_dataSource addObject:item];
    }
}

- (void)calculateDaysInCurrentMonthWithDate:(NSDate *)date
{
    NSUInteger weeklyOrdinality = [[date getFirstDayOfCurrentMonth] getWeekdayOfCurrentDate];
    NSDate *firstDateInCurrentMonth = [date getFirstDayOfCurrentMonth];
    NSUInteger daysCountInCurrentMonth = [date numberOfDaysInCurrentMonth];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    }
    else {
        unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit;
    }
    NSDateComponents *components = [calendar components:unitFlags fromDate:firstDateInCurrentMonth];
    
    _myCalendarView.year_month = [NSString stringWithFormat:@"%ld - %ld",(long)components.year,(long)components.month];
    
    int count = 0;
    int row = 0;
    while (count < daysCountInCurrentMonth){
        for (int i = weeklyOrdinality-1; i < 7; i++) {
            WJCalendarItem *item = [[WJCalendarItem alloc] initWithYear:components.year month:components.month day:components.day+count weekday:i+1 row:row column:i isCurrentMonthItem:YES];
            [_dataSource addObject:item];
            count++;
            if (count >= daysCountInCurrentMonth) {
                break;
            }
        }
        row++;
        weeklyOrdinality = 1;
    }
}

- (void)calculateDaysInFollowMonthWithDate:(NSDate *)date
{
    NSDate *lastDay = [date getLastDayOfCurrentMonth];
    NSUInteger lastWeekday = [lastDay getWeekdayOfCurrentDate];
    NSUInteger followDaysCount = 7-lastWeekday;
    NSUInteger row = [date numberOfWeekInCurrentMonth]-1;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    }
    else {
        unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit;
    }
    NSDateComponents *components = [calendar components:unitFlags fromDate:lastDay];
    components.month = components.month+1;
    for (int i = 1; i <= followDaysCount; i++) {
        WJCalendarItem *item = [[WJCalendarItem alloc] initWithYear:components.year month:components.month day:i weekday:lastWeekday+i row:row column:lastWeekday+i-1 isCurrentMonthItem:NO];
        [_dataSource addObject:item];
    }
}

#pragma mark - WJCalendarViewDataSource
- (NSUInteger)numberOfRowsInCalendarView:(WJCalendarView *)calendarView
{
    return _dataSource.count/7;
}

- (WJCalendarViewItem *)calendarView:(WJCalendarView *)calendarView titleForRow:(NSUInteger)row column:(NSUInteger)column
{
    WJCalendarViewItem *item = [[WJCalendarViewItem alloc] init];
    WJCalendarItem *model = _dataSource[row*7+column];
    item.model = model;
    return item;
}

#pragma mark - WJCalendarViewDelegate
- (void)calendarView:(WJCalendarView *)calendarView didSelectAtRow:(NSUInteger)row column:(NSUInteger)column
{
    WJCalendarItem *item = _dataSource[row*7+column];
    NSLog(@"%lu,%lu",(unsigned long)item.month,(unsigned long)item.day);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
