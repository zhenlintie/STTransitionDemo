//
//  STTransition.h
//  STTransition
//
//  Created by zhenlintie on 15/7/6.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STMacros.h"

typedef NS_ENUM(NSInteger, STTransitionType) {
    STTransitionNone,
    STTransitionPush,
    STTransitionPop,
    STTransitionPresent,
    STTransitionDismiss,
    STTransitionTabToLeft,
    STTransitionTabToRight
};

@class STAnimatedTransitioning;
@class STInteractiveTransitioning;

@interface STTransition : NSObject
<UINavigationControllerDelegate,
UIViewControllerTransitioningDelegate,
UITabBarControllerDelegate>

/**
 * 动画控制
 */
@property (strong, nonatomic) STAnimatedTransitioning *animationTransitioning;

/**
 * 交互控制
 */
@property (strong, nonatomic) STInteractiveTransitioning *interactiveTransitioning;

@end

STDefineMake(STTransition)

@interface UIViewController (STTransition)

/**
 * 替代UIViewController的transitioningDelegate
 */
@property (strong, nonatomic) STTransition *transition;

@end

@interface UINavigationController (STTransition)

/**
 * 替代UINavigationController的delegate
 */
@property (strong, nonatomic) STTransition *navigationTransition;

@end

@interface UITabBarController (STTransition)

/**
 * 替代UITabBarController的delegate
 */
@property (strong, nonatomic) STTransition *tabBarTransition;

@end
