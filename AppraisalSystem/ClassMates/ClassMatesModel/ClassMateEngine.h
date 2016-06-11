//
//  ClassMateEngine.h
//  AppraisalSystem
//
//  Created by Ardee on 16/6/1.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassMateEngine : NSObject

+ (void)getClassNumberAndNameWithComplentBlock:(void(^)(NSArray *))complentBlock;
+ (void)getClassMatesNameWithClassName:(NSString *)className withComplentBlock:(void(^)(NSArray *))complentBlock;

@end
