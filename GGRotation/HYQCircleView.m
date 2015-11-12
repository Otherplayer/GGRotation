//
//  HYQCircleView.m
//  GGCircle
//
//  Created by __无邪_ on 15/11/11.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import "HYQCircleView.h"


@interface HYQCircleView ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong)UIImageView *imageView;
@end

@implementation HYQCircleView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        [self.imageView setImage:[UIImage imageNamed:@"guide_image.png"]];
        [self.imageView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        [self addSubview:self.imageView];
        [self setUserInteractionEnabled:YES];
        [self.imageView setUserInteractionEnabled:YES];
        [self addGesture];

    }
    return self;
}







/*
 添加手势
 */
- (void)addGesture{
    UIRotationGestureRecognizer *panGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
//    panGesture.delegate = self;
    [self addGestureRecognizer:panGesture];
}

////手势操作
//- (void)handleSinglePan:(id)sender{
//    UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer *)sender;
//    CGPoint pointMove = [panGesture locationInView:self];
//    NSLog(@"%@",NSStringFromCGPoint(pointMove));
//    switch (panGesture.state) {
//        case UIGestureRecognizerStateBegan:
//        {
////            pointDrag = [panGesture locationInView:self];
//        }
//            break;
//        case UIGestureRecognizerStateChanged:
//        {
//            CGPoint pointMove = [panGesture locationInView:self];
////            [self dragPoint:pointDrag movePoint:pointMove centerPoint:center];
//        }
//            break;
//        case UIGestureRecognizerStateEnded:
//        {
//            CGPoint pointMove = [panGesture locationInView:self];
////            [self dragPoint:pointDrag movePoint:pointMove centerPoint:center];
////            [self reviseCirclePoint];
//        }
//            break;
//        case UIGestureRecognizerStateFailed:
//        {
//            CGPoint pointMove = [panGesture locationInView:self];
////            [self dragPoint:pointDrag movePoint:pointMove centerPoint:center];
////            [self reviseCirclePoint];
//        }
//            break;
//            
//        default:
//            break;
//    }
//}
//

// 旋转
-(void)rotate:(UIRotationGestureRecognizer *)sender {
    CGFloat _lastRotation = 0.0;
    
    if([(UIRotationGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        
        _lastRotation = 0.0;
        return;
    }
    
    CGFloat rotation = 0.0 - (_lastRotation - [(UIRotationGestureRecognizer*)sender rotation]);
    
    CGAffineTransform currentTransform = self.imageView.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform,rotation);
    
    [self.imageView setTransform:newTransform];
    
    _lastRotation = [(UIRotationGestureRecognizer*)sender rotation];
//    [self showOverlayWithFrame:self.imageView.frame];
}
////随着拖动改变子view位置，子view与y轴的夹角，子view与x轴的夹角
//- (void)dragPoint:(CGPoint)dragPoint movePoint:(CGPoint)movePoint centerPoint:(CGPoint)centerPoint{
//    CGFloat drag_radian   = [self schAtan2f:dragPoint.x - centerPoint.x theB:dragPoint.y - centerPoint.y];
//    
//    CGFloat move_radian   = [self schAtan2f:movePoint.x - centerPoint.x theB:movePoint.y - centerPoint.y];
//    
//    CGFloat change_radian = (move_radian - drag_radian);
////    for (int i=0; i<arrImages.count; i++) {
////        DragImageView *imageview = [arrImages objectAtIndex:i];
////        imageview.center = [self getPointByRadian:(imageview.current_radian+change_radian) centreOfCircle:center radiusOfCircle:radius];
////        imageview.current_radian = [self getRadinaByRadian:imageview.current_radian + change_radian];;
////        imageview.current_animation_radian = [self getAnimationRadianByRadian:imageview.current_radian];;
////    }
//}
//
////计算schAtan值
//- (CGFloat)schAtan2f:(CGFloat)a theB:(CGFloat)b
//{
//    CGFloat rd = atan2f(a,b);
//    
//    if(rd < 0.0f)
//        rd = M_PI * 2 + rd;
//    
//    return rd;
//}

@end
