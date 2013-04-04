//
//  NewsViewController.m
//  SampleNews5
//
//  Created by Aadil Shaik on 19/03/13.
//  Copyright (c) 2013 Verve Infinite Developer Aadil Shaik. All rights reserved.
//

#import "NewsViewController.h"
@interface NewsViewController ()



@end

@implementation NewsViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
        
    
    self.navigationItem.title=@"News";
    printf(".......... index=%d",_movieIndex);
     
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 310, 450-44)];
    imageView.image=[UIImage imageNamed:[imageArray objectAtIndex:_movieIndex]];
    [self.view addSubview:imageView];
    
    
}


@end
