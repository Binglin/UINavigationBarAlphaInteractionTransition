//
//  SecondViewController.m
//  UIPercentDriven
//
//  Created by ET|冰琳 on 15/12/11.
//  Copyright © 2015年 ET|冰琳. All rights reserved.
//

#import "SecondViewController.h"
#import "UINavigationBarAlphaTransitionPercentDrivenObject.h"



@interface SecondViewController ()<UINavigationControllerDelegate , UIGestureRecognizerDelegate>
{
    id<UINavigationControllerDelegate> lastDelegate;
}
@property (weak, nonatomic) IBOutlet UIButton *jump;
@end

@implementation SecondViewController

-(CGFloat)destinationNavigationBackgroundAlpha{
    return 0.f;
}

- (void)viewDidLoad{
    [super viewDidLoad];
//    lastDelegate = self.navigationController.delegate;
//    self.navigationController.delegate = nil;
//    self.navigationItem.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = YES;
    NSLog(@"%@",[self.navigationController.navigationBar subviews]);
    UINavigationBar *navBar = self.navigationController.navigationBar;
    
    UIView *background = [navBar valueForKey:@"_backgroundView"];
    background.alpha  = 0;
    UINavigationController *controller = self.navigationController;
    
//    background.backgroundColor = [UIColor clearColor];
//    [background setValue:[UIColor clearColor] forKey:@"_barTintColor"];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    self.navigationController.delegate = lastDelegate;
}

- (IBAction)touched:(id)sender {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SecondViewController *second = [storyBoard instantiateViewControllerWithIdentifier:@"SecondViewController"];
    [self.navigationController pushViewController:second animated:YES];
}

@end
