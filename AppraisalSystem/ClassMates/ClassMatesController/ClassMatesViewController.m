//
//  ClassMatesViewController.m
//  AppraisalSystem
//
//  Created by Ardee on 16/4/14.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import "ClassMatesViewController.h"
#import "WBPopMenuModel.h"
#import "WBPopMenuSingleton.h"

@interface ClassMatesViewController ()
{
    UIBarButtonItem *addBtn;
}
@end

@implementation ClassMatesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    [self creatAddBtn];
}
#pragma mark ----创建添加学生菜单按钮--
- (void)creatAddBtn
{
    addBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"addIcon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(PopMenuClik:)];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = addBtn;
}
#pragma mark ----添加学生菜单点击方法--
- (void)PopMenuClik:(UIButton *)btn
{
    NSMutableArray *obj = [NSMutableArray array];
    
    for (NSInteger i = 0; i < [self titles].count; i++) {
        
        WBPopMenuModel * info = [WBPopMenuModel new];
        info.image = [self images][i];
        info.title = [self titles][i];
        [obj addObject:info];
    }
    
    [[WBPopMenuSingleton shareManager]showPopMenuSelecteWithFrame:150
                                                             item:obj
                                                           action:^(NSInteger index) {
                                                               NSLog(@"index:%ld",(long)index);
                                                               
                                                           }];
}
- (NSArray *) titles {
    return @[@"添加学生",
             @"添加一行",
             @"添加一列"
             ];
}

- (NSArray *) images {
    return @[@"addOne.png",
             @"addHang",
             @"addLie"
             ];
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
