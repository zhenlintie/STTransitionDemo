//
//  RootViewController.m
//  STTransitionDemo
//
//  Created by zhenlintie on 15/7/6.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import "RootViewController.h"
#import "STTransitionKit.h"
#import "ModalViewController.h"
#import "PushedViewController.h"

@implementation RootViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    return [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)present:(id)sender {
    ModalViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"modalVC"];
    vc.transition = STTransitionMake(^(STTransition *instance) {
        instance.animationTransitioning = STScaleZoomAnimationMake(^(STScaleZoomAnimation *instance) {
            instance.fromRect = ^CGRect(){
                return CGRectMake(20, 20, 100, 100);
            };
        });
        instance.interactiveTransitioning = STSwipeInteractionMake(^(STSwipeInteraction *instance) {
            instance.direction = STDirectionHorizontal;
            instance.reverse = YES;
        });
    });
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)push:(id)sender {
    if (self.navigationController){
        PushedViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"pushedVC"];
        vc.transition = STTransitionMake(^(STTransition *instance) {
            instance.animationTransitioning = [STDirectionAnimation new];
            instance.interactiveTransitioning = [STSwipeInteraction new];
        });
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        RootViewController *root = [self.storyboard instantiateViewControllerWithIdentifier:@"rootVC"];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:root];
        // 替代nav的delegate
        nav.navigationTransition = STTransitionMake(^(STTransition *instance) {
            instance.animationTransitioning = [STDirectionAnimation new];
            instance.interactiveTransitioning = STSwipeInteractionMake(^(STSwipeInteraction *instance) {
                // 交互方向反转，当目标viewController无interactiveTransitioning时，用此interactiveTransitioning
                instance.reverse = YES;
            });
        });
        
        // 替代nav的transitioningDelegate
        nav.transition = STTransitionMake(^(STTransition *instance) {
            instance.animationTransitioning = STDirectionAnimationMake(^(STDirectionAnimation *instance) {
                // 纵向动画
                instance.direction = STDirectionVertical;
            });
            instance.interactiveTransitioning = STSwipeInteractionMake(^(STSwipeInteraction *instance) {
                // 纵向交互
                instance.direction = STDirectionVertical;
            });
        });
        [self presentViewController:nav animated:YES completion:nil];
    }
}

@end
