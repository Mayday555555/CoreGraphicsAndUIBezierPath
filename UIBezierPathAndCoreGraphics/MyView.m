//
//  MyView.m
//  UIBezierPathAndCoreGraphics
//
//  Created by xuanze on 2019/5/24.
//  Copyright © 2019 xuanze. All rights reserved.
//

#import "MyView.h"

@implementation MyView

- (void) drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    UIGraphicsPushContext(ctx);
    
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, 100, 100));
    CGContextSetFillColorWithColor(ctx, [UIColor blueColor].CGColor);
    CGContextFillPath(ctx);
    
    UIGraphicsPopContext();
    
}

@end
