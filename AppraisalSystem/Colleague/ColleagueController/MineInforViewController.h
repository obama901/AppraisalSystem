//
//  MineInforViewController.h
//  AppraisalSystem
//
//  Created by Ardee on 16/5/10.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BmobSDK/Bmob.h>

@interface MineInforViewController : UIViewController
{
    __weak IBOutlet UITextField *_mineName;
    __weak IBOutlet UIButton *_mineSex;
    __weak IBOutlet UITextField *_mineTel;
    __weak IBOutlet UIButton *_mineClass1;
    __weak IBOutlet UIButton *_mineClass2;
    __weak IBOutlet UIButton *_mineClass3;
    
}
@property (nonatomic,strong)BmobObject *mineObject;
@property (nonatomic,strong)BmobObject *mineClassObject;
@end
