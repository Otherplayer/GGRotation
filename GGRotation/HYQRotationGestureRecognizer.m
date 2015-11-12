//
//  HYQRotationGestureRecognizer.m
//  GGRotation
//
//  Created by __无邪_ on 15/11/11.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import "HYQRotationGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>



@implementation HYQRotationGestureRecognizer

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    // Fail when more than 1 finger detected.
    if ([[event touchesForGestureRecognizer:self] count] > 1) {
        [self setState:UIGestureRecognizerStateFailed];
    }
    
    if (_rotationGestureDelegate && [_rotationGestureDelegate respondsToSelector:@selector(touchesBegan:)]) {
        [_rotationGestureDelegate touchesBegan:self];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if ([self state] == UIGestureRecognizerStatePossible) {
        [self setState:UIGestureRecognizerStateBegan];
    } else {
        [self setState:UIGestureRecognizerStateChanged];
    }
    
    // We can look at any touch object since we know we
    // have only 1. If there were more than 1 then
    // touchesBegan:withEvent: would have failed the recognizer.
    UITouch *touch = [touches anyObject];
    
    // To rotate with one finger, we simulate a second finger.
    // The second figure is on the opposite side of the virtual
    // circle that represents the rotation gesture.
    
    UIView *view = [self view];
    CGPoint center = CGPointMake(CGRectGetMidX([view bounds]), CGRectGetMidY([view bounds]));
    CGPoint currentTouchPoint = [touch locationInView:view];
    CGPoint previousTouchPoint = [touch previousLocationInView:view];
    
    CGFloat angleInRadians = atan2f(currentTouchPoint.y - center.y, currentTouchPoint.x - center.x) - atan2f(previousTouchPoint.y - center.y, previousTouchPoint.x - center.x);
    
    [self setRotation:angleInRadians];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    // Perform final check to make sure a tap was not misinterpreted.
    if ([self state] == UIGestureRecognizerStateChanged) {
        [self setState:UIGestureRecognizerStateEnded];
    } else {
        [self setState:UIGestureRecognizerStateFailed];
    }
    
    if (_rotationGestureDelegate && [_rotationGestureDelegate respondsToSelector:@selector(touchesEnded:)]) {
        [_rotationGestureDelegate touchesEnded:self];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [self setState:UIGestureRecognizerStateFailed];
}



@end
