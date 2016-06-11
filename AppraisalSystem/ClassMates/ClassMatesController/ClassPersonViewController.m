//
//  ClassPersonViewController.m
//  AppraisalSystem
//
//  Created by Ardee on 16/6/8.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import "ClassPersonViewController.h"
#import "ClassMateEngine.h"
#import "ClassSubjectViewController.h"

@interface ClassPersonViewController ()

{
    
    UICollectionView *_collectionView;
}
@property (nonatomic,strong)NSMutableArray *StudentsObjArr;
@end

@implementation ClassPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"班级座位";
    [self toGetStudentsNameOrId];
    [self creatCollectionView];
}
#pragma mark ----获取学生们的姓名与学号--
- (void)toGetStudentsNameOrId
{
    [ClassMateEngine getClassMatesNameWithClassName:self.className withComplentBlock:^(NSArray *resultArr)
    {
        _StudentsObjArr = [[NSMutableArray alloc]initWithArray:resultArr];
        [_collectionView reloadData];
    }];
}
#pragma mark ----创建班级座位--
- (void)creatCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}
#pragma mark ----单元格点击方法--
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BmobObject *bObject = [_StudentsObjArr objectAtIndex:indexPath.row];
    ClassSubjectViewController *ClassSbjVC = [[ClassSubjectViewController alloc]init];
    ClassSbjVC.SdtId = [bObject objectForKey:@"SdtId"];
    ClassSbjVC.SdtName = [bObject objectForKey:@"SdtName"];
    [self.navigationController pushViewController:ClassSbjVC animated:YES];
}
#pragma mark ----返回每个区有多少单元格--
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_StudentsObjArr count];
}
#pragma mark ----返回单元格内容--
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"desk.png"]];
    return cell;
}
#pragma mark ----返回单元格尺寸--
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake(40, 40);
    return size;
}
#pragma mark ----设置内置偏移量--
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets insets = UIEdgeInsetsMake(80/7, 80/7, 80/7, 80/7);
    return insets;
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
