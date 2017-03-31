

#import <UIKit/UIKit.h>
#import "WXSTypedefConfig.h"
@interface WXSTransitionManager : NSObject<UIViewControllerAnimatedTransitioning>


@property (nonatomic, assign) NSTimeInterval                    animationTime;
// 交互类型
@property (nonatomic, assign) WXSTransitionType                 transitionType;
// 动画类型
@property (nonatomic, assign) WXSTransitionAnimationType        animationType;
// 返回的动画类型
@property (nonatomic, assign) WXSTransitionAnimationType        backAnimationType;
// 返回的手势类型
@property (nonatomic, assign) WXSGestureType                    backGestureType;

// 开始视图
@property (nonatomic, weak) UIView                              *startView;
// 目标视图
@property (nonatomic, weak) UIView                              *targetView;

//
@property (nonatomic, assign) BOOL                              isSysBackAnimation;
//是否自动显示和隐藏Nav
@property (nonatomic, assign) BOOL                              autoShowAndHideNavBar;
//返回手势是否可用
@property (nonatomic, assign) BOOL                              backGestureEnable;

//将要结束交互的回调
@property (nonatomic, copy) void(^willEndInteractiveBlock)(BOOL success);
//动画完成的回调
@property (nonatomic, copy) void(^completionBlock)();


+(WXSTransitionManager *)copyPropertyFromObjcet:(id)object toObjcet:(id)targetObjcet;



@end
