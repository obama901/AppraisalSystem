//
//  ClassSubjectViewController.m
//  AppraisalSystem
//
//  Created by Ardee on 16/6/11.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import "ClassSubjectViewController.h"
#import "SubjectInfViewController.h"

@interface ClassSubjectViewController ()
{
    UITableView *_SbjtableView;
    NSMutableArray *_SubjectArr;
}
@end

@implementation ClassSubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"%@的学科",self.SdtName];
    [self creatSubjectArray];
    [self creatTableView];
}
#pragma mark ----创建学科的数组--
- (void)creatSubjectArray
{
    _SubjectArr = [[NSMutableArray alloc]initWithObjects:@"语文",@"数学",@"外语",@"物理",@"化学",@"生物",@"政治",@"历史",@"地理", nil];
}
#pragma mark ----创建本页的TableView--
- (void)creatTableView
{
    _SbjtableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    _SbjtableView.delegate = self;
    _SbjtableView.dataSource = self;
    [_SbjtableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_SbjtableView];
}
#pragma mark ----单元格点击方法--
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SubjectInfViewController *subjectInfVC = [[SubjectInfViewController alloc]init];
    subjectInfVC.sdtId = self.SdtId;
    subjectInfVC.sdtName = self.SdtName;
    subjectInfVC.sbjName = [_SubjectArr objectAtIndex:indexPath.row];
    subjectInfVC.indexNumber = indexPath.row;
    [self.navigationController pushViewController:subjectInfVC animated:YES];
}
#pragma mark ----返回九个学科的单元格个数--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}
#pragma mark ----返回单元格内容--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text = [_SubjectArr objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor grayColor];
    return cell;
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
