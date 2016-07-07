//
//  WJCalendarView.m
//  CalendarTest
//
//  Created by Jace on 05/07/16.
//  Copyright © 2016年 Jace. All rights reserved.
//

#import "WJCalendarView.h"

#define WIDTH CGRectGetWidth(self.frame)
#define HEIFHT CGRectGetHeight(self.frame)
#define OtherHeight 30

@interface WJCalendarView ()

@property (nonatomic, strong) UILabel *year_monthLabel;

@end

@implementation WJCalendarView
{
    NSUInteger _row;          //日历总共多少行
    CGFloat _itemWidth;       //日历每项的宽
    CGFloat _itemHeight;      //日历每项的高
    NSArray *_weeekdayArr;
}

- (instancetype)init
{
    if ((self = [super init])) {
        [self setSubview];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        [self setSubview];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self setSubview];
    }
    return self;
}

- (UILabel *)year_monthLabel
{
    _year_monthLabel = [[UILabel alloc] init];
    _year_monthLabel.textColor = [UIColor blackColor];
    _year_monthLabel.textAlignment = NSTextAlignmentCenter;
    _year_monthLabel.font = [UIFont boldSystemFontOfSize:20];
    return _year_monthLabel;
}

- (void)setYear_month:(NSString *)year_month
{
    _year_month = year_month;
    _year_monthLabel.text = _year_month;
}

- (void)setSubview
{
    [self addSubview:self.year_monthLabel];
    
    _weeekdayArr = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    for (int i = 0; i < _weeekdayArr.count; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.tag = 1000+i;
        label.text = _weeekdayArr[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        [self addSubview:label];
    }
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:rightSwipe];
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:leftSwipe];
    
    for (int i = 0; i < 11+_row; i++) {
        UIView *lineView = [[UIView alloc] init];
        lineView.tag = 3000 + i;
        [self addSubview:lineView];
    }
}

- (void)swipeAction:(UISwipeGestureRecognizer *)sender
{
    if (_swipeActionBlock) {
        _swipeActionBlock(sender.direction);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _itemWidth = WIDTH/7.0;
    _itemHeight = (HEIFHT-OtherHeight*2)/_row;
    
    _year_monthLabel.frame = CGRectMake(0, 0, WIDTH, OtherHeight);
    
    for (int i = 0; i < _weeekdayArr.count; i++) {
        UILabel *label = (UILabel *)[self viewWithTag:1000+i];
        label.frame = CGRectMake(i*_itemWidth, OtherHeight, _itemWidth, OtherHeight);
    }
    
    if (_row > 0 && [_dataSource respondsToSelector:@selector(calendarView:titleForRow:column:)]) {
        for (int i = 0; i < _row; i++) {
            for (int j = 0; j < 7; j++) {
                WJCalendarViewItem *item = (WJCalendarViewItem *)[self viewWithTag:2000+i*7+j];
                item.frame = CGRectMake(j*_itemWidth, OtherHeight*2+i*_itemHeight, _itemWidth, _itemHeight);
            }
        }
        
        for (int i = 0; i < 11+_row; i++) {
            UIView *lineView = [self viewWithTag:3000 + i];
            lineView.backgroundColor = _lineColor;
            if (i == 0 || i == 7) {
                lineView.frame = CGRectMake(i*_itemWidth, 0, 1, HEIFHT);
            }
            else if (i < 8) {
                lineView.frame = CGRectMake(i*_itemWidth, OtherHeight, 1, HEIFHT-OtherHeight);
            }
            else if (i == 8 || i == 9) {
                lineView.frame = CGRectMake(0, OtherHeight*(i-8), WIDTH, 1);
            }
            else {
                lineView.frame = CGRectMake(0, (i-10)*_itemHeight+OtherHeight*2, WIDTH, 1);
            }
            [self bringSubviewToFront:lineView];
        }
    }
}

- (void)reloadData
{
    for (int i = 0; i < _row; i++) {
        for (int j = 0; j < 7; j++) {
            WJCalendarViewItem *item = (WJCalendarViewItem *)[self viewWithTag:2000+i*7+j];
            [item removeFromSuperview];
        }
    }
    
    if ([_dataSource respondsToSelector:@selector(numberOfRowsInCalendarView:)]) {
         if (_row > [_dataSource numberOfRowsInCalendarView:self]) {
             //总行数减少
             NSUInteger count = _row - [_dataSource numberOfRowsInCalendarView:self];
             
             for (NSUInteger i = 10+_row; i > 10+_row-count; i--) {
                 UIView *lineView = [self viewWithTag:3000 + i];
                 [lineView removeFromSuperview];
             }
         }
         else if (_row < [_dataSource numberOfRowsInCalendarView:self]) {
             //总行数增加
             NSUInteger count = [_dataSource numberOfRowsInCalendarView:self] - _row;
             
             for (NSUInteger i = 11+_row; i <= 11+_row+count; i++) {
                 UIView *lineView = [[UIView alloc] init];
                 lineView.tag = 3000 + i;
                 [self addSubview:lineView];
             }
         }
        
        _row = [_dataSource numberOfRowsInCalendarView:self];
        //设置日历视图
        if (_row > 0 && [_dataSource respondsToSelector:@selector(calendarView:titleForRow:column:)]) {
            for (int i = 0; i < _row; i++) {
                for (int j = 0; j < 7; j++) {
                    WJCalendarViewItem *item = [_dataSource calendarView:self titleForRow:i column:j];
                    item.tag = 2000+i*7+j;
                    if ([_delegate respondsToSelector:@selector(calendarView:didSelectAtRow:column:)]) {
                        __weak WJCalendarView *weakSelf = self;
                        [item setWJCalendarViewActionBlock:^(NSUInteger row, NSUInteger column) {
                            [weakSelf.delegate calendarView:weakSelf didSelectAtRow:row column:column];
                        }];
                    }
                    [self addSubview:item];
                }
            }
        }
     }
    else {
        _row = 0;
    }
    
    [self layoutSubviews];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
