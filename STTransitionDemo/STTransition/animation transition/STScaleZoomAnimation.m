//
//  STScaleZoomAnimation.m
//  STTransitionDemo
//
//  Created by zhenlintie on 15/7/6.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import "STScaleZoomAnimation.h"

@implementation STScaleZoomAnimation{
    CGAffineTransform fromViewEndT;
    CGAffineTransform smallT, bigT;
    UIView *_fromV, *_toV;
}

- (instancetype)init{
    if (self = [super init]){
        _useSnapShot = YES;
        [self setFromRect:^CGRect{
            CGRect screenBounds = [UIScreen mainScreen].bounds;
            return CGRectInset(screenBounds, CGRectGetWidth(screenBounds)/4, CGRectGetHeight(screenBounds)/4);
        }];
    }
    return self;
}

- (void)initFactor{
    CGRect beginFrame = self.fromRect();
    CGFloat sx = CGRectGetWidth(self.fromView.frame)/CGRectGetWidth(beginFrame);
    CGFloat sy = CGRectGetHeight(self.fromView.frame)/CGRectGetHeight(beginFrame);
    
    smallT = CGAffineTransformMakeTranslation(CGRectGetMidX(beginFrame)-CGRectGetMidX(self.toView.frame), CGRectGetMidY(beginFrame)-CGRectGetMidY(self.toView.frame));
    smallT = CGAffineTransformScale(smallT, 1/sx, 1/sy);
    
    bigT = CGAffineTransformMakeTranslation(sx*(CGRectGetMidX(self.fromView.frame)-CGRectGetMidX(beginFrame)), sy*(CGRectGetMidY(self.fromView.frame)-CGRectGetMidY(beginFrame)));
    bigT = CGAffineTransformScale(bigT, sx, sy);
    
    if (_useSnapShot){
        _toV = [self.toView snapshotViewAfterScreenUpdates:YES];
        _fromV = [self.fromView snapshotViewAfterScreenUpdates:YES];
        self.toView.hidden = YES;
        self.fromView.hidden = YES;
        [self.container addSubview:_fromV];
    }
    else{
        _toV = self.toView;
        _fromV = self.fromView;
    }
    
    _toV.alpha = 0;
}

- (void)startAnimation{
    [UIView animateWithDuration:[self transitionDuration:self.context]
                          delay:0
         usingSpringWithDamping:1
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _toV.transform = CGAffineTransformIdentity;
                         _toV.alpha = 1;
                         _fromV.transform = fromViewEndT;
                         _fromV.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         _toV.transform = CGAffineTransformIdentity;
                         _toV.alpha = 1;
                         _fromV.transform = CGAffineTransformIdentity;
                         _fromV.alpha = 1;
                         if (_useSnapShot){
                             self.toView.hidden = NO;
                             self.fromView.hidden = NO;
                             [_toV removeFromSuperview];
                             [_fromV removeFromSuperview];
                             _toV = nil;
                             _fromV = nil;
                         }
                         [self didCompleted];
                     }];
}

- (void)presentTransition{
    [self.container addSubview:self.toView];
    [self initFactor];
    if (_useSnapShot){
        [self.container addSubview:_toV];
    }
    _toV.transform = smallT;
    fromViewEndT = bigT;
    [self startAnimation];
}

- (void)dismissTransition{
    [self.container insertSubview:self.toView belowSubview:self.fromView];
    [self initFactor];
    if (_useSnapShot){
        [self.container insertSubview:_toV belowSubview:_fromV];
    }
    _toV.transform = bigT;
    fromViewEndT = smallT;
    [self startAnimation];
}

- (CGRect (^)())fromRect{
    if (_fromRect){
        return _fromRect;
    }
    return ^CGRect (){
        return [UIScreen mainScreen].bounds;
    };
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.55;
}

@end
