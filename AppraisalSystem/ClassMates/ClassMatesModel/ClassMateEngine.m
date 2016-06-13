//
//  ClassMateEngine.m
//  AppraisalSystem
//
//  Created by Ardee on 16/6/1.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import "ClassMateEngine.h"


@implementation ClassMateEngine
#pragma mark ----查询表UserClass中用户名为X为谁--
+ (void)getClassNumberAndNameWithComplentBlock:(void (^)(NSArray *))complentBlock
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *userName = [ud objectForKey:@"userName"];
    BmobQuery *query = [[BmobQuery alloc] init];
    NSString *sql = [NSString stringWithFormat:@"select * from UserClass where UserName = '%@'",userName];
    [query queryInBackgroundWithBQL:sql block:^(BQLQueryResult *result, NSError *error)
    {
        NSMutableArray *classArr = [[NSMutableArray alloc]init];
        if (error) {
            NSLog(@"error是：%@",error);
        } else if (result)
        {
            NSArray *resultArr = [NSArray arrayWithArray:result.resultsAry];
            for (BmobObject *bObject in resultArr)
            {
                if ([bObject objectForKey:@"Class1"])//添加班级1到数组
                {
                    NSString *classStr1 = [bObject objectForKey:@"Class1"];
                    [classArr addObject:classStr1];
                }
                if ([bObject objectForKey:@"Class2"])//添加班级2到数组
                {
                    NSString *classStr2 = [bObject objectForKey:@"Class2"];
                    [classArr addObject:classStr2];
                }
                if ([bObject objectForKey:@"Class3"])//添加班级3到数组
                {
                    NSString *classStr3 = [bObject objectForKey:@"Class3"];
                    [classArr addObject:classStr3];
                }
            }
            complentBlock(classArr);
        }
    }];
    
}
#pragma mark ----查询表UserStudents中班级是X的都是谁--
+ (void)getClassMatesNameWithClassName:(NSString *)className withComplentBlock:(void (^)(NSArray *))complentBlock
{
    BmobQuery *query = [[BmobQuery alloc] init];
    NSString *sql = [NSString stringWithFormat:@"select * from UserStudents where SdtClass = '%@'",className];
    [query queryInBackgroundWithBQL:sql block:^(BQLQueryResult *result, NSError *error) {
        if (error)
        {
            NSLog(@"获取学生的错误==%@",error);
        } else if (result)
        {
            NSArray *resultArr = [NSArray arrayWithArray:result.resultsAry];
            complentBlock(resultArr);
        }
    }];
}
#pragma mark ----查询表为X的学号为X都有谁--
+ (void)toHaveStudentSubjectInformationWithSdtId:(NSNumber *)sdtId withFormName:(NSString *)formName withComplentBlock:(void (^)(BmobObject *))complentBlock
{
    BmobQuery *query = [[BmobQuery alloc]init];
    NSString *sql = [NSString stringWithFormat:@"select * from %@ where SdtId = %@",formName,sdtId];
    [query queryInBackgroundWithBQL:sql block:^(BQLQueryResult *result, NSError *error) {
        if (error)
        {
            NSLog(@"获取学科信息的错误是：%@",error);
        } else if(result)
        {
            if ([result.resultsAry count]>=1)
            {
                BmobObject *bObject = [result.resultsAry objectAtIndex:0];
                complentBlock(bObject);
            }
        }
    }];
}
#pragma mark ----更新或者添加成绩表数据--
+ (void)updataOrAddDataWithStudentName:(NSString *)sdtName withNeedObject:(BmobObject *)ndUpdateObj withFrom:(NSString *)fromName withSdtId:(NSNumber *)sdtId withG11:(NSString *)g11 withG12:(NSString *)g12 withG21:(NSString *)g21 withG22:(NSString *)g22 withG31:(NSString *)g31 withG32:(NSString *)g32 withComplentBlock:(void (^)(NSString *))complentBlock
{
    BmobQuery *query = [[BmobQuery alloc]init];
    NSString *sql = [NSString stringWithFormat:@"select * from %@ where SdtId = %@",fromName,sdtId];
    [query queryInBackgroundWithBQL:sql block:^(BQLQueryResult *result, NSError *error) {
        if (error)
        {
            NSLog(@"查询学科信息的错误是==%@",error);
        } else if(result)
        {
            if ([result.resultsAry count]<1)//表中没有此学生的信息，要创建
            {
                BmobObject *bObject = [BmobObject objectWithClassName:fromName];
                [bObject setObject:sdtId forKey:@"SdtId"];
                [bObject setObject:sdtName forKey:@"SdtName"];
                if (g11!=nil)
                {
                    [bObject setObject:g11 forKey:@"SdtG11"];
                }
                if (g12!=nil)
                {
                    [bObject setObject:g12 forKey:@"SdtG12"];
                }
                if (g21!=nil)
                {
                    [bObject setObject:g21 forKey:@"SdtG21"];
                }
                if (g22!=nil)
                {
                    [bObject setObject:g22 forKey:@"SdtG22"];
                }
                if (g31!=nil)
                {
                    [bObject setObject:g31 forKey:@"SdtG31"];
                }
                if (g32!=nil)
                {
                    [bObject setObject:g32 forKey:@"SdtG32"];
                }
                [bObject saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    NSString *ssseee = @"无知";
                    if (error)
                    {
                        NSLog(@"创建学生成绩表的错误是：%@",error);
                        ssseee = @"失败";
                    } else if (isSuccessful)
                    {
                        NSLog(@"成功创建学生成绩表");
                        ssseee = @"成功";
                    }
                    complentBlock(ssseee);
                }];
            }
            else if ([result.resultsAry count]>=1)//表中有这个学生的信息，要更新
            {
                if (g11!=nil)
                {
                    [ndUpdateObj setObject:g11 forKey:@"SdtG11"];
                }
                if (g12!=nil)
                {
                    [ndUpdateObj setObject:g12 forKey:@"SdtG12"];
                }
                if (g21!=nil)
                {
                    [ndUpdateObj setObject:g21 forKey:@"SdtG21"];
                }
                if (g22!=nil)
                {
                    [ndUpdateObj setObject:g22 forKey:@"SdtG22"];
                }
                if (g31!=nil)
                {
                    [ndUpdateObj setObject:g31 forKey:@"SdtG31"];
                }
                if (g32!=nil)
                {
                    [ndUpdateObj setObject:g32 forKey:@"SdtG32"];
                }
                [ndUpdateObj updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    NSString *ssseee = @"无知";
                    if (error)
                    {
                        NSLog(@"更新学生的错误是=%@",error);
                        ssseee = @"失败";
                    } else if (isSuccessful)
                    {
                        ssseee = @"成功";
                    }
                    complentBlock(ssseee);
                }];
            }
        }
    }];
}
+ (void)saveMarkWithStudentName:(NSString *)sdtName withNeedObject:(BmobObject *)ndUpdateObj withFrom:(NSString *)fromName withSdtId:(NSNumber *)sdtId withMark:(NSString *)sdtMark withComplentBlock:(void (^)(NSString *))complentBlock
{
    BmobQuery *query = [[BmobQuery alloc]init];
    NSString *sql = [NSString stringWithFormat:@"select * from %@ where SdtId = %@",fromName,sdtId];
    [query queryInBackgroundWithBQL:sql block:^(BQLQueryResult *result, NSError *error)
    {
        if (error)
        {
            NSLog(@"查询学科信息的错误是==%@",error);
        } else if(result)
        {
            if ([result.resultsAry count]<1)//表中没有此学生的信息，要创建
            {
                BmobObject *bObject = [BmobObject objectWithClassName:fromName];
                [bObject setObject:sdtId forKey:@"SdtId"];
                [bObject setObject:sdtName forKey:@"SdtName"];
                if (sdtMark!=nil)
                {
                    [bObject setObject:sdtMark forKey:@"SdtMark"];
                }
                [bObject saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    NSString *ssseee = @"无知";
                    if (error)
                    {
                        NSLog(@"创建学生评分的错误是=%@",error);
                        ssseee = @"失败";
                    } else if (isSuccessful)
                    {
                        ssseee = @"成功";
                    }
                    complentBlock(ssseee);
                }];
            }
            else if ([result.resultsAry count]>=1)//表中有学生信息，要更新
            {
                if (sdtMark!=nil)
                {
                    [ndUpdateObj setObject:sdtMark forKey:@"SdtMark"];
                }
                [ndUpdateObj updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    NSString *ssseee = @"无知";
                    if (error)
                    {
                        NSLog(@"更新学生评分的错误是=%@",error);
                        ssseee = @"失败";
                    } else if (isSuccessful)
                    {
                        ssseee = @"成功";
                    }
                    complentBlock(ssseee);
                }];
            }
        }
    }];
}
#pragma mark ----更新或者保存教师评语的方法--
+ (void)updataRemarkWithStudentName:(NSString *)sdtName withNeedObject:(BmobObject *)ndUpdateObj withFrom:(NSString *)fromName withSdtId:(NSNumber *)sdtId withReMark:(NSString *)sdtReMark withComplentBlock:(void (^)(NSString *))complentBlock
{
    BmobQuery *query = [[BmobQuery alloc]init];
    NSString *sql = [NSString stringWithFormat:@"select * from %@ where SdtId = %@",fromName,sdtId];
    [query queryInBackgroundWithBQL:sql block:^(BQLQueryResult *result, NSError *error)
    {
        if (error)
        {
            NSLog(@"查询学科信息的错误是：：：：%@",error);
        } else if(result)
        {
            if ([result.resultsAry count]<1)//表中没有此学生的信息，要创建
            {
                BmobObject *bObject = [BmobObject objectWithClassName:fromName];
                [bObject setObject:sdtId forKey:@"SdtId"];
                [bObject setObject:sdtName forKey:@"SdtName"];
                if (sdtReMark!=nil)
                {
                    [bObject setObject:sdtReMark forKey:@"SdtRemark"];
                }
                [bObject saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    NSString *ssseee = @"无知";
                    if (error)
                    {
                        NSLog(@"创建学生评分的错误是=%@",error);
                        ssseee = @"失败";
                    } else if (isSuccessful)
                    {
                        ssseee = @"成功";
                    }
                    complentBlock(ssseee);
                }];
            }
            else if ([result.resultsAry count]>=1)//表中有学生信息，要更新
            {
                if (sdtReMark!=nil)
                {
                    [ndUpdateObj setObject:sdtReMark forKey:@"SdtRemark"];
                }
                [ndUpdateObj updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    NSString *ssseee = @"无知";
                    if (error)
                    {
                        NSLog(@"更新学生评分的错误是=%@",error);
                        ssseee = @"失败";
                    } else if (isSuccessful)
                    {
                        ssseee = @"成功";
                    }
                    complentBlock(ssseee);
                }];
            }
        }
    }];
}
+ (void)AddStudentToClassRoomWithSdtName:(NSString *)sdtName withSdtId:(NSNumber *)sdtId withClassName:(NSString *)className withcomlpentBlock:(void (^)(NSString *))complentBlock
{
    BmobQuery *query = [[BmobQuery alloc]init];
    NSString *sql = [NSString stringWithFormat:@"select * from UserStudents where SdtId = %@",sdtId];
    [query queryInBackgroundWithBQL:sql block:^(BQLQueryResult *result, NSError *error)
    {
        if (error)
        {
            NSLog(@"查询学号的错误是：%@",error);
        } else if (result)
        {
            if ([result.resultsAry count]<1)//表中没有此学生，可以插入
            {
                BmobObject *bObject = [BmobObject objectWithClassName:@"UserStudents"];
                [bObject setObject:sdtName forKey:@"SdtName"];
                [bObject setObject:sdtId forKey:@"SdtId"];
                [bObject setObject:className forKey:@"SdtClass"];
                [bObject saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error)
                {
                    NSString *ssseee = @"无知";
                    if (error)
                    {
                        NSLog(@"更新学生评分的错误是-=-=%@",error);
                        ssseee = @"失败";
                    } else if (isSuccessful)
                    {
                        ssseee = @"成功";
                    }
                    complentBlock(ssseee);
                }];
            }
            else if ([result.resultsAry count]>=1)//表中有此学生，不能插入
            {
                complentBlock(@"失败");
            }
        }
    }];
}
@end
