//
//  ViewController.h
//  AppraisalSystem
//
//  Created by Ardee on 16/4/12.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BmobSDK/Bmob.h>

@interface ViewController : UIViewController<UITextFieldDelegate>
{
    BOOL _isEye;
    __weak IBOutlet UILabel *_userNameLabel;
    __weak IBOutlet UILabel *_userPwdLabel;
    
}
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *userPwdTF;
@property (weak, nonatomic) IBOutlet UIButton *pedEye;

@end

