//
//  WXSTransitionManager+SystermAnimation.m
//  WXSTransition
//
//  Created by AlanWang on 16/9/22.
//  Copyright © 2016年 王小树. All rights reserved.
//

#import "WXSTransitionManager+SystermAnimation.h"
#import "WXSTransitionManager+TypeTool.h"



@implementation WXSTransitionManager (SystermAnimation)


/* push 或者 pop 处理 **/
-(void)sysTransitionNextAnimationWithType:(WXSTransitionAnimationType)type
                                  context:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    /* 因为在 下面会 把 fromVC 和 toVC的 view 添加到 containerView 中，这个时候就很可能在执行动画的时候 出现黑色的 背景 **/
    UIView *snapToView   = [toVC.view snapshotViewAfterScreenUpdates:YES];
    UIView *snapFromView = [fromVC.view snapshotViewAfterScreenUpdates:YES];
    
    /* 通过转场上下文 的containerView 来操作添加 fromView 和 toView**/
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];
    
    /* 这两句话 可以不用 **/
//    [containerView bringSubviewToFront:fromVC.view];
//    [containerView bringSubviewToFront:toVC.view];
    
    /* 执行 系统的 CATransition **/
    CATransition *tranAnimation = [self getSysTransitionWithType:type];
    [containerView.layer addAnimation:tranAnimation forKey:nil];
    
    /* tranAnimation 在捕获了 - (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag; 会有个 回调 **/
    self.completionBlock = ^(){
        
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
        }else{
            [transitionContext completeTransition:YES];
            toVC.view.hidden = NO;
        }
        /* 打印了tempView.superview 是 nil  **/
        [snapToView   removeFromSuperview];
        [snapFromView removeFromSuperview];
    };
    
}

-(void)sysTransitionBackAnimationWithType:(WXSTransitionAnimationType)type
                                  context:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *snapToView   = [toVC.view snapshotViewAfterScreenUpdates:YES];
    UIView *snapFromView = [fromVC.view snapshotViewAfterScreenUpdates:YES];
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];
    
    CATransition *tranAnimation = [self getSysTransitionWithType:type];
    [containerView.layer addAnimation:tranAnimation forKey:nil];
    
    __weak UIViewController * weakToVC = toVC;
    self.completionBlock = ^(){
        
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
        }else{
            [transitionContext completeTransition:YES];
        }
        weakToVC.view.hidden = NO;
        
        [snapToView removeFromSuperview];
        [snapFromView removeFromSuperview];
    };
   
    self.willEndInteractiveBlock = ^(BOOL success) {
        
        if (success) {
            weakToVC.view.hidden = NO;
        }else{
            weakToVC.view.hidden = YES;
            [snapToView removeFromSuperview];
            [snapFromView removeFromSuperview];
        }
    };
}

@end
