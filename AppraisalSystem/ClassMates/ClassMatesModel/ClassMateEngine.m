//
//  ClassMateEngine.m
//  AppraisalSystem
//
//  Created by Ardee on 16/6/1.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import "ClassMateEngine.h"
#import <BmobSDK/Bmob.h>

@implementation ClassMateEngine

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
@end
