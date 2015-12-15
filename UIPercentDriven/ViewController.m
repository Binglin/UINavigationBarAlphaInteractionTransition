//
//  ViewController.m
//  UIPercentDriven
//
//  Created by ET|冰琳 on 15/12/11.
//  Copyright © 2015年 ET|冰琳. All rights reserved.
//

#import "ViewController.h"
#import "UINavigationBarAlphaTransitionPercentDrivenObject.h"

@interface ViewController ()<UINavigationControllerDelegate, UIViewControllerAnimatedTransitioning>
{
    id<UINavigationControllerDelegate> lastDelegate;
    UIPercentDrivenInteractiveTransition *_transition;
    UINavigationBarAlphaTransitionPercentDrivenObject *_alphaTransition;
}
@end


@implementation ViewController

- (CGFloat)destinationNavigationBackgroundAlpha{
    return 1.0f;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    self.navigationController.delegate = lastDelegate;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"first layer";
    lastDelegate = self.navigationController.delegate;
   
    _alphaTransition = [UINavigationBarAlphaTransitionPercentDrivenObject new];
    self.navigationController.delegate = _alphaTransition;
    _alphaTransition.navigationController = self.navigationController;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
