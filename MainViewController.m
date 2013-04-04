//
//  MainViewController.m
//  SampleNews5
//
//  Created by Aadil Shaik on 25/03/13.
//  Copyright (c) 2013 Verve Infinite Developer Aadil Shaik. All rights reserved.
//

#import "MainViewController.h"
#import "HostViewController.h"
#define FRAME_MARGIN 10
@interface MainViewController ()

@property (assign, nonatomic, getter = isRotating) BOOL rotating;
@property(nonatomic,retain)UIView *homeView;

@end

@implementation MainViewController
@synthesize movieIndex;
@synthesize rotating = _rotating;
@synthesize homeView=_homeView;
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
    
    self.view.backgroundColor=[UIColor blackColor];
    printf("index =%d",movieIndex);
    // NSArray *imageArray=[NSArray arrayWithObjects:@"q.jpg",@"r.jpg",@"s.jpg",@"t.jpg", nil];
    self.homeView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320,460)];
    self.homeView.backgroundColor=[UIColor whiteColor];
    [self.homeView.layer setShadowOpacity:0.5];
    [self.homeView.layer setShadowOffset:CGSizeMake(0, 1)];
    UIImageView *navBar=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    //navBar.opaque=YES;
    navBar.userInteractionEnabled=YES;
    
    UIImageView *icon=[[UIImageView alloc]initWithFrame:CGRectMake(5, 2,40, 40)];
    icon.image=[UIImage imageNamed:@"tv5.png"];
    [navBar addSubview:icon];
    
    [self.homeView addSubview:navBar];
    
    ButtonsClass *buttonClass=[[ButtonsClass alloc]initWithFrame:CGRectMake(0, 44, 320,460-44) loadNewsAtIndex:movieIndex];
    buttonClass.delegate=self;
    [self.homeView addSubview:buttonClass];
    [self.view addSubview:self.homeView];
}
-(void)buttonSelectedAtTag:(int)tag
{
    printf("button selected=%d",tag);
    
    HostViewController *hostViewController=[[HostViewController alloc]initWithNibName:@"HostViewController" bundle:nil];
    hostViewController.tag=tag;
    [self.navigationController pushViewController:hostViewController animated:YES];
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	[super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
	
	[self setRotating:YES];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	[super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
	
	[self setShadowPathsWithAnimationDuration:duration];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	[super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
	
	[self setRotating:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	NSLog(@"viewWillAppear");
    
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	NSLog(@"viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	NSLog(@"viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
	NSLog(@"viewDidDisappear");
}

- (void)viewWillLayoutSubviews
{
	[super viewWillLayoutSubviews];
	
	CGRect frame = self.imageView.frame;
	CGFloat maxPictureWidth = frame.size.width - 2 * FRAME_MARGIN;
	CGFloat	maxPictureHeight = frame.size.height - 2 * FRAME_MARGIN;
	CGFloat fitToWidthHeight = maxPictureWidth * (3./4);
	CGFloat fitToHeightWidth = maxPictureHeight * (4./3);
    
	BOOL fitToWidth = fitToHeightWidth > maxPictureWidth;
	//CGFloat contentGap = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone? 10 : 20;
	
	if (fitToWidth)
	{
		if (maxPictureWidth > 480)
		{
			maxPictureWidth = 480;
			fitToWidthHeight = 360;
		}
		
		//CGFloat pictureHeightWithFrame = fitToWidthHeight + 2 * FRAME_MARGIN;
		//CGFloat pictureWidthWithFrame = maxPictureWidth + 2 * FRAME_MARGIN;
		
		//self.imageView.frame = CGRectMake((frame.size.width - pictureWidthWithFrame) / 2, 0, pictureWidthWithFrame, pictureHeightWithFrame);
		//self.imageView.frame = CGRectMake((frame.size.width - pictureWidthWithFrame) / 2, pictureHeightWithFrame + contentGap, pictureWidthWithFrame, frame.size.height - (pictureHeightWithFrame + contentGap));
	}
	else
	{
		if (maxPictureHeight > 360)
		{
			maxPictureHeight = 360;
			fitToHeightWidth = 480;
		}
		
		CGFloat pictureWidthWithFrame = fitToHeightWidth + 2 * FRAME_MARGIN;
		CGFloat pictureHeightWithFrame = maxPictureHeight + 2 * FRAME_MARGIN;
		
		self.imageView.frame = CGRectMake(0, (frame.size.height - pictureHeightWithFrame) / 2, pictureWidthWithFrame, pictureHeightWithFrame);
		//self.imageView.frame = CGRectMake(pictureWidthWithFrame + contentGap, (frame.size.height - pictureHeightWithFrame) / 2, frame.size.width - (pictureWidthWithFrame + contentGap), pictureHeightWithFrame);
	}
	
	// during rotation we'll get a separate callback and animate the change in shadowPath
	if (![self isRotating])
		[self setShadowPathsWithAnimationDuration:0];
	
	NSLog(@"viewWillLayoutSubviews");
}

- (void)setShadowPathsWithAnimationDuration:(NSTimeInterval)duration
{
	UIBezierPath *newPath = [UIBezierPath bezierPathWithRect:self.imageView.bounds];
	CGPathRef oldPath = CGPathRetain([self.imageView.layer shadowPath]);
	[self.imageView.layer setShadowPath:[newPath CGPath]];
	
	if (duration > 0)
	{
		CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"shadowPath"];
		[pathAnimation setFromValue:(__bridge id)oldPath];
		[pathAnimation setToValue:(id)[self.homeView.layer shadowPath]];
		[pathAnimation setDuration:duration];
		[pathAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
		[pathAnimation setRemovedOnCompletion:YES];
		
		[self.imageView.layer addAnimation:pathAnimation forKey:@"shadowPath"];
	}
	
	CGPathRelease(oldPath);
}

- (void)viewDidLayoutSubviews
{
	[super viewDidLayoutSubviews];
	NSLog(@"viewDidLayoutSubviews");
}

- (void)willMoveToParentViewController:(UIViewController *)parent
{
	[super willMoveToParentViewController:parent];
	if (parent)
		NSLog(@"willMoveToParentViewController");
	else
		NSLog(@"willRemoveFromParentViewController");
}

- (void)didMoveToParentViewController:(UIViewController *)parent
{
	[super didMoveToParentViewController:parent];
	if (parent)
		NSLog(@"didMoveToParentViewController");
	else
		NSLog(@"didRemoveFromParentViewController");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
