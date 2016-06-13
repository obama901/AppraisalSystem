//
//  TeacherRemarkViewController.m
//  AppraisalSystem
//
//  Created by Ardee on 16/6/13.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import "TeacherRemarkViewController.h"
#import "GiFHUD.h"
#import "ClassMateEngine.h"

@interface TeacherRemarkViewController ()

{
    NSMutableArray *_sbjFromArr;
}
@end

@implementation TeacherRemarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateBtn];
    [self toShowTheTextRemark];
}
#pragma mark ----获取教师评语--
- (void)toShowTheTextRemark
{
    self.RemarkText.text = [self.bObject objectForKey:@"SdtRemark"];
    self.subjectTitle.text = [NSString stringWithFormat:@"%@评语：",self.sbjName];
    self.SdtName.text = [NSString stringWithFormat:@"%@同学",self.sdttName];
    [GiFHUD dismiss];
}
#pragma mark ----创建按钮和数组--
- (void)updateBtn
{
    _sbjFromArr = [[NSMutableArray alloc]initWithObjects:@"UserChinese",@"UserMath",@"UserEnglish",@"UserPhysics",@"UserChemistry",@"UserBiology",@"UserPolitics",@"UserHistory",@"UserGeography", nil];
    self.RemarkText.clipsToBounds = YES;
    self.RemarkText.layer.cornerRadius = 10;
}
#pragma mark ----保存按钮的点击方法--
- (IBAction)ButtonClick:(UIButton *)sender
{
    [ClassMateEngine updataRemarkWithStudentName:self.sdttName withNeedObject:self.bObject withFrom:[_sbjFromArr objectAtIndex:self.indexNumber] withSdtId:self.sdtId withReMark:self.RemarkText.text withComplentBlock:^(NSString *ssseee)
     {
         if ([ssseee isEqualToString:@"成功"])
         {
             UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"更新成功!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
             [alert show];
             [self.navigationController popToRootViewControllerAnimated:YES];
         } else if ([ssseee isEqualToString:@"失败"])
         {
             UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"更新失败😢" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
             [alert show];
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
