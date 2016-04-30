//
//  TabViewController.m
//  AppraisalSystem
//
//  Created by Ardee on 16/4/14.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import "TabViewController.h"
#import "ColleagueViewController.h"
#import "ClassMatesViewController.h"


@interface TabViewController ()

@end

@implementation TabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTabBar];
}
#pragma mark ----创建tab选项卡--
- (void)creatTabBar
{
    //创建同事选项卡
    ColleagueViewController *colleagueVC = [[ColleagueViewController alloc]init];
    colleagueVC.title = @"同事";
    UINavigationController *colleagueNA = [[UINavigationController alloc]initWithRootViewController:colleagueVC];
    UITabBarItem *colleagueItem = [[UITabBarItem alloc]initWithTitle:@"同事" image:[[UIImage imageNamed:@"colleagueIcon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"colleagueIcon2.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    colleagueNA.tabBarItem = colleagueItem;
    //创建班级学生选项卡
    ClassMatesViewController *classMatesVC = [[ClassMatesViewController alloc]init];
    classMatesVC.title = @"学生";
    UINavigationController *classMatesNA = [[UINavigationController alloc]initWithRootViewController:classMatesVC];
    UITabBarItem *classMatesItem = [[UITabBarItem alloc]initWithTitle:@"学生" image:[[UIImage imageNamed:@"classIcon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"classIcon2.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    classMatesNA.tabBarItem = classMatesItem;
    
    self.viewControllers = @[colleagueNA,classMatesNA];
//    self.tabBar.tintColor = [UIColor colorWithRed:206/255.0 green:59/255.0 blue:77/255.0 alpha:1];
    self.tabBar.tintColor = [UIColor blackColor];
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
