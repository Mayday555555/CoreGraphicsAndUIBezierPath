//
//  CustomViewDelegate.h
//  UIBezierPathAndCoreGraphics
//
//  Created by xuanze on 2019/5/24.
//  Copyright © 2019 xuanze. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomViewDelegate : NSObject<CALayerDelegate>
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx;
@end

NS_ASSUME_NONNULL_END
