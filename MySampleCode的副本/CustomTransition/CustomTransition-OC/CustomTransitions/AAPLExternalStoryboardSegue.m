/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 A custom storyboard segue that loads its destination view controller from an
  external storyboard (named by the segue's identifier), then presents it 
  modally.
 */

#import "AAPLExternalStoryboardSegue.h"

//  NOTE: iOS 9 introduces storyboard references which allow a segue to
//        target the initial scene in an external storyboard.  If your
//        application targets iOS 9 and above, you should use storyboard
//        references rather than the technique shown here.

@implementation AAPLExternalStoryboardSegue

//| ----------------------------------------------------------------------------
- (instancetype)initWithIdentifier:(NSString *)identifier source:(UIViewController *)source destination:(UIViewController *)destination
{
    // Load the storyboard named by this segue's identifier.
    UIStoryboard *externalStoryboard = [UIStoryboard storyboardWithName:identifier bundle:[NSBundle bundleForClass:self.class]];
    
    /*  destinnation: 原来是 Main.storyboard里面的导航控制器 
        现在需要把这个 目标 切换到 我们自定义中入口里面来（CrossDissolve.storyboard 里面的 入口控制器）
     * 这样 self.sourceViewController 不变
           self.destinationViewController 变成了我们的目标控制器了
     **/
    // Instantiate the storyboard's initial view controller.
    id initialViewController = [externalStoryboard instantiateInitialViewController];
    // 切换 destination的 源
    return [super initWithIdentifier:identifier source:source destination:initialViewController];
}


//| ----------------------------------------------------------------------------
- (void)perform
{
    [self.sourceViewController presentViewController:self.destinationViewController animated:YES completion:NULL];
}

@end
