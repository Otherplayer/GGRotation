//
//  ViewController.m
//  GGRotation
//
//  Created by __无邪_ on 15/11/11.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import "ViewController.h"
#import "HYQCircleView.h"
@interface ViewController ()
@property (nonatomic, strong)HYQCircleView *circleView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    self.circleView = [[HYQCircleView alloc] initWithFrame:self.view.bounds];
    [self.circleView setUserInteractionEnabled:YES];
    [self.view addSubview:self.circleView];
    

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
