//
//  AlphaTransitonObject.m
//  UIPercentDriven
//
//  Created by ET|冰琳 on 15/12/11.
//  Copyright © 2015年 ET|冰琳. All rights reserved.
//

#import "UINavigationBarAlphaTransitionPercentDrivenObject.h"
#import "ViewController.h"
#import "BINavigationController.h"


@interface UINavigationBarAlphaTransitionPercentDrivenObject ()
{
    UIPercentDrivenInteractiveTransition *_transition;
}
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *panGesture;
@property (nonatomic, assign) UINavigationControllerOperation operation;

@end

@implementation UINavigationBarAlphaTransitionPercentDrivenObject

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return (self.animationDuration > 0) ? self.animationDuration : 0.3;
}

// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{

    UIView *containerView = [transitionContext containerView];
    
    
    UIViewController<UINavigationBarAlphaDelegate> *fromControl = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController<UINavigationBarAlphaDelegate> *toControl = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromView = fromControl.view;
    UIView *toView   = toControl.view;

    UINavigationBar *navibar = toControl.navigationController.navigationBar;
    
    NSArray *navigationItemStacks = [navibar valueForKey:@"_itemStack"];
    
    UIView *titleView;
    UIView *leftBackView;
    UIView *backView;
    
    if (navigationItemStacks.count) {
        
        NSInteger count = navigationItemStacks.count;
        titleView    = [navigationItemStacks[count - 1] valueForKey:@"_defaultTitleView"];

        if (count >= 2 ) {
            backView = [navigationItemStacks[count - 2] valueForKey:@"_defaultTitleView"];
            leftBackView = [navigationItemStacks[count - 2] valueForKey:@"_backButtonView"];
        }else{
            backView = nil;
        }
    }
    
//    UIView *itemButtonView = [[navibar valueForKey:@"_itemStack"] count]>1 ? [[[navibar valueForKey:@"_backButtonView"] subviews] firstObject] : nil;
    
    UIView *naviBarBackground = [toControl.navigationController.navigationBar valueForKey:@"_backgroundView"];
    naviBarBackground.alpha = fromControl.destinationNavigationBackgroundAlpha;
    
    CGFloat fromControllerAlpha = 1.0;
    if ([fromControl respondsToSelector:@selector(destinationNavigationBackgroundAlpha)]) {
        fromControllerAlpha = fromControl.destinationNavigationBackgroundAlpha;
    }
    naviBarBackground.alpha = fromControllerAlpha;
    
    if (_operation == UINavigationControllerOperationPush) {
        
        [containerView addSubview:fromView];
        [containerView addSubview:toView];
        
        fromView.frame = ({
            CGRect frame = fromView.frame;
            frame.origin.x = 0;
            frame;
        });

        toView.frame = ({
            CGRect frame = toView.frame;
            frame.origin.x = frame.size.width;
            frame;
        });
    }else{
        
        [containerView addSubview:toView];
        [containerView addSubview:fromView];
        
        fromView.frame = ({
            CGRect frame = fromView.frame;
            frame.origin.x = 0;
            frame;
        });
        
        toView.frame = ({
            CGRect frame = toView.frame;
            frame.origin.x = - ([UIScreen mainScreen].bounds.size.width/2.f - titleView.frame.size.width/2.f) + 8;
            frame;
        });
    }
    

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
       
        if (_operation == UINavigationControllerOperationPush) {
            
            fromView.frame = ({
                CGRect frame = fromView.frame;
                frame.origin.x = - ([UIScreen mainScreen].bounds.size.width/2.f - titleView.frame.size.width/2.f) + 8;
                frame;
            });
            
            toView.frame = ({
                CGRect frame = toView.frame;
                frame.origin.x = 0;
                frame;
            });
        }
        else
        {
            fromView.frame = ({
                CGRect frame = fromView.frame;
                frame.origin.x = [UIScreen mainScreen].bounds.size.width;
                frame;
            });
            
            toView.frame = ({
                CGRect frame = toView.frame;
                frame.origin.x = 0;
                frame;
            });
        }
        
        CGFloat toControllerAlpha = 1.0;
        if ([toControl respondsToSelector:@selector(destinationNavigationBackgroundAlpha)]) {
            toControllerAlpha = toControl.destinationNavigationBackgroundAlpha;
        }
        naviBarBackground.alpha = toControl.destinationNavigationBackgroundAlpha;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}




#pragma mark - gesture

- (void)setNavigationController:(UINavigationController *)navigationController{
    _navigationController = navigationController;
    [_navigationController.view addGestureRecognizer:self.panGesture];
}

- (UIScreenEdgePanGestureRecognizer *)panGesture{
    if (_panGesture == nil) {
        UIScreenEdgePanGestureRecognizer *popGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePopRecognizer:)];
        popGesture.edges = UIRectEdgeLeft;
        _panGesture = popGesture;
    }
    return _panGesture;
}

- (void)handlePopRecognizer:(UIPanGestureRecognizer*)recognizer {
    // 计算用户手指划了多远
    CGFloat progress = [recognizer translationInView:self.navigationController.view].x / (self.navigationController.view.bounds.size.width);
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        // 创建过渡对象，弹出viewController
        _transition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        // 更新 interactive transition 的进度
        [_transition updateInteractiveTransition:progress];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        // 完成或者取消过渡
        if (progress > 0.5) {
            [_transition finishInteractiveTransition];
        }
        else {
            [_transition cancelInteractiveTransition];
        }
        
        _transition = nil;
    }
}

#pragma mark - UINavigationControllerDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC{
    
    self.operation = operation;
    return self;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{
    
    return _transition;
}
@end
