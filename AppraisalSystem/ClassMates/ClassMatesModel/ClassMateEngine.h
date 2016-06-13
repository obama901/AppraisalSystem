//
//  ClassMateEngine.h
//  AppraisalSystem
//
//  Created by Ardee on 16/6/1.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BmobSDK/Bmob.h>

@interface ClassMateEngine : NSObject

+ (void)getClassNumberAndNameWithComplentBlock:(void(^)(NSArray *))complentBlock;
+ (void)getClassMatesNameWithClassName:(NSString *)className withComplentBlock:(void(^)(NSArray *))complentBlock;
+ (void)toHaveStudentSubjectInformationWithSdtId:(NSNumber *)sdtId withFormName:(NSString *)formName withComplentBlock:(void(^)(BmobObject *))complentBlock;
+ (void)updataOrAddDataWithStudentName:(NSString *)sdtName withNeedObject:(BmobObject *)ndUpdateObj withFrom:(NSString *)fromName withSdtId:(NSNumber *)sdtId withG11:(NSString *)g11 withG12:(NSString *)g12 withG21:(NSString *)g21 withG22:(NSString *)g22 withG31:(NSString *)g31 withG32:(NSString *)g32 withComplentBlock:(void(^)(NSString *))complentBlock;
+ (void)saveMarkWithStudentName:(NSString *)sdtName withNeedObject:(BmobObject *)ndUpdateObj withFrom:(NSString *)fromName withSdtId:(NSNumber *)sdtId withMark:(NSString *)sdtMark withComplentBlock:(void(^)(NSString *))complentBlock;
+ (void)updataRemarkWithStudentName:(NSString *)sdtName withNeedObject:(BmobObject *)ndUpdateObj withFrom:(NSString *)fromName withSdtId:(NSNumber *)sdtId withReMark:(NSString *)sdtReMark withComplentBlock:(void(^)(NSString *))complentBlock;
+ (void)AddStudentToClassRoomWithSdtName:(NSString *)sdtName withSdtId:(NSNumber *)sdtId withClassName:(NSString *)className withcomlpentBlock:(void(^)(NSString *))complentBlock;
@end
