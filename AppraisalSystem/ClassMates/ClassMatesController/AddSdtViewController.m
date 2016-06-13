//
//  AddSdtViewController.m
//  AppraisalSystem
//
//  Created by Ardee on 16/6/14.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import "AddSdtViewController.h"
#import "ClassMateEngine.h"
#import "LTAlertView.h"

@interface AddSdtViewController ()

@end

@implementation AddSdtViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark ----添加学生的按钮点击事件--
- (IBAction)AddButtonClick:(UIButton *)sender
{
    [ClassMateEngine AddStudentToClassRoomWithSdtName:_sdtNameField.text withSdtId:[NSNumber numberWithInt:[_sdtIdField.text intValue]] withClassName:self.className withcomlpentBlock:^(NSString *ssseee) {
        if ([ssseee isEqualToString:@"成功"])
        {
            [LTAlertView showTitle:@"添加成功！！" message:@"" ButtonTitles:@[@"确认",@"取消"] OnTapBlock:^(LTAlertView* alert,NSInteger num)
            {
                [self.navigationController popViewControllerAnimated:YES];
//                NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//                [center postNotificationName:@"添加学生" object:nil];
            }];
        } else if ([ssseee isEqualToString:@"失败"])
        {
            [LTAlertView showTitle:@"添加失败！！" message:@"原因可能是网络问题也可能是学号以存在" ButtonTitles:@[@"确认"] OnTapBlock:^(LTAlertView* alert,NSInteger num)
             {
                 
             }];
        }
        
        
    }];
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
