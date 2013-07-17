//
//  SeparateBarView.h
//  samplePDFViewer
//
//  Created by stky on 2013/06/27.
//  Copyright (c) 2013年 stky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TUSeparateBarView : UIView
{
    UIView* _separatedView;
    CGFloat _x;
}

- (id)initWithX:(CGFloat)x withView:(UIView *)view;

@end
