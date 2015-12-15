//
//  AlphaTransitonObject.h
//  UIPercentDriven
//
//  Created by ET|冰琳 on 15/12/11.
//  Copyright © 2015年 ET|冰琳. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol UINavigationBarAlphaDelegate <NSObject>

@optional
@property (nonatomic, assign) CGFloat destinationNavigationBackgroundAlpha;

@end




@interface UINavigationBarAlphaTransitionPercentDrivenObject : NSObject<UIViewControllerAnimatedTransitioning, UINavigationControllerDelegate>

@property (nonatomic, assign) IBOutlet UINavigationController  *navigationController;
@property (nonatomic, assign) CGFloat  animationDuration;

@end
