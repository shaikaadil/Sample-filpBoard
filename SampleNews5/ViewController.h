//
//  ViewController.h
//  SampleNews5
//
//  Created by Aadil Shaik on 18/03/13.
//  Copyright (c) 2013 Verve Infinite Developer Aadil Shaik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "MPFlipViewController.h"

@interface ViewController : UIViewController<MPFlipViewControllerDelegate,MPFlipViewControllerDataSource>
{
    
}
@property (strong, nonatomic) MPFlipViewController *flipViewController;
@property (weak, nonatomic) IBOutlet UIView *frame;
@property (weak, nonatomic) IBOutlet UIView *corkboard;

@end
