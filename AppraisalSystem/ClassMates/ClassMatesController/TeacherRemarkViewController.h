//
//  TeacherRemarkViewController.h
//  AppraisalSystem
//
//  Created by Ardee on 16/6/13.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BmobSDK/Bmob.h>

@interface TeacherRemarkViewController : UIViewController

@property (strong,nonatomic) NSString *sbjName;
@property (strong,nonatomic) NSString *sdttName;
@property (strong, nonatomic) IBOutlet UILabel *subjectTitle;
@property (strong, nonatomic) IBOutlet UILabel *SdtName;
@property (strong, nonatomic) IBOutlet UITextView *RemarkText;
@property (strong, nonatomic) IBOutlet UIButton *upDateBtn;
@property (nonatomic,strong) NSNumber *sdtId;
@property (nonatomic,strong)BmobObject *bObject;
@property (nonatomic,assign)int indexNumber;

@end
