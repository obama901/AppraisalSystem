//
//  AddSdtViewController.h
//  AppraisalSystem
//
//  Created by Ardee on 16/6/14.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddSdtViewController : UIViewController
{
    IBOutlet UITextField *_sdtNameField;
    
    IBOutlet UITextField *_sdtIdField;
}
@property (nonatomic,strong)NSString *className;
@end
