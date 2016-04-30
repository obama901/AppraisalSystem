//
//  ColleagueViewController.m
//  AppraisalSystem
//
//  Created by Ardee on 16/4/14.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import "ColleagueViewController.h"
#import "LLSlideMenu.h"
#import <BmobSDK/Bmob.h>
#import "TeachInforViewController.h"
#import "XWPresentOneTransition.h"

@interface ColleagueViewController ()<XWPresentedOneControllerDelegate>
{
    UIBarButtonItem *menuItem;
    UITableView *_teachTable;
}
@property (nonatomic, strong) LLSlideMenu *slideMenu;
@property (nonatomic ,strong) NSMutableArray *teachObjectArr;
// 全屏侧滑手势
@property (nonatomic, strong) UIPanGestureRecognizer *leftSwipe;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percent;
@end

@implementation ColleagueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTeacherTable];
    [self creatMenuBtn];
    [self creatSlipeMenu];
    [self getTeacherList];
}
#pragma mark ----创建教师同事列表--
- (void)creatTeacherTable
{
    _teachTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 431)];
    _teachTable.delegate = self;
    _teachTable.dataSource = self;
    [self.view addSubview:_teachTable];
}
#pragma mark ----返回tableView各区的行数--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_teachObjectArr count];
}
#pragma mark ----返回tableView有多少个区--
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark ----返回每个单元格的内容--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BmobObject *teachObjc = [_teachObjectArr objectAtIndex:indexPath.row];
    UITableViewCell *teachCell = [tableView dequeueReusableCellWithIdentifier:@"teachCell"];
    if (teachCell == nil)
    {
        teachCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"teachCell"];
    }
    teachCell.textLabel.text = [NSString stringWithFormat:@"%@        老师",[teachObjc objectForKey:@"UserName"]];
    teachCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    teachCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return teachCell;
}
#pragma mark ----单元格点击方法--
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BmobObject *teachObjc = [_teachObjectArr objectAtIndex:indexPath.row];
    TeachInforViewController *teachInfoVC = [[TeachInforViewController alloc]init];
