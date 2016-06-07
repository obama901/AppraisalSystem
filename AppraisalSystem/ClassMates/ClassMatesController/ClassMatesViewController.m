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
#import "ClassMateEngine.h"
#import "ClassTableViewCell.h"

@interface ClassMatesViewController ()
{
    UIBarButtonItem *addBtn;
    UITableView *_classTable;
    NSArray *_classArr;
}
@end

@implementation ClassMatesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self toGetClassArrary];
    [self creatTableView];
}
#pragma mark ----创建tableView for Class--
- (void)creatTableView
{
    _classTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStylePlain];
    _classTable.rowHeight = 85;
    _classTable.dataSource = self;
    _classTable.delegate = self;
    [_classTable registerNib:[UINib nibWithNibName:@"ClassTableViewCell" bundle:nil] forCellReuseIdentifier:@"classCell"];
    [self.view addSubview:_classTable];
}
#pragma mark ----tableView的协议方法，返回每个区有多少行--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_classArr count]>=1)
    {
        return [_classArr count];
    } else {
        return 1;
    }
    return 0;
}
#pragma mark ----返回tableView单元格的内容--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassTableViewCell *classCell = [tableView dequeueReusableCellWithIdentifier:@"classCell" forIndexPath:indexPath];
    classCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    classCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([_classArr count]>=1)
    {
        classCell.classNameTitle.text = [_classArr objectAtIndex:indexPath.row];
        classCell.classDescribe.text = @"等待填写";
    } else {
        classCell.classNameTitle.text = @"暂无班级";
        classCell.classDescribe.text = @"请您到个人中心去完善自己的班级信息！";
    }
    return classCell;
}
#pragma mark ----通过请求数据获得所教班级的名称--
- (void)toGetClassArrary
{
    [ClassMateEngine getClassNumberAndNameWithComplentBlock:^(NSArray *classNameArr)
    {
        _classArr = [NSArray arrayWithArray:classNameArr];
        [_classTable reloadData];
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
