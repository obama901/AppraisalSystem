//
//  TeachInforViewController.m
//  AppraisalSystem
//
//  Created by Ardee on 16/4/24.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import "TeachInforViewController.h"
#import "XWInteractiveTransition.h"
#import "XWPresentOneTransition.h"
#import "GiFHUD.h"
#import "UIImage+GIF.h"
#import "MBProgressHUD+LJ.h"

@interface TeachInforViewController ()<UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) XWInteractiveTransition *interactiveDismiss;
@property (nonatomic, strong) XWInteractiveTransition *interactivePush;
@end

@implementation TeachInforViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [GiFHUD dismiss];//结束加载。。
    self.view.layer.cornerRadius = 10;
    self.view.layer.masksToBounds = YES;
    
    self.interactiveDismiss = [XWInteractiveTransition interactiveTransitionWithTransitionType:XWInteractiveTransitionTypeDismiss GestureDirection:XWInteractiveTransitionGestureDirectionDown];
    [self.interactiveDismiss addPanGestureForViewController:self];
    [self toViewTeacherInformation];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}
#pragma mark ----接收值来显示教师的信息--
- (void)toViewTeacherInformation
{
    _userName.text = [_teachObject objectForKey:@"UserName"];
    _userSubject.text = [_teachObject objectForKey:@"UserSubject"];
    _userTel.text = [_teachObject objectForKey:@"UserTel"];
}
#pragma mark ----下面四个方法是转场动画的代理方法--
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [XWPresentOneTransition transitionWithTransitionType:XWPresentOneTransitionTypePresent];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [XWPresentOneTransition transitionWithTransitionType:XWPresentOneTransitionTypeDismiss];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return _interactiveDismiss.interation ? _interactiveDismiss : nil;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator{
    XWInteractiveTransition *interactivePresent = [_delegate interactiveTransitionForPresent];
    return interactivePresent.interation ? interactivePresent : nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
