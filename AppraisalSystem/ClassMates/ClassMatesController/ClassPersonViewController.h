//
//  ClassPersonViewController.h
//  AppraisalSystem
//
//  Created by Ardee on 16/6/8.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassPersonViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)NSString *className;
@end
