//
//  STScaleZoomAnimation.h
//  STTransitionDemo
//
//  Created by zhenlintie on 15/7/6.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import "STAnimatedTransitioning.h"

@interface STScaleZoomAnimation : STAnimatedTransitioning

// 一定程度上可缓解卡顿
@property (assign, nonatomic) BOOL useSnapShot;// 默认YES

// 起始区域
@property (strong, nonatomic) CGRect (^fromRect)();

@end

STDefineMake(STScaleZoomAnimation)
