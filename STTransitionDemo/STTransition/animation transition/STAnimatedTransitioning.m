//
//  STAnimatedTransitioning.m
//  STTransition
//
//  Created by zhenlintie on 15/7/6.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import "STAnimatedTransitioning.h"


CGFloat const kSTDefaultDuration = 0.35;// 默认动画时间

@interface STAnimatedTransitioning ()

@end

@implementation STAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext;{
    return kSTDefaultDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    _context = transitionContext;
    _fromViewController = STFromViewControllerView(_context);
    _toViewController = STToViewControllerView(_context);
    _fromView = STFromView(_context);
    _toView = STToView(_context);
    _container = [_context containerView];
    switch (self.type) {
        case STTransitionPush:{
            [self pushTransition];
            break;
        }
        case STTransitionPop:{
            [self popTransition];
            break;
        }
        case STTransitionPresent:{
            [self presentTransition];
            break;
        }
        case STTransitionDismiss:{
            [self dismissTransition];
            break;
        }
        case STTransitionTabToLeft:{
            [self tabToLeft];
            break;
        }
        case STTransitionTabToRight:{
            [self tabToRight];
            break;
        }
        default:
            break;
    }
}

- (void)didCompleted{
    [_context completeTransition:![_context transitionWasCancelled]];
}

- (void)pushTransition{
    [self presentTransition];
}

- (void)popTransition{
    [self dismissTransition];
}

- (void)tabToRight{
    [self pushTransition];
}

- (void)tabToLeft{
    [self popTransition];
}

- (void)presentTransition{}

- (void)dismissTransition{}

@end
