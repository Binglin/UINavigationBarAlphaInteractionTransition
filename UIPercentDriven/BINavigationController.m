//
//  BINavigationController.m
//  UIPercentDriven
//
//  Created by ET|冰琳 on 15/12/14.
//  Copyright © 2015年 ET|冰琳. All rights reserved.
//

#import "BINavigationController.h"


@implementation UINavigationController (UINavigationControllerDelegate)



@end

@implementation BINavigationController

- (void)loadView{
    [super loadView];
    UINavigationController<UINavigationControllerDelegate> *navDele = self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    NSLog(@"__%s",__func__);
}
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                              animationControllerForOperation:(UINavigationControllerOperation)operation
                                                           fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC{
    
    
    id response = [super navigationController:navigationController animationControllerForOperation:operation fromViewController:fromVC toViewController:toVC];
    return response;
}


- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{
    
    return [super navigationController:navigationController interactionControllerForAnimationController:animationController];
}
@end
