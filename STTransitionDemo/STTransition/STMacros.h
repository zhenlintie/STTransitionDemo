//
//  STMacros.h
//  STTransition
//
//  Created by zhenlintie on 15/7/6.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#ifndef STTransition_STMacros_h
#define STTransition_STMacros_h

typedef NS_ENUM(NSUInteger, STDirection) {
    STDirectionHorizontal,
    STDirectionVertical
};

// macros
// 定义实例生成方法
#define STDefineMake(CN) static inline CN * CN##Make(void (^maker_block)(CN *instance)){\
                            CN *instance = [CN new];\
                            if (maker_block){\
                                maker_block(instance);\
                            }\
                            return instance;\
                         }

// 方便获取transition context的fromView和toView
static inline UIViewController *st_contextViewController(id<UIViewControllerContextTransitioning> context, NSString *key){
    return [context viewControllerForKey:key];
}
static inline UIView *st_contextView(id<UIViewControllerContextTransitioning> context, NSString *key){
    return st_contextViewController(context, key).view;
    
}
#define STFromView(context) st_contextView(context, UITransitionContextFromViewControllerKey)
#define STToView(context) st_contextView(context, UITransitionContextToViewControllerKey)
#define STFromViewControllerView(context) st_contextViewController(context, UITransitionContextFromViewControllerKey)
#define STToViewControllerView(context) st_contextViewController(context, UITransitionContextToViewControllerKey)

#endif
