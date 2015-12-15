//
//  BINavigationController.h
//  UIPercentDriven
//
//  Created by ET|冰琳 on 15/12/14.
//  Copyright © 2015年 ET|冰琳. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol UINavigationBarAlphaDelegate <NSObject>

@property (nonatomic, assign) CGFloat destinationNavigationBackgroundAlpha;

@end


@interface UINavigationController (UINavigationControllerDelegate)<UINavigationControllerDelegate>

@end

@interface BINavigationController : UINavigationController<UINavigationControllerDelegate>

@end

