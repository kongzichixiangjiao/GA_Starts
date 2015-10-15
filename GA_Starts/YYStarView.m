//
//  YYStarView.m
//  DuoMeiTao
//
//  Created by Luyu Dashing on 15/1/19.
//  Copyright (c) 2015年 YY. All rights reserved.
//

#import "YYStarView.h"
#import "UIView+frameAdjust.h"

static CGFloat padding = 10.f;
static NSString * const gray_star_name = @"collectstar";
static NSString * const yellow_star_name = @"collectstars";

@interface YYStarView ()
{
    NSMutableArray *_stars;
}

@end

@implementation YYStarView


- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 15*5+padding*2, 14)]) {
        
        _stars = [[NSMutableArray alloc] init];
        
        for (int i=0; i<5; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            [imageView setImage:[UIImage imageNamed:gray_star_name]];//gray star
            [self addSubview:imageView];
            [_stars addObject:imageView];
        }
        
    }
    return self;
}

- (void)awakeFromNib
{
    _stars = [[NSMutableArray alloc] init];
    
    for (int i=0; i<5; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView setImage:[UIImage imageNamed:gray_star_name]];//gray star
        [self addSubview:imageView];
        [_stars addObject:imageView];
    }
}

- (void)layoutSubviews
{
    [_stars enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIImageView *imageView = (UIImageView *)obj;
        imageView.frame = CGRectMake(0+(15+3)*idx, 0, 15, 14);
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *oneTouch = [touches anyObject];
    CGPoint point = [oneTouch locationInView:self];
    [self processingData:point];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *oneTouch = [touches anyObject];
    CGPoint curPoint = [oneTouch locationInView:self];
    //CGPoint prePoint = [oneTouch previousLocationInView:self];
    [self processingData:curPoint];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *oneTouch = [touches anyObject];
    CGPoint point = [oneTouch locationInView:self];
    [self processingData:point];
}

- (void)processingData:(CGPoint)point
{
    if (point.x<=padding) {
        self.starNum = 0;
        return ;
    }
    if (point.x>=padding+15*5) {
        self.starNum = 5;
        return ;
    }
    NSInteger num = lround((point.x-padding)/15.0);
    self.starNum = num;
}

- (void)setStarWithNum:(NSInteger)starNum
{
    NSInteger tag = starNum;
    
    int i=1;
    while (i<=tag && i<=_stars.count) {
        UIImageView *star = [_stars objectAtIndex:i-1];
        [star setImage:[UIImage imageNamed:yellow_star_name]];//yellow star
        i++;
    }
    if (starNum>5) {
        return ;
    }
    for (NSInteger j=starNum; j<5; j++) {
        UIImageView *star = [_stars objectAtIndex:j];
        [star setImage:[UIImage imageNamed:gray_star_name]];
        i++;
    }
}

- (void)setStarNum:(NSInteger)starNum
{
    if (_starNum == starNum) {
        return ;
    }
    _starNum = starNum;
    [self setStarWithNum:starNum];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
