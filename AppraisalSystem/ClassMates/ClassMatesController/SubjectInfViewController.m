//
//  SubjectInfViewController.m
//  AppraisalSystem
//
//  Created by Ardee on 16/6/11.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import "SubjectInfViewController.h"
#import "SubjectInfTableViewCell.h"

@interface SubjectInfViewController ()

{
    UITableView *_SbjInfTableView;
}
@end

@implementation SubjectInfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"%@详情",self.sbjName];
    [self creatTableView];
}
#pragma mark ----创建列表--
- (void)creatTableView
{
    _SbjInfTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    _SbjInfTableView.delegate = self;
    _SbjInfTableView.dataSource = self;
    _SbjInfTableView.rowHeight = 70;
    [_SbjInfTableView registerNib:[UINib nibWithNibName:@"SubjectInfTableViewCell" bundle:nil] forCellReuseIdentifier:@"subjectCell"];
    [self.view addSubview:_SbjInfTableView];
}
#pragma mark ----返回各区有多少单元格--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
#pragma mark ----返回单元格内容--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SubjectInfTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"subjectCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row)
    {
        case 0:
            cell.titleText.text = self.sbjName;
            cell.descrpionText.text = [NSString stringWithFormat:@"%@同学",self.sdtName];
            break;
        case 1:
            cell.titleText.text = @"上次考分";
            break;
        case 2:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.titleText.text = @"历次分数";
            break;
        case 3:
            cell.titleText.text = @"学习评价";
            break;
        case 4:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.titleText.text = @"教师评语";
            break;
        default:
            break;
    }
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
