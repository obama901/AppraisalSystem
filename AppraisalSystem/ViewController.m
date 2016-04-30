//
//  ViewController.m
//  AppraisalSystem
//
//  Created by Ardee on 16/4/12.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import "ViewController.h"
#import "RegisterViewController.h"
#import "TabViewController.h"
#import "GiFHUD.h"
#import "UIImage+GIF.h"
#import "MBProgressHUD+LJ.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _userPwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _userNameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _isEye = YES;
}
#pragma mark ----登陆按钮点击事件--
- (IBAction)loginBtnClick:(UIButton *)sender
{
    [GiFHUD setGifWithImageName:@"pika2.gif"];
    [GiFHUD show];//正在加载。。
    BmobQuery *bQey = [[BmobQuery alloc]init];
    NSString *bql = [NSString stringWithFormat: @"select * from UserTable where UserName = '%@'",_userNameTF.text];
    [bQey queryInBackgroundWithBQL:bql block:^(BQLQueryResult *result, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        } else if (result){
            NSArray *array = [NSArray arrayWithArray:result.resultsAry];
            if (array.count==0) {
                _userNameLabel.text = @"🚫不存在的用户名";
                [GiFHUD dismiss];//结束加载。。
            } else {
                for (BmobObject *obj in array) {
                    NSLog(@"result is userPwd==%@",[obj objectForKey:@"UserPwd"]);
                    if ([_userPwdTF.text isEqualToString:[obj objectForKey:@"UserPwd"]]) {
                        NSLog(@"登陆成功,准备跳转!");
                        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                        [ud setObject:_userNameTF.text forKey:@"userName"];
                        [ud setInteger:1 forKey:@"userState"];
                        [self creatTabBarPage];
                    } else {
                        _userPwdLabel.text = @"🚫密码错误!!";
                        [GiFHUD dismiss];//结束加载。。
                    }
                }
            }
        }
    }];
}
- (void)creatTabBarPage
{
    [GiFHUD dismiss];//结束加载。。
    TabViewController *tabVC = [[TabViewController alloc]init];
    UIWindow *window = [[[UIApplication sharedApplication]delegate] window];
    window.rootViewController = tabVC;
}
#pragma mark ----注册按钮点击事件--
- (IBAction)rigisterBtn:(UIButton *)sender
{
    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    [self presentViewController:registerVC animated:YES completion:nil];
}
#pragma mark ----隐藏密码方法--
- (IBAction)closeOpenEye:(UIButton *)sender
{
    if (_isEye==NO) {
        [_pedEye setImage:[UIImage imageNamed:@"eye_open"] forState:UIControlStateNormal];
        _userPwdTF.secureTextEntry = YES;
        _isEye = YES;
    }else
    {
        [_pedEye setImage:[UIImage imageNamed:@"eye_closed"] forState:UIControlStateNormal];
        _userPwdTF.secureTextEntry = NO;
        _isEye = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
