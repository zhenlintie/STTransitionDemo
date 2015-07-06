//
//  STInteractiveTransitioning.h
//  STTransition
//
//  Created by zhenlintie on 15/7/6.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STTransition.h"

@protocol STInteractiveTransitioning <UIGestureRecognizerDelegate>

@required
- (Class)gestureRecognizerClass;
- (void)handlerGesture:(UIGestureRecognizer *)gesture;

@end

@interface STInteractiveTransitioning : UIPercentDrivenInteractiveTransition <STInteractiveTransitioning>

// 需要交互的viewController
@property (weak, nonatomic) UIViewController *viewController;

@property (strong, nonatomic, readonly) UIGestureRecognizer *interactiveGesture;

@property (assign, nonatomic) BOOL onInteractiving;

// 交互开关
@property (assign, nonatomic) BOOL enable;

@property (assign, nonatomic) STTransitionType type;

@end