//    teachInfoVC.delegate = self;
    teachInfoVC.teachObject = teachObjc;
    [self presentViewController:teachInfoVC animated:YES completion:nil];
}
#pragma mark ----获取老师列表--
- (void)getTeacherList
{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *userName = [ud objectForKey:@"userName"];
    NSLog(@"userName==%@",userName);
    BmobQuery *query = [[BmobQuery alloc] init];
    NSString *sql = [NSString stringWithFormat:@"select * from UserTable where UserName = '%@'",userName];
    [query queryInBackgroundWithBQL:sql block:^(BQLQueryResult *result, NSError *error)
    {
        if (error)
        {
            NSLog(@"error=%@",error);
        }
        else if(result)
        {
            NSArray *resultArr = [NSArray arrayWithArray:result.resultsAry];
            for (BmobObject *bObject in resultArr)
            {
                NSString *subjectStr = [bObject objectForKey:@"UserSubject"];
                NSLog(@"我的学科是：%@",subjectStr);
                NSString *str = [NSString stringWithFormat:@"select * from UserTable where UserSubject = '%@'",subjectStr];
                [query queryInBackgroundWithBQL:str block:^(BQLQueryResult *result, NSError *error)
                {
                    if (error)
                    {
                        NSLog(@"查询同事的错误是：%@",error);
                    } else if (result)
                    {
                        NSArray *array = [NSArray arrayWithArray:result.resultsAry];
                        _teachObjectArr = [[NSMutableArray alloc]initWithArray:array];
                        [_teachTable reloadData];
                        for (BmobObject *teachObjc in array)
                        {
                            NSLog(@"得到的同事是：%@",[teachObjc objectForKey:@"UserName"]);
                        }
                    }
                }];
            }
        }
    }];
}
#pragma mark ----创建菜单按钮--
- (void)creatMenuBtn
{
    menuItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menuIcon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(openLLSlideMenuAction:)];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = menuItem;
}
#pragma mark ----创建侧滑菜单--
- (void)creatSlipeMenu
{
    // 初始化
    _slideMenu = [[LLSlideMenu alloc] init];
    [self.view addSubview:_slideMenu];
    // 设置菜单宽度
    _slideMenu.ll_menuWidth = 200.f;
    // 设置菜单背景色
//    _slideMenu.ll_menuBackgroundColor = [UIColor redColor];
    _slideMenu.ll_menuBackgroundImage = [UIImage imageNamed:@"menuBg.png"];
    // 设置弹力和速度，  默认的是20,15,60
    _slideMenu.ll_springDamping = 20;       // 阻力
    _slideMenu.ll_springVelocity = 15;      // 速度
    _slideMenu.ll_springFramesNum = 60;     // 关键帧数量
    
    
    
    //===================
    // Menu添加子View
    //===================
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(50, 60, 80, 80)];
    [img setImage:[UIImage imageNamed:@"doge.jpg"]];
    [_slideMenu addSubview:img];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 140, 150, 340)];
    label.text = @"这是第一行菜单\n\n这是第二行菜单\n\n这是第三行菜单\n\n这是第四行菜单\n\n这是第五行菜单\n\n这是第六行菜单";
    [label setTextColor:[UIColor whiteColor]];
    [label setNumberOfLines:0];
    [_slideMenu addSubview:label];
    
    
    //===================
    // 添加全屏侧滑手势
    //===================
    self.leftSwipe = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftHandle:)];
    self.leftSwipe.maximumNumberOfTouches = 1;
    [self.view addGestureRecognizer:_leftSwipe];
}
#pragma mark ----全屏侧滑手势监听--
//===================
// 全屏侧滑手势监听
//===================
- (void)swipeLeftHandle:(UIScreenEdgePanGestureRecognizer *)recognizer {
    if ([recognizer translationInView:self.view].x < 0) {
        [_slideMenu ll_closeSlideMenu];
        return;
    }
    // 如果菜单已打开则禁止滑动
    if (_slideMenu.ll_isOpen) {
        return;
    }
    // 计算手指滑的物理距离（滑了多远，与起始位置无关）
    CGFloat progress = [recognizer translationInView:self.view].x / (self.view.bounds.size.width * 1.0);
    // 把这个百分比限制在 0~1 之间
    progress = MIN(1.0, MAX(0.0, progress));
    
    // 当手势刚刚开始，我们创建一个 UIPercentDrivenInteractiveTransition 对象
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.percent = [[UIPercentDrivenInteractiveTransition alloc] init];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        // 当手慢慢划入时，我们把总体手势划入的进度告诉 UIPercentDrivenInteractiveTransition 对象。
        [self.percent updateInteractiveTransition:progress];
        _slideMenu.ll_distance = [recognizer translationInView:self.view].x;
        
    } else if (recognizer.state == UIGestureRecognizerStateCancelled || recognizer.state == UIGestureRecognizerStateEnded) {
        // 当手势结束，我们根据用户的手势进度来判断过渡是应该完成还是取消并相应的调用 finishInteractiveTransition 或者 cancelInteractiveTransition 方法.
        if (progress > 0.4) {
            [self.percent finishInteractiveTransition];
            [_slideMenu ll_openSlideMenu];
        }else{
            [self.percent cancelInteractiveTransition];
            [_slideMenu ll_closeSlideMenu];
        }
        self.percent = nil;
    }
}
#pragma mark ----菜单按钮监听事件--
- (void)openLLSlideMenuAction: (UIButton *)btn
{
    //===================
    // 打开菜单
    //===================
    if (_slideMenu.ll_isOpen) {
        [_slideMenu ll_closeSlideMenu];
    } else {
        [_slideMenu ll_openSlideMenu];
    }

}
#pragma mark ----视图即将出现调用的方法--
- (void)viewWillAppear:(BOOL)animated
{
    _slideMenu.ll_isOpen = NO;
}
#pragma mark ----转场动画要实现的两个代理方法--
- (void)presentedOneControllerPressedDissmiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPresent{
    return nil;
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
