//
//  MainViewController.h
//  SampleNews5
//
//  Created by Aadil Shaik on 25/03/13.
//  Copyright (c) 2013 Verve Infinite Developer Aadil Shaik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ButtonsClass.h"
@interface MainViewController : UIViewController<buttonSelectedDelegate>

@property(assign,nonatomic)NSInteger movieIndex;
@property(nonatomic,retain)UIImageView *imageView;
@end
