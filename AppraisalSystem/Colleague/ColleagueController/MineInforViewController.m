//
//  MineInforViewController.m
//  AppraisalSystem
//
//  Created by Ardee on 16/5/10.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import "MineInforViewController.h"
#import "LTPickerView.h"
#import <BmobSDK/Bmob.h>

@interface MineInforViewController ()

{
    NSMutableArray *_ourClassData;
    UIBarButtonItem *_saveBtn;
}
@end

@implementation MineInforViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ourClass];
    [self ourButton];
}
#pragma mark ----为按钮添加点击事件--
- (void)ourButton
{
    [_mineSex addTarget:self action:@selector(chanceSex) forControlEvents:UIControlEventTouchUpInside];
    [_mineClass1 addTarget:self action:@selector(chanceClass:) forControlEvents:UIControlEventTouchUpInside];
    [_mineClass2 addTarget:self action:@selector(chanceClass:) forControlEvents:UIControlEventTouchUpInside];
    [_mineClass3 addTarget:self action:@selector(chanceClass:) forControlEvents:UIControlEventTouchUpInside];
    _saveBtn = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveMineInformation)];
    self.navigationItem.rightBarButtonItem = _saveBtn;
    
}
#pragma mark ----创建有多少班级的数据源--
- (void)ourClass
{
    _ourClassData = [[NSMutableArray alloc]initWithObjects:@"高一1班",@"高一2班",@"高一3班",@"高一4班",@"高一5班",@"高一6班",@"高一7班",@"高一8班",@"高一9班",@"高一10班",@"高二1班",@"高二2班",@"高二3班",@"高二4班",@"高二5班",@"高二6班",@"高二7班",@"高二8班",@"高二9班",@"高二10班",@"高三1班",@"高三2班",@"高三3班",@"高三4班",@"高三5班",@"高三6班",@"高三7班",@"高三8班",@"高三9班",@"高三10班", nil];
//    BmobQuery *query = [[BmobQuery alloc] init];
//    NSString *sql = [NSString stringWithFormat:@"select * from UserTable where UserName = '%@'",_mineName.text];
//    [query queryInBackgroundWithBQL:sql block:^(BQLQueryResult *result, NSError *error)
//     {
//         if (error)
//         {
//             NSLog(@"error=%@",error);
//         }
//         else if(result)
//         {
//             NSArray *resultArr = [NSArray arrayWithArray:result.resultsAry];
//             for (BmobObject *bObject in resultArr)
//             {
//                 _bmobOjt = bObject;
//             }
//         }
//     }];
}
#pragma mark ----保存按钮的点击事件--
- (void)saveMineInformation
{
    [_mineObject setObject:_mineName.text forKey:@"UserName"];
    [_mineObject setObject:_mineSex.titleLabel.text forKey:@"UserSex"];
    [_mineObject setObject:_mineTel.text forKey:@"UserTel"];
    [_mineObject updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error)
    {
        if (error)
        {
            NSLog(@"error=======%@",error);
        } else if (isSuccessful)
        {
            NSLog(@"更新成功！！");
            if ([_mineClass1.titleLabel.text isEqualToString:@"添加班级"]) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }
    }];//对除了班级的其他信息的更新
    if (![_mineClass1.titleLabel.text isEqualToString:@"添加班级"])
    {
        BmobObject *bObj = [BmobObject objectWithClassName:@"UserClass"];
        [bObj setObject:[_mineObject objectForKey:@"UserName"] forKey:@"UserName"];
        [bObj setObject:_mineClass1.titleLabel.text forKey:@"Class1"];
        if (![_mineClass2.titleLabel.text isEqualToString:@"添加班级"])
        {
            [bObj setObject:_mineClass2.titleLabel.text forKey:@"Class2"];
            if (![_mineClass3.titleLabel.text isEqualToString:@"添加班级"])
            {
                [bObj setObject:_mineClass3.titleLabel.text forKey:@"Class3"];
            }
        }
        if ([_mineClass1.titleLabel.text isEqualToString:_mineClass2.titleLabel.text]||[_mineClass1.titleLabel.text isEqualToString:_mineClass3.titleLabel.text]||[_mineClass2.titleLabel.text isEqualToString:_mineClass3.titleLabel.text])
        {
            if (![_mineClass2.titleLabel.text isEqualToString:@"添加班级"])
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"不可以拥有两个相同班级！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
            else
            {
                BmobQuery *query = [[BmobQuery alloc] init];
                NSString *sql = [NSString stringWithFormat:@"select * from UserClass where UserName = '%@'",_mineName.text];
                [query queryInBackgroundWithBQL:sql block:^(BQLQueryResult *result, NSError *error)
                 {
                     if (error)
                     {
                         NSLog(@"error=%@",error);
                     }
                     else if(result)
                     {
                         NSArray *resultArr = [NSArray arrayWithArray:result.resultsAry];
                         if ([resultArr count]==1)
                         {
                             for (BmobObject *bObject in resultArr)
                             {
                                 if (![_mineClass1.titleLabel.text isEqualToString:@"添加班级"])
                                 {
                                     [bObject setObject:[_mineObject objectForKey:@"UserName"] forKey:@"UserName"];
                                     [bObject setObject:_mineClass1.titleLabel.text forKey:@"Class1"];
                                     if (![_mineClass2.titleLabel.text isEqualToString:@"添加班级"])
                                     {
                                         [bObject setObject:_mineClass2.titleLabel.text forKey:@"Class2"];
                                         if (![_mineClass3.titleLabel.text isEqualToString:@"添加班级"])
                                         {
                                             [bObject setObject:_mineClass3.titleLabel.text forKey:@"Class3"];
                                         }
                                     }
                                     [bObject updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                                         if (error) {
                                             NSLog(@"error==--%@",error);
                                         } else if (isSuccessful){
                                             NSLog(@"更新班级数据成功！！");
                                             [self.navigationController popToRootViewControllerAnimated:YES];
                                         }
                                     }];
                                 }
                                 
                             }
                             
                         } else if ([resultArr count]==0){
                             [bObj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error)
                              {
                                  if (error)
                                  {
                                      NSLog(@"error===%@",error);
                                  } else if (isSuccessful)
                                  {
                                      NSLog(@"保存班级成功！！");
                                      [self.navigationController popToRootViewControllerAnimated:YES];
                                  }
                              }];
                         }
                     }
                 }];//对有无班级进行判断，有就更新，没有就创建
            }
        }
        else
        {
            BmobQuery *query = [[BmobQuery alloc] init];
            NSString *sql = [NSString stringWithFormat:@"select * from UserClass where UserName = '%@'",_mineName.text];
            [query queryInBackgroundWithBQL:sql block:^(BQLQueryResult *result, NSError *error)
             {
                 if (error)
                 {
                     NSLog(@"error=%@",error);
                 }
                 else if(result)
                 {
                     NSArray *resultArr = [NSArray arrayWithArray:result.resultsAry];
                     if ([resultArr count]==1)
                     {
                         for (BmobObject *bObject in resultArr)
                         {
                             if (![_mineClass1.titleLabel.text isEqualToString:@"添加班级"])
                             {
                                 [bObject setObject:[_mineObject objectForKey:@"UserName"] forKey:@"UserName"];
                                 [bObject setObject:_mineClass1.titleLabel.text forKey:@"Class1"];
                                 if (![_mineClass2.titleLabel.text isEqualToString:@"添加班级"])
                                 {
                                     [bObject setObject:_mineClass2.titleLabel.text forKey:@"Class2"];
                                     if (![_mineClass3.titleLabel.text isEqualToString:@"添加班级"])
                                     {
                                         [bObject setObject:_mineClass3.titleLabel.text forKey:@"Class3"];
                                     }
                                 }
                                 [bObject updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                                     if (error) {
                                         NSLog(@"error==--%@",error);
                                     } else if (isSuccessful){
                                         NSLog(@"更新班级数据成功！！");
                                         [self.navigationController popToRootViewControllerAnimated:YES];
                                     }
                                 }];
                             }
                             
                         }
                         
                     } else if ([resultArr count]==0){
                         [bObj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error)
                          {
                              if (error)
                              {
                                  NSLog(@"error===%@",error);
                              } else if (isSuccessful)
                              {
                                  NSLog(@"保存班级成功！！");
                                  [self.navigationController popToRootViewControllerAnimated:YES];
                              }
                          }];
                     }
                 }
             }];//对有无班级进行判断，有就更新，没有就创建
        }
    }    
}
#pragma mark ----选择性别的点击事件--
- (void)chanceSex
{
    LTPickerView* pickerView = [LTPickerView new];
    pickerView.dataSource = @[@"男",@"女"];//设置要显示的数据
    pickerView.defaultStr = @"男";//默认选择的数据
    [pickerView show];//显示
    //回调block
    pickerView.block = ^(LTPickerView* obj,NSString* str,int num){
        //obj:LTPickerView对象
        //str:选中的字符串
        //num:选中了第几行
        NSLog(@"选择了第%d行的%@",num,str);
        [_mineSex setTitle:str forState:UIControlStateNormal];
    };
}
#pragma mark ----选择班级的点击事件--
- (void)chanceClass:(UIButton *)classBtn
{
    LTPickerView* pickerView = [LTPickerView new];
    pickerView.dataSource = _ourClassData;//设置要显示的数据
    pickerView.defaultStr = @"高二5班";//默认选择的数据
    [pickerView show];//显示
    //回调block
    pickerView.block = ^(LTPickerView* obj,NSString* str,int num){
        //obj:LTPickerView对象
        //str:选中的字符串
        //num:选中了第几行
        NSLog(@"选择了第%d行的%@",num,str);
        if (classBtn.tag==1)
        {
            [_mineClass1 setTitle:str forState:UIControlStateNormal];
            
        }
        else if (classBtn.tag==2)
        {
            [_mineClass2 setTitle:str forState:UIControlStateNormal];
        }
        else
        {
            [_mineClass3 setTitle:str forState:UIControlStateNormal];
        }
        [_ourClassData removeObject:str];
    };
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ----视图将要出现在屏幕上--
- (void)viewWillAppear:(BOOL)animated
{
    _mineName.text = [_mineObject objectForKey:@"UserName"];
    [_mineSex setTitle:[_mineObject objectForKey:@"UserSex"] forState:UIControlStateNormal];
    if(![_mineObject objectForKey:@"UserSex"])
    {
        [_mineSex setTitle:@"请选择" forState:UIControlStateNormal];
    }
    _mineTel.text = [_mineObject objectForKey:@"UserTel"];
    if (![_mineClassObject objectForKey:@"Class1"])
    {
        
    }
    else
    {
        [_mineClass1 setTitle:[_mineClassObject objectForKey:@"Class1"] forState:UIControlStateNormal];
        if (![_mineClassObject objectForKey:@"Class2"])
        {
            
        }
        else
        {
            [_mineClass2 setTitle:[_mineClassObject objectForKey:@"Class2"] forState:UIControlStateNormal];
            if (![_mineClassObject objectForKey:@"Class3"])
            {
                
            }
            else
            {
                [_mineClass3 setTitle:[_mineClassObject objectForKey:@"Class3"] forState:UIControlStateNormal];
            }
        }
    }
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
