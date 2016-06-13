//
//  HistroyViewController.h
//  AppraisalSystem
//
//  Created by Ardee on 16/6/12.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BmobSDK/Bmob.h>

@interface HistroyViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSString *sdtName;
@property (nonatomic,strong)NSString *sbjName;
@property (nonatomic,strong)NSNumber *sdtId;
@property (nonatomic,strong)BmobObject *bObj;
@property (nonatomic,assign)int indexNumber;
@end
