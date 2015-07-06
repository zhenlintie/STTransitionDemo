# STTransition

## 说明

STTransition一个视图控制器(`ViewController`)**转场动画**及**交互**的控制器。


* 内置了两个常用的动画：
	1. `STScaleZoomAnimation`
	2. `STDirectionAnimation`
* 一个常用的手势交互
	1. `STSwipeInteraction`
	
并且可通过**设置属性**来调整需要

## 主要用法
1. 替代`UIViewController`的`transitioningDelegate`

	```
vc.transition = STTransitionMake(^(STTransition *instance) {
			 // 动画
            instance.animationTransitioning = STScaleZoomAnimationMake(^(STScaleZoomAnimation *instance) {
            instance.fromRect = ^CGRect(){
                return CGRectMake(20, 20, 100, 100);
            };
        });
       	    // 交互
        	instance.interactiveTransitioning = STSwipeInteractionMake(^(STSwipeInteraction *instance) {
        	   // 交互方向
         	   instance.direction = STDirectionHorizontal;
         	   // 交互方向反转
            	instance.reverse = YES;
        	});
        });
	```

2. 替代`UINavigationController`的`delegate`

	```
nav.navigationTransition = STTransitionMake(^(STTransition *instance) {
            instance.animationTransitioning = STDirectionAnimationMake(^(STDirectionAnimation *instance) {
                // 纵向动画
                instance.direction = STDirectionVertical;
            });
            instance.interactiveTransitioning = STSwipeInteractionMake(^(STSwipeInteraction *instance) {
                // 纵向交互
                instance.direction = STDirectionVertical;
            });
        });

	
	```
	
## 截图
![](https://github.com/zhenlintie/STTransitionDemo/raw/master/screen.gif)