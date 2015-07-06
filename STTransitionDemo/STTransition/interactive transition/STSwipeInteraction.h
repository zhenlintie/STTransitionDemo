//
//  STSwipeInteraction.h
//  STTransitionDemo
//
//  Created by zhenlintie on 15/7/6.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import "STInteractiveTransitioning.h"

@interface STSwipeInteraction : STInteractiveTransitioning

@property (assign, nonatomic) STDirection direction;// 默认STDirectionHorizontal

@property (assign, nonatomic) BOOL reverse;// 默认NO，dismiss从上向下，push从左向右。

@end

STDefineMake(STSwipeInteraction)
