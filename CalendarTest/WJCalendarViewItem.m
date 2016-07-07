//
//  WJCalendarViewItem.m
//  CalendarTest
//
//  Created by Jace on 06/07/16.
//  Copyright © 2016年 Jace. All rights reserved.
//

#import "WJCalendarViewItem.h"

@interface WJCalendarViewItem ()

@property (nonatomic, strong) IBInspectable UILabel *label;
@property (nonatomic, strong) IBInspectable UIButton *button;

@end

@implementation WJCalendarViewItem

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

- (void)setSubview
{
    _label = [[UILabel alloc] init];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.backgroundColor = [UIColor clearColor];
    [self addSubview:_label];
    
    _button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_button];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _label.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    _button.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

- (void)buttonAction:(UIButton *)sender
{
    if (_WJCalendarViewActionBlock) {
        _WJCalendarViewActionBlock(_model.row,_model.column);
    }
}

- (void)setModel:(WJCalendarItem *)model
{
    _model = model;
    _label.text = [NSString stringWithFormat:@"%lu",(unsigned long)_model.day];
    
    if (_model.isCurrentMonthItem) {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
        }
        else {
            components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:[NSDate date]];
        }
        
        if (_model.year == components.year && _model.month == components.month && _model.day == components.day) {
            self.backgroundColor = [UIColor colorWithRed:0.3 green:0.6 blue:0.3 alpha:0.2];
            self.label.textColor = [UIColor orangeColor];
        }
        else {
            self.backgroundColor = [UIColor clearColor];
            self.label.textColor = [UIColor blackColor];
        }
    }
    else {
        self.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.1];
        self.label.textColor = [UIColor grayColor];
    }
}

@end
