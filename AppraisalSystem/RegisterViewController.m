//
//  RegisterViewController.m
//  AppraisalSystem
//
//  Created by Ardee on 16/4/12.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import "RegisterViewController.h"
#import "ViewController.h"
#import "LTPickerView.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _newUserName.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pwdOnce.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pwdTwice.clearButtonMode = UITextFieldViewModeWhileEditing;
    _userTel.clearButtonMode = UITextFieldViewModeWhileEditing;
}
#pragma mark ----注册按钮点击方法--
- (IBAction)registBtnClick:(UIButton *)sender
{
    BmobQuery *bQueryObj = [[BmobQuery alloc]init];
    NSString *bql = [NSString stringWithFormat: @"select * from UserTable where UserName = '%@'",_newUserName.text ];
    [bQueryObj queryInBackgroundWithBQL:bql block:^(BQLQueryResult *result, NSError *error) {
        if (error) {
            NSLog(@"error==%@",error);
        }
        else if (result){
            NSArray *array = [NSArray arrayWithArray:result.resultsAry];
            if (array.count==0) {
                if (![_pwdOnce.text isEqualToString:_pwdTwice.text])
                {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"密码不一致!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                } else if ([_pwdOnce.text isEqualToString:@""])
                {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"密码不能为空!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                } else if ([_newUserName.text isEqualToString:@""])
                {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名不能为空!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                } else if ([_userTel.text isEqualToString:@""])
                {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"电话号不能为空!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                } else if (_pwdOnce.text.length<6||_pwdOnce.text.length>20)
                {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"密码长度不符合要求!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                } else if (_newUserName.text.length<2||_newUserName.text.length>15)
                {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名长度不符合要求!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                } else if ([_userTel.text length]!=11)
                {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"电话号长度不符合要求!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                } else if (![self isPureInt:_userTel.text])
                {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"电话号不全为数字!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                } else if ([_subjectBtn.titleLabel.text isEqualToString:@"点击选择"])
                {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请选择科目！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                } else if ([_isHeadTeachBtn.titleLabel.text isEqualToString:@"点击选择"])
                {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请选择是否为班任！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                }
                else
                {
                    NSLog(@"开始注册");
                    BmobObject *bObj = [BmobObject objectWithClassName:@"UserTable"];
                    [bObj setObject:_newUserName.text forKey:@"UserName"];
                    [bObj setObject:_pwdOnce.text forKey:@"UserPwd"];
                    [bObj setObject:_userTel.text forKey:@"UserTel"];
                    [bObj setObject:_subjectBtn.titleLabel.text forKey:@"UserSubject"];
                    [bObj setObject:_isHeadTeachBtn.titleLabel.text forKey:@"UserHeadTeach"];
                    [bObj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                        if (isSuccessful) {
                            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"注册成功!!" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
                            [alert show];
                            [self performSelector:@selector(removeAlertView:) withObject:alert afterDelay:1];
                        } else if (error){
                            NSString *errorStr = [NSString stringWithFormat:@"%@",error];
                            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:errorStr delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
                            [alert show];
                            [self performSelector:@selector(removeAlertView:) withObject:alert afterDelay:1];
                            
                        }
                    }];
                }
            } else if (array.count!=0)
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"此用户名已被别人用啦!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
            
        }
        
    }];
}
#pragma mark ----扫描电话号是否都为数字的方法--
- (BOOL)isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
#pragma mark ----返回按钮点击方法--
- (IBAction)returnBtnClick:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark ----使alertView消失的方法--
- (void)removeAlertView:(UIAlertView *)alert
{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark ----选择科目点击方法--
- (IBAction)selectSubject:(UIButton *)sender
{
    LTPickerView* pickerView = [LTPickerView new];
    pickerView.dataSource = @[@"语文",@"数学",@"外语",@"物理",@"化学",@"生物",@"政治",@"历史",@"地理"];//设置要显示的数据
    pickerView.defaultStr = @"外语";//默认选择的数据
    [pickerView show];//显示
    //回调block
    pickerView.block = ^(LTPickerView* obj,NSString* str,int num){
        //obj:LTPickerView对象
        //str:选中的字符串
        //num:选中了第几行
        NSLog(@"选择了第%d行的%@",num,str);
        [_subjectBtn setTitle:[NSString stringWithFormat:@"%@",str] forState:UIControlStateNormal];
    };
}
#pragma mark ----选择是否为班任点击方法--
- (IBAction)isHeadTeacherClick:(UIButton *)sender
{
    LTPickerView* pickerView = [LTPickerView new];
    pickerView.dataSource = @[@"是",@"否"];//设置要显示的数据
    pickerView.defaultStr = @"是";//默认选择的数据
    [pickerView show];//显示
    //回调block
    pickerView.block = ^(LTPickerView* obj,NSString* str,int num){
        //obj:LTPickerView对象
        //str:选中的字符串
        //num:选中了第几行
        NSLog(@"选择了第%d行的%@",num,str);
        [_isHeadTeachBtn setTitle:[NSString stringWithFormat:@"%@",str] forState:UIControlStateNormal];
    };
}

#pragma mark ----在文本框编辑结束时显示提示的方法--
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 100:
            if ([_newUserName.text isEqualToString:@""])
            {
                _newUserLabel.text = @"🚫用户名不能为空!";
            }else if (_newUserName.text.length<2||_newUserName.text.length>15)
            {
                _newUserLabel.text = @"🚫用户名长度不符合要求!";
            }else
            {
                BmobQuery *bQueryObj = [[BmobQuery alloc]init];
                NSString *bql = [NSString stringWithFormat: @"select * from UserTable where UserName = '%@'",_newUserName.text ];
                [bQueryObj queryInBackgroundWithBQL:bql block:^(BQLQueryResult *result, NSError *error) {
                    if (error) {
                        _newUserLabel.text = [NSString stringWithFormat:@"🚫%@",error];
                    } else if (result){
                        NSArray *array = [NSArray arrayWithArray:result.resultsAry];
                        if (array.count != 0) {
                            _newUserLabel.text = @"🚫已有人用了这个用户名!";
                        }else
                        {
                            _newUserLabel.text = @"✅用户名格式正确.";
                        }
                    }
                }];
                
            }
            break;
        case 200:
            if ([_pwdOnce.text isEqualToString:@""])
            {
                _pwdOnceLabel.text = @"🚫密码不能为空!";
            }else if (_pwdOnce.text.length<6||_pwdOnce.text.length>20)
            {
                _pwdOnceLabel.text = @"🚫密码长度不符合要求!";
            }else
            {
                _pwdOnceLabel.text = @"✅密码格式正确.";
            }
            break;
        case 300:
            if (![_pwdOnce.text isEqualToString:_pwdTwice.text]) {
                _pwdTwiceLabel.text = @"🚫密码不一致!";
            }else
            {
                _pwdTwiceLabel.text = @"✅密码格式正确.";
            }
            break;
        case 400:
            if ([_userTel.text isEqualToString:@""])
            {
                _telLabel.text = @"🚫电话号不能为空!";
            }else if ([_userTel.text length]!=11)
            {
                _telLabel.text = @"🚫电话号长度不符合要求!";
            }else if (![self isPureInt:_userTel.text])
            {
                _telLabel.text = @"🚫电话号不全为数字!";
            }else
            {
                _telLabel.text = @"✅电话号格式正确.";
            }
            break;
        default:
            break;
    }
    self.view.center = CGPointMake(160, 240);
    return YES;
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
