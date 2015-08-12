//
//  STSwipeInteraction.m
//  STTransitionDemo
//
//  Created by zhenlintie on 15/7/6.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import "STSwipeInteraction.h"

@implementation STSwipeInteraction

- (instancetype)init{
    if (self = [super init]){
        _direction = STDirectionHorizontal;
        _reverse = NO;
    }
    return self;
}

- (Class)gestureRecognizerClass{
    return [UIPanGestureRecognizer class];
}

- (void)handlerGesture:(UIPanGestureRecognizer *)gesture{
    CGFloat progress;
    if (_direction == STDirectionHorizontal){
        progress = [gesture translationInView:self.viewController.view.superview].x / (self.viewController.view.superview.bounds.size.width * 1);
    }
    else{
        progress = [gesture translationInView:self.viewController.view.superview].y / (self.viewController.view.superview.bounds.size.height * 1);
    }
    progress = MIN(1.0, MAX(0.0, progress*(_reverse?-1:1)));

    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:{
            CGFloat shouldBeginOffset = (_direction == STDirectionHorizontal)?[gesture translationInView:self.viewController.view].x:[gesture translationInView:self.viewController.view].y;
            if (_reverse?(shouldBeginOffset<0):(shouldBeginOffset>0)){
                if (STTransitionPop == self.type){
                    self.onInteractiving = YES;
                    [self.viewController.navigationController popViewControllerAnimated:YES];
                }
                else if (STTransitionDismiss == self.type){
                    self.onInteractiving = YES;
                    [self.viewController dismissViewControllerAnimated:YES completion:nil];
                }
            }
            break;
        }
        case UIGestureRecognizerStateChanged:{
            [self updateInteractiveTransition:progress];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:{
            if (self.onInteractiving){
                CGPoint v = [gesture velocityInView:self.viewController.view.superview];
                BOOL shouldFinished = NO;
                CGFloat maxV = 500;
                if (_reverse){
                    if (_direction == STDirectionHorizontal){
                        shouldFinished = v.x<-maxV;
                    }
                    else{
                        shouldFinished = v.y<-maxV;
                    }
                }
                else{
                    if (_direction == STDirectionHorizontal){
                        shouldFinished = v.x>maxV;
                    }
                    else{
                        shouldFinished = v.y>maxV;
                    }
                }
                
                if (progress > 0.43 || shouldFinished) {
                    [self finishInteractiveTransition];
                }
                else {
                    [self cancelInteractiveTransition];
                }
                self.onInteractiving = NO;
            }
            break;
        }
        default:
            break;
    }
}

@end
