//
//  HYQCircleView.m
//  GGCircle
//
//  Created by __无邪_ on 15/11/11.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import "HYQCircleView.h"
#import "HYQRotationGestureRecognizer.h"

@interface HYQCircleView ()<HYQRotationGestureDelegate>
@property (nonatomic, strong)UIImageView *imageView;

@property (nonatomic, assign) NSInteger currentIndex;//当前所在页面
@property (nonatomic, assign) BOOL isRotating;//是否正在旋转

@property (nonatomic, assign) CGFloat beganAngle;
@property (nonatomic, assign) CGFloat currentAngle;
@property (nonatomic, assign) CGFloat startAngle;
@property (nonatomic, assign) CGFloat stopAngle;


@end

@implementation HYQCircleView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Allow rotation between the start and stop angles.
        [self setIsRotating:NO];
        [self setCurrentIndex:0];
        [self setStartAngle:-180.0];
        [self setStopAngle:.0];
        
        [self addSubview:self.imageView];
        [self.imageView setTransform:CGAffineTransformMakeRotation(0)];
        
        
    }
    return self;
}


#pragma mark - Function

- (void)rotateAction:(HYQRotationGestureRecognizer *)recognizer{
    
    if (self.isRotating) {
        return;
    }
    
    CGFloat degrees = radiansToDegrees([recognizer rotation]);
    CGFloat currentAngle = [self currentAngle] + degrees;
    CGFloat relativeAngle = fmodf(currentAngle, 360.0);  // Converts to angle between 0 and 360 degrees.
    
    [self recordAngle:currentAngle];
    
    BOOL shouldRotate = NO;
    if ([self startAngle] <= [self stopAngle]) {
        shouldRotate = (relativeAngle >= [self startAngle] && relativeAngle <= [self stopAngle]);
    } else if ([self startAngle] > [self stopAngle]) {
        shouldRotate = (relativeAngle >= [self startAngle] || relativeAngle <= [self stopAngle]);
    }
    
    if (shouldRotate) {
        if (currentAngle > self.stopAngle)  {currentAngle = self.stopAngle;}
        if (currentAngle < self.startAngle) {currentAngle = self.startAngle;}
        
        [self setCurrentAngle:currentAngle];
        UIView *view = [recognizer view];
        [view setTransform:CGAffineTransformRotate([view transform], [recognizer rotation])];
    }
}


- (void)recordAngle:(CGFloat)angle{
    //NSLog(@"%@",@(angle));
    /*0 -> -90 -> -180*/
    
}


#pragma mark - HYQRotationGestureDelegate

- (void)touchesBegan:(HYQRotationGestureRecognizer *)gestureRecognizer{
    self.beganAngle = self.currentAngle;
    NSLog(@"Sssssssssssssssssstart : %@",@(self.beganAngle));
}

- (void)touchesEnded:(HYQRotationGestureRecognizer *)gestureRecognizer{
    NSLog(@"Eeeeeeeeeeeeeeeeeeeend : %@",@(self.currentAngle));
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        //NSLog(@"touches ended%@  %@  %@",@(self.currentAngle),@(self.beganAngle),@(self.currentIndex));
        
        if (self.beganAngle > self.currentAngle) {
            //前进一页
            self.currentIndex ++;
        }else if (self.beganAngle == self.currentAngle) {
            
        }else{
            self.currentIndex --;
        }
        
        [self rotateToIndex:self.currentIndex];
        
        
        //        CGFloat shouldToAngle = [self isCloseAngle:self.currentAngle];
        //
        //        [UIView animateWithDuration:0.25 animations:^{
        //            [self setIsRotating:YES];
        //            [self.imageView setTransform:CGAffineTransformMakeRotation(shouldToAngle)];
        //        } completion:^(BOOL finished) {
        //            [self setIsRotating:NO];
        //        }];
        
    }
    
}

- (CGFloat)isCloseAngle:(CGFloat)angle{
    /** (0) -> (-90) -> (-180) **/
    NSInteger agl = (NSInteger)fabs(angle);
    NSInteger min = 0;
    NSInteger mid = 90;
    NSInteger hig = 180;
    
    //处在0到-90之间,距离0更近
    //处在0到-90之间,距离-90更近
    //处在-90到-180之间,距离-90更近
    //处在-90到-180之间,距离-180更近
    
    
    min = labs(min - agl);
    mid = labs(mid - agl);
    hig = labs(hig - agl);
    
    NSInteger minValue = MIN(MIN(min, mid), hig);
    
    
    NSLog(@"MMMMMMM  %@",@(minValue));
    
    if (minValue == min) {
        NSLog(@"===============Min");
        self.currentAngle = 0;
        self.currentIndex = 0;
        return 0;
    }else if (minValue == mid){
        NSLog(@"===============Mid");
        self.currentAngle = -90;
        self.currentIndex = 1;
        return -M_PI/2;
    }else if (minValue == hig){
        NSLog(@"===============Hig");
        self.currentAngle = -180;
        self.currentIndex = 2;
        return -M_PI;
    }
    return -180;
}

- (void)rotateToIndex:(NSInteger)index{
    if (index < 0) {index = 0;}
    if (index > 2) {index = 2;}
    
    CGFloat shouldToAngle = 0;
    switch (index) {
        case 0:
            shouldToAngle = 0;
            self.currentAngle = 0;
            break;
        case 1:
            shouldToAngle = -M_PI/2;
            self.currentAngle = -90;
            break;
        case 2:
            shouldToAngle = -M_PI;
            self.currentAngle = -180;
            break;
    }
    
    self.currentIndex = index;
    
    [UIView animateWithDuration:0.25 animations:^{
        [self setIsRotating:YES];
        [self.imageView setTransform:CGAffineTransformMakeRotation(shouldToAngle)];
    } completion:^(BOOL finished) {
        [self setIsRotating:NO];
    }];
}


#pragma mark - configure

- (UIImageView *)imageView{
    if (!_imageView) {
        CGFloat width = CGRectGetWidth(self.bounds);
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-width, CGRectGetHeight(self.bounds) - width * 3 / 2.0 + 70, width * 3, width * 3)];
        [_imageView setImage:[UIImage imageNamed:@"guide_image"]];
//        [_imageView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        [self addSubview:_imageView];
        [_imageView setUserInteractionEnabled:YES];
        
        HYQRotationGestureRecognizer *panGesture = [[HYQRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateAction:)];
        [panGesture setRotationGestureDelegate:self];
        [_imageView addGestureRecognizer:panGesture];
    }
    return _imageView;
}

@end
