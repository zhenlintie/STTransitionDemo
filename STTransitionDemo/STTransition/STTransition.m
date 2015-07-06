//
//  STTransition.m
//  STTransition
//
//  Created by zhenlintie on 15/7/6.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import "STTransition.h"
#import "STAnimatedTransitioning.h"
#import "STInteractiveTransitioning.h"
#import <objc/runtime.h>

@interface STTransition ()
@end

@implementation STTransition{
    STInteractiveTransitioning *_popInteraction;
}

#pragma mark - UIViewController transitioning delegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    self.animationTransitioning.type = STTransitionPresent;
    if (self.interactiveTransitioning){
        self.interactiveTransitioning.viewController = presented;
        self.interactiveTransitioning.type = STTransitionDismiss;
    }
    return self.animationTransitioning;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    self.animationTransitioning.type = STTransitionDismiss;
    return self.animationTransitioning;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator{
    return nil;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
    return self.interactiveTransitioning.onInteractiving&&animator?self.interactiveTransitioning:nil;
}

#pragma mark - UINavigationController delegate

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{
    return _popInteraction&&_popInteraction.onInteractiving&&animationController?_popInteraction:nil;
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    BOOL push = (UINavigationControllerOperationPush == operation);
    STAnimatedTransitioning *animation = push?toVC.transition.animationTransitioning:fromVC.transition.animationTransitioning;
    if (!animation){
        animation = self.animationTransitioning;
    }
    animation.type = push?STTransitionPush:STTransitionPop;
    
    STInteractiveTransitioning *interaction = push?toVC.transition.interactiveTransitioning:nil;
    if (push){
        if (!interaction){
            interaction = self.interactiveTransitioning;
        }
        if (interaction){
            interaction.viewController = toVC;
            interaction.type = STTransitionPop;
        }
        _popInteraction = interaction;
    }
    
    return animation;
}

#pragma mark - UITabBarController delegate

- (id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
            animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                              toViewController:(UIViewController *)toVC{
    NSInteger fromIndex = [[tabBarController viewControllers] indexOfObject:fromVC];
    NSInteger toIndex = [[tabBarController viewControllers] indexOfObject:toVC];
    self.animationTransitioning.type = (fromIndex<toIndex)?STTransitionTabToRight:STTransitionTabToLeft;
    return self.animationTransitioning;
}

@end


static void *const kVCSTTransition = (void *) &kVCSTTransition;
@implementation UIViewController (STTransition)

- (STTransition *)transition{
    return objc_getAssociatedObject(self, kVCSTTransition);
}

- (void)setTransition:(STTransition *)transition{
    self.transitioningDelegate = transition;
    objc_setAssociatedObject(self, kVCSTTransition, transition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

static void *const kNCSTTransition = (void *) &kNCSTTransition;
@implementation UINavigationController (STTransition)

- (STTransition *)navigationTransition{
    return objc_getAssociatedObject(self, kNCSTTransition);
}

- (void)setNavigationTransition:(STTransition *)navigationTransition{
    self.delegate = navigationTransition;
    objc_setAssociatedObject(self, kNCSTTransition, navigationTransition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

static void *const kTCSTTransition = (void *) &kTCSTTransition;
@implementation UITabBarController (STTransition)

- (STTransition *)tabBarTransition{
    return objc_getAssociatedObject(self, kTCSTTransition);
}

- (void)setTabBarTransition:(STTransition *)tabBarTransition{
    self.delegate = tabBarTransition;
    objc_setAssociatedObject(self, kTCSTTransition, tabBarTransition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
