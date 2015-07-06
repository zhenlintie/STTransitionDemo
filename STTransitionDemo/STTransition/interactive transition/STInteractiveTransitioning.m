//
//  STInteractiveTransitioning.m
//  STTransition
//
//  Created by zhenlintie on 15/7/6.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import "STInteractiveTransitioning.h"

@interface STInteractiveTransitioning ()

@end

@implementation STInteractiveTransitioning

- (void)dealloc{
    [_interactiveGesture.view removeGestureRecognizer:self.interactiveGesture];
    _interactiveGesture = nil;
}

- (instancetype)init{
    if (self = [super init]){
        _enable = YES;
        _onInteractiving = NO;
    }
    return self;
}

- (void)setViewController:(UIViewController *)viewController{
    if (!self.interactiveGesture){
        _interactiveGesture = [[[self gestureRecognizerClass] alloc] initWithTarget:self action:@selector(handlerGesture:)];
        _interactiveGesture.delegate = self;                    
    }
    if (self.interactiveGesture.view){
        [self.interactiveGesture.view removeGestureRecognizer:self.interactiveGesture];
    }
    _viewController = viewController;
    [_viewController.view addGestureRecognizer:self.interactiveGesture];
}

- (void)setEnable:(BOOL)enable{
    _enable = enable;
    _interactiveGesture.enabled = enable;
}

#pragma mark - STInteractiveTransitioning

- (Class)gestureRecognizerClass{
    return nil;
}

- (void)handlerGesture:(UIPanGestureRecognizer *)gesture{}

@end
