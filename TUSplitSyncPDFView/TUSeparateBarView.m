//
//  SeparateBarView.m
//  samplePDFViewer
//
//  Created by stky on 2013/06/27.
//  Copyright (c) 2013年 stky. All rights reserved.
//

#import "TUSeparateBarView.h"

const NSInteger WIDTH = 100;

@implementation TUSeparateBarView

- (id)initWithX:(CGFloat)x withView:(UIView *)view
{
    CGRect frame = CGRectMake(x - WIDTH/2, 0, WIDTH, view.frame.size.height);
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // タッチを有効にする
        self.userInteractionEnabled = YES;
        _separatedView = view;
        // ビューの背景色を透明にする
        self.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.0f];
        _x = x;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [[UIColor blackColor] setFill];
    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1.0);  // 塗りつぶしの色を指定
    // 幅10pxのしきりを描画する
    CGContextFillRect(context, CGRectMake(WIDTH/2 - 5, 0, 10, self.frame.size.height));
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch locationInView:nil];
    _x = point.x;
    // しきりを移動させる
    self.frame = CGRectMake(point.x - WIDTH/2, 0, WIDTH, self.frame.size.height);
    // クリップ枠ビューの右端を移動させる
    _separatedView.frame = CGRectMake(0, 0, point.x, _separatedView.frame.size.height);
}

@end
