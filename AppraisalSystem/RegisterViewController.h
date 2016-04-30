//
//  RegisterViewController.h
//  AppraisalSystem
//
//  Created by Ardee on 16/4/12.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BmobSDK/Bmob.h>

@interface RegisterViewController : UIViewController<UITextFieldDelegate>
{
    __weak IBOutlet UITextField *_newUserName;
    __weak IBOutlet UITextField *_pwdOnce;
    __weak IBOutlet UITextField *_pwdTwice;
    __weak IBOutlet UITextField *_userTel;
    __weak IBOutlet UILabel *_newUserLabel;
    __weak IBOutlet UILabel *_pwdOnceLabel;
    __weak IBOutlet UILabel *_pwdTwiceLabel;
    __weak IBOutlet UILabel *_telLabel;
    __weak IBOutlet UIButton *_subjectBtn;
    __weak IBOutlet UIButton *_isHeadTeachBtn;
    
}
@end
