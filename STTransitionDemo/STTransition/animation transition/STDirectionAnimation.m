//
//  STDirectionAnimation.m
//  STTransitionDemo
//
//  Created by zhenlintie on 15/7/6.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import "STDirectionAnimation.h"

@implementation STDirectionAnimation

- (instancetype)init{
    if (self = [super init]){
        _parallaxRatio = 0.5;
        _direction = STDirectionHorizontal;
        _reverse = NO;
    }
    return self;
}

- (void)presentTransition{
    [self.container addSubview:self.toView];
    
    CGAffineTransform fromViewEndT = [self parallaxOffsetT:self.fromView.frame];
    self.toView.transform = [self topViewPosition:self.toView.frame];
    
    [UIView animateWithDuration:[self transitionDuration:self.context]
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.fromView.transform = fromViewEndT;
                         self.toView.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                         self.fromView.transform = CGAffineTransformIdentity;
                         self.toView.transform = CGAffineTransformIdentity;
                         [self didCompleted];
                     }];
}

- (void)dismissTransition{
    [self.container insertSubview:self.toView belowSubview:self.fromView];
    
    self.toView.transform = [self parallaxOffsetT:self.toView.frame];
    CGAffineTransform fromViewEndT = [self topViewPosition:self.fromView.frame];
    
    self.fromView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.fromView.layer.shadowOpacity = 0.43*(1-_parallaxRatio);
    self.fromView.layer.shadowRadius = 8;
    self.fromView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.fromView.bounds].CGPath;
    
    [UIView animateWithDuration:[self transitionDuration:self.context]
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.fromView.transform = fromViewEndT;
                         self.toView.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                         self.toView.transform = CGAffineTransformIdentity;
                         self.fromView.transform = CGAffineTransformIdentity;
                         self.fromView.layer.shadowColor = nil;
                         [self didCompleted];
                     }];
}

- (CGAffineTransform)parallaxOffsetT:(CGRect)frame{
    BOOL h = (_direction == STDirectionHorizontal);
    return CGAffineTransformMakeTranslation(h?-(1.0-_parallaxRatio)*CGRectGetWidth(frame)*[self reverseFactor]:0,h?0:-(1.0-_parallaxRatio)*CGRectGetHeight(frame)*[self reverseFactor]);
}

- (CGAffineTransform)topViewPosition:(CGRect)frame{
    BOOL h = (_direction == STDirectionHorizontal);
    return CGAffineTransformMakeTranslation(h?CGRectGetWidth(frame)*[self reverseFactor]:0, h?0:CGRectGetHeight(frame)*[self reverseFactor]);
}

- (int)reverseFactor{
    return _reverse?-1:1;
}

@end
