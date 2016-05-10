//
//  MineInforViewController.m
//  AppraisalSystem
//
//  Created by Ardee on 16/5/10.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import "MineInforViewController.h"

@interface MineInforViewController ()

@end

@implementation MineInforViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    _mineTel.text = [_mineObject objectForKey:@"UserTel"];
    
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
