//
//  HYQRotationGestureRecognizer.h
//  GGRotation
//
//  Created by __无邪_ on 15/11/11.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import <UIKit/UIKit.h>


#define degreesToRadians(x) (M_PI * x / 180.0)
#define radiansToDegrees(x) (x * 180 / M_PI)



@class HYQRotationGestureRecognizer;
@protocol HYQRotationGestureDelegate <NSObject>
- (void)touchesBegan:(HYQRotationGestureRecognizer *)gestureRecognizer;
- (void)touchesEnded:(HYQRotationGestureRecognizer *)gestureRecognizer;
@end


@interface HYQRotationGestureRecognizer : UIGestureRecognizer
@property (nonatomic, assign)id<HYQRotationGestureDelegate>rotationGestureDelegate;
/**
 The rotation of the gesture in radians since its last change.
 */
@property (nonatomic, assign) CGFloat rotation;


@end
