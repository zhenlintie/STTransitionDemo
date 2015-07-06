//
//  STAnimatedTransitioning.h
//  STTransition
//
//  Created by zhenlintie on 15/7/6.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STTransition.h"

@protocol STAnimatedTransitioning <NSObject>
- (void)didCompleted;// 动画结束
@optional
- (void)pushTransition;
- (void)popTransition;
- (void)presentTransition;
- (void)dismissTransition;
- (void)tabToLeft;
- (void)tabToRight;
@end

extern CGFloat const kSTDefaultDuration;// 默认动画时间 0.35

@interface STAnimatedTransitioning : NSObject <STAnimatedTransitioning, UIViewControllerAnimatedTransitioning>

@property (assign, nonatomic) STTransitionType type;

@property (weak, nonatomic, readonly) id <UIViewControllerContextTransitioning> context;

@property (weak, nonatomic, readonly) UIView *fromView;
@property (weak, nonatomic, readonly) UIView *toView;
@property (weak, nonatomic, readonly) UIView *container;

@property (weak, nonatomic, readonly) UIViewController *fromViewController;
@property (weak, nonatomic, readonly) UIViewController *toViewController;

@end

