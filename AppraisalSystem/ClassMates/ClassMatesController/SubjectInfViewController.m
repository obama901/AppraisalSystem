//
//  SubjectInfViewController.m
//  AppraisalSystem
//
//  Created by Ardee on 16/6/11.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import "SubjectInfViewController.h"
#import "SubjectInfTableViewCell.h"
#import "HistroyViewController.h"
#import "ClassMateEngine.h"
#import "TeacherRemarkViewController.h"
#import "GiFHUD.h"
#import "LTAlertView.h"


@interface SubjectInfViewController ()

{
    UITableView *_SbjInfTableView;
    NSMutableArray *_sbjFromArr;
    BmobObject *_sdtSbjObject;
    UIBarButtonItem *_updateBtn;
    NSString *_sdtMark;
}
@end

@implementation SubjectInfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"%@详情",self.sbjName];
    _updateBtn = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(updateBtnClick)];
    self.navigationItem.rightBarButtonItem = _updateBtn;
    [self creatSubjectFromArrayOrGetInformation];
    
    [self creatTableView];
}
#pragma mark ----创建保存按钮--
- (void)creatSaveButton
{    
    _sdtMark = [_sdtSbjObject objectForKey:@"SdtMark"];
    [_SbjInfTableView reloadData];
}
#pragma mark ----保存按钮点击事件--
- (void)updateBtnClick
{
    [ClassMateEngine saveMarkWithStudentName:self.sdtName withNeedObject:_sdtSbjObject withFrom:[_sbjFromArr objectAtIndex:self.indexNumber] withSdtId:self.sdtId withMark:_sdtMark withComplentBlock:^(NSString *ssseee) {
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
#pragma mark ----创建学科数据表的数组和获取学生学科信息--
- (void)creatSubjectFromArrayOrGetInformation
{
    _sbjFromArr = [[NSMutableArray alloc]initWithObjects:@"UserChinese",@"UserMath",@"UserEnglish",@"UserPhysics",@"UserChemistry",@"UserBiology",@"UserPolitics",@"UserHistory",@"UserGeography", nil];
    [ClassMateEngine toHaveStudentSubjectInformationWithSdtId:self.sdtId withFormName:[_sbjFromArr objectAtIndex:self.indexNumber] withComplentBlock:^(BmobObject *sbjObject)
    {
        _sdtSbjObject = sbjObject;
        [self creatSaveButton];
    }];
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
#pragma mark ----单元格点击事件--
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 2:
        {
            HistroyViewController *hisVC = [[HistroyViewController alloc]init];
            hisVC.sbjName = self.sbjName;
            hisVC.sdtName = self.sdtName;
            hisVC.sdtId = self.sdtId;
            hisVC.bObj = _sdtSbjObject;
            hisVC.indexNumber = self.indexNumber;
            [self.navigationController pushViewController:hisVC animated:YES];
        }
            break;
        case 3:
        {
            [LTAlertView showConfigBlock:^(LTAlertView *alertView) {
                alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
            } Title:@"请给这位同学评价分数" message:@"分数在0~10之间" ButtonTitles:@[@"确定",@"取消"] OnTapBlock:^(LTAlertView* alert,NSInteger num) {
                NSString* str = [alert textFieldAtIndex:0].text;
                NSLog(@"输入的文字是%@,点击了第%d个按钮",str,num);
                if (num==0)
                {
                    _sdtMark = str;
                    [_SbjInfTableView reloadData];
                }
                
            }];
        }
            break;
        case 4:
        {
            [GiFHUD show];//正在加载。。
            TeacherRemarkViewController *teachRemarkVC = [[TeacherRemarkViewController alloc]init];
            teachRemarkVC.sdttName = self.sdtName;
            teachRemarkVC.sbjName = self.sbjName;
            teachRemarkVC.sdtId = self.sdtId;
            teachRemarkVC.bObject = _sdtSbjObject;
            teachRemarkVC.indexNumber = self.indexNumber;
            [GiFHUD setGifWithImageName:@"pika2.gif"];            
            [self.navigationController pushViewController:teachRemarkVC animated:YES];
        }
            break;
        default:
            break;
    }

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
            cell.descrpionText.text = [NSString stringWithFormat:@"%@分",[self theLastestSouce]];
            break;
        case 2:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.titleText.text = @"历次分数";
            break;
        case 3:
            cell.titleText.text = @"学习评价";
            cell.descrpionText.text = [NSString stringWithFormat:@"%@分",_sdtMark];
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
#pragma mark ----筛选出上一次的分数--
- (NSString *)theLastestSouce
{
    NSString *ggg = 00;
    NSString *g11 = [_sdtSbjObject objectForKey:@"SdtG11"];
    NSString *g12 = [_sdtSbjObject objectForKey:@"SdtG12"];
    NSString *g21 = [_sdtSbjObject objectForKey:@"SdtG21"];
    NSString *g22 = [_sdtSbjObject objectForKey:@"SdtG22"];
    NSString *g31 = [_sdtSbjObject objectForKey:@"SdtG31"];
    NSString *g32 = [_sdtSbjObject objectForKey:@"SdtG32"];
    if (g32!=nil)
    {
        ggg = g32;
    } else if (g31!=nil)
    {
        ggg = g31;
    } else if (g22!=nil)
    {
        ggg = g22;
    } else if (g21!=nil)
    {
        ggg = g21;
    } else if (g12!=nil)
    {
        ggg = g12;
    } else if (g11!=nil)
    {
        ggg = g11;
    } else
    {
        ggg = 00;
    }
    return ggg;
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
