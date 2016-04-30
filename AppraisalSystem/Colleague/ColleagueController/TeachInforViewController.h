//
//  TeachInforViewController.h
//  AppraisalSystem
//
//  Created by Ardee on 16/4/24.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BmobSDK/Bmob.h>

@protocol XWPresentedOneControllerDelegate <NSObject>

- (void)presentedOneControllerPressedDissmiss;
- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPresent;

@end

@interface TeachInforViewController : UIViewController
{
    __weak IBOutlet UILabel *_userName;
    __weak IBOutlet UILabel *_userSex;
    __weak IBOutlet UILabel *_userSubject;
    __weak IBOutlet UILabel *_userTel;
    __weak IBOutlet UILabel *_userClass1;
    __weak IBOutlet UILabel *_userClass2;
    __weak IBOutlet UILabel *_userClass3;
    
}
@property (nonatomic, assign) id<XWPresentedOneControllerDelegate> delegate;
@property (nonatomic,assign) BmobObject *teachObject;
@end
