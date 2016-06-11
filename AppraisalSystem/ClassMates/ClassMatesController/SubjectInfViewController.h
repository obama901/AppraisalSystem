//
//  SubjectInfViewController.h
//  AppraisalSystem
//
//  Created by Ardee on 16/6/11.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubjectInfViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSNumber *sdtId;
@property (nonatomic,strong)NSString *sdtName;
@property (nonatomic,strong)NSString *sbjName;
@property (nonatomic,assign)int indexNumber;
@end
