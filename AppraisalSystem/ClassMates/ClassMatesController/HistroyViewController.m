//
//  HistroyViewController.m
//  AppraisalSystem
//
//  Created by Ardee on 16/6/12.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import "HistroyViewController.h"
#import "SubjectInfTableViewCell.h"
#import "LTAlertView.h"
#import "ClassMateEngine.h"

@interface HistroyViewController ()
{
    UITableView *_historyTableView;
    NSString *_g1;
    NSString *_g2;
    NSString *_g3;
    NSString *_g4;
    NSString *_g5;
    NSString *_g6;
    UIBarButtonItem *_updateBtn;
    NSMutableArray *_sbjFromArr;
}
@end

@implementation HistroyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fixMarkGxx];
    [self creatSaveButton];
    [self creatTableView];
}
#pragma mark ----将各学期成绩汇总--
- (void)fixMarkGxx
{
    _g1 = [_bObj objectForKey:@"SdtG11"];
    _g2 = [_bObj objectForKey:@"SdtG12"];
    _g3 = [_bObj objectForKey:@"SdtG21"];
    _g4 = [_bObj objectForKey:@"SdtG22"];
    _g5 = [_bObj objectForKey:@"SdtG31"];
    _g6 = [_bObj objectForKey:@"SdtG32"];
    [_historyTableView reloadData];
}
#pragma mark ----创建保存按钮--
- (void)creatSaveButton
{
    _updateBtn = [[UIBarButtonItem alloc]initWithTitle:@"更新数据" style:UIBarButtonItemStylePlain target:self action:@selector(updateBtnClick)];
    self.navigationItem.rightBarButtonItem = _updateBtn;
    _sbjFromArr = [[NSMutableArray alloc]initWithObjects:@"UserChinese",@"UserMath",@"UserEnglish",@"UserPhysics",@"UserChemistry",@"UserBiology",@"UserPolitics",@"UserHistory",@"UserGeography", nil];
}
#pragma mark ----保存按钮点击事件--
- (void)updateBtnClick
{
    [ClassMateEngine updataOrAddDataWithStudentName:self.sdtName withNeedObject:self.bObj withFrom:[_sbjFromArr objectAtIndex:self.indexNumber] withSdtId:self.sdtId withG11:_g1 withG12:_g2 withG21:_g3 withG22:_g4 withG31:_g5 withG32:_g6 withComplentBlock:^(NSString *ssseee) {
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
#pragma mark ----创建tableView--
- (void)creatTableView
{
    _historyTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    _historyTableView.delegate = self;
    _historyTableView.dataSource = self;
    _historyTableView.rowHeight = 60;
    [_historyTableView registerNib:[UINib nibWithNibName:@"SubjectInfTableViewCell" bundle:nil] forCellReuseIdentifier:@"subjectCell"];
    [self.view addSubview:_historyTableView];
}
#pragma mark ----单元格点击方法--
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row!=0)
    {
        [LTAlertView showConfigBlock:^(LTAlertView *alertView) {
            alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        } Title:@"请输入或修改本期成绩" message:@"" ButtonTitles:@[@"确定",@"取消"] OnTapBlock:^(LTAlertView* alert,NSInteger num) {
            NSString* str = [alert textFieldAtIndex:0].text;
            NSLog(@"输入的文字是%@,点击了第%d个按钮",str,num);
            if (num==0)
            {
                switch (indexPath.row)
                {
                    case 1:
                        _g1 = str;
                        break;
                    case 2:
                        _g2 = str;
                        break;
                    case 3:
                        _g3 = str;
                        break;
                    case 4:
                        _g4 = str;
                        break;
                    case 5:
                        _g5 = str;
                        break;
                    case 6:
                        _g6 = str;
                        break;
                    default:
                        break;
                }
                [_historyTableView reloadData];
            }
            
        }];
    }
}
#pragma mark ----返回区中的单元格--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}
#pragma mark ----返回单元格内容--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SubjectInfTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"subjectCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row)
    {
        case 0:
            cell.titleText.text = [NSString stringWithFormat:@"%@历次分数",self.sbjName];
            cell.descrpionText.text = [NSString stringWithFormat:@"%@同学",self.sdtName];
            break;
        case 1:
            cell.titleText.text = @"高一期中成绩";
            cell.descrpionText.text = [NSString stringWithFormat:@"%@分",_g1];
            break;
        case 2:
            cell.titleText.text = @"高一期末成绩";
            cell.descrpionText.text = [NSString stringWithFormat:@"%@分",_g2];
            break;
        case 3:
            cell.titleText.text = @"高二期中成绩";
            cell.descrpionText.text = [NSString stringWithFormat:@"%@分",_g3];
            break;
        case 4:
            cell.titleText.text = @"高二期末成绩";
            cell.descrpionText.text = [NSString stringWithFormat:@"%@分",_g4];
            break;
        case 5:
            cell.titleText.text = @"高三期中成绩";
            cell.descrpionText.text = [NSString stringWithFormat:@"%@分",_g5];
            break;
        case 6:
            cell.titleText.text = @"高三期末成绩";
            cell.descrpionText.text = [NSString stringWithFormat:@"%@分",_g6];
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
