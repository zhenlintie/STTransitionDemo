//
//  STDirectionAnimation.h
//  STTransitionDemo
//
//  Created by zhenlintie on 15/7/6.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import "STAnimatedTransitioning.h"

@interface STDirectionAnimation : STAnimatedTransitioning

@property (assign, nonatomic) CGFloat parallaxRatio;// 0.0 ~ 1.0 默认0.5

@property (assign, nonatomic) STDirection direction;// 默认STDirectionHorizontal

@property (assign, nonatomic) BOOL reverse;// 默认NO，present从下到上，push从右到左。

@end

STDefineMake(STDirectionAnimation)
