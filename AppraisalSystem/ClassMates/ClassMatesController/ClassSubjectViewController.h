//
//  ClassSubjectViewController.h
//  AppraisalSystem
//
//  Created by Ardee on 16/6/11.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BmobSDK/Bmob.h>

@interface ClassSubjectViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain)NSNumber *SdtId;
@property (nonatomic,retain)NSString *SdtName;
@end
