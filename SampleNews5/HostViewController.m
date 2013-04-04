//
//  HostViewController.m
//  SampleNews5
//
//  Created by Aadil Shaik on 21/03/13.
//  Copyright (c) 2013 Verve Infinite Developer Aadil Shaik. All rights reserved.
//

#import "HostViewController.h"
#import "NewsViewController.h"
@interface HostViewController ()

@property (assign, nonatomic) int previousIndex;
@property (assign, nonatomic) int tentativeIndex;
@property (assign, nonatomic) BOOL observerAdded;

@end
#define FRAME_MARGIN	60
#define MOVIE_MIN		1
#define MOVIE_MAX		10
@implementation HostViewController
@synthesize frame = _frame;
@synthesize flipViewController = _flipViewController;
@synthesize corkboard = _corkboard;
@synthesize previousIndex = _previousIndex;
@synthesize tentativeIndex = _tentativeIndex;
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
    self.previousIndex = MOVIE_MIN;
	
	// Configure the page view controller and add it as a child view controller.
	self.flipViewController = [[MPFlipViewController alloc] initWithOrientation:[self flipViewController:nil orientationForInterfaceOrientation:[UIApplication sharedApplication].statusBarOrientation]];
	self.flipViewController.delegate = self;
	self.flipViewController.dataSource = self;
	
	// Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
	//BOOL hasFrame = self.frame != nil;
	CGRect pageViewRect = self.view.bounds;
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
	{
		//pageViewRect = CGRectInset(pageViewRect,0 + (hasFrame? FRAME_MARGIN : 0), 0 + (hasFrame? FRAME_MARGIN : 0));
		self.flipViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	}
	else
	{
		pageViewRect = CGRectMake((self.view.bounds.size.width - 600)/2, (self.view.bounds.size.height - 600)/2, 600, 600);
		self.flipViewController.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
	}
	self.flipViewController.view.frame = pageViewRect;
	[self addChildViewController:self.flipViewController];
	[self.view addSubview:self.flipViewController.view];
	[self.flipViewController didMoveToParentViewController:self];
	
	[self.flipViewController setViewController:[self contentViewWithIndex:self.previousIndex] direction:MPFlipViewControllerDirectionForward animated:NO completion:nil];
	
	// Add the page view controller's gesture recognizers to the book view controller's view so that the gestures are started more easily.
	self.view.gestureRecognizers = self.flipViewController.gestureRecognizers;
	
    //	[self.corkboard setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Pattern - Corkboard"]]];
    //	if (self.frame)
    //	{
    //		[self.frame setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Pattern - Apple Wood"]]];
    //	}
	
	[self addObserver];

}
- (void)viewDidUnload
{
	[self setCorkboard:nil];
	[self setFrame:nil];
	[self removeObserver];
    [super viewDidUnload];
	
    // Release any retained subviews of the main view.
}

- (void)addObserver
{
	if (![self observerAdded])
	{
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(flipViewControllerDidFinishAnimatingNotification:) name:MPFlipViewControllerDidFinishAnimatingNotification object:nil];
		[self setObserverAdded:YES];
	}
}

- (void)removeObserver
{
	if ([self observerAdded])
	{
		[[NSNotificationCenter defaultCenter] removeObserver:self name:MPFlipViewControllerDidFinishAnimatingNotification object:nil];
		[self setObserverAdded:NO];
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if ([self flipViewController])
		return [[self flipViewController] shouldAutorotateToInterfaceOrientation:interfaceOrientation];
	else
		return YES;
}
- (UIViewController *)contentViewWithIndex:(int)index
{
	//UIStoryboard *storyboard = [UIStoryboard storyboardWithName:[self storyboardName] bundle:nil];
	//ContentViewController *page = [storyboard instantiateViewControllerWithIdentifier:CONTENT_IDENTIFIER];
   
        NewsViewController* page=[[NewsViewController alloc]initWithNibName:@"NewsViewController" bundle:nil];
        page.movieIndex =index;
        page.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        return page;
    
	
}
#pragma mark - MPFlipViewControllerDelegate protocol

- (void)flipViewController:(MPFlipViewController *)flipViewController didFinishAnimating:(BOOL)finished previousViewController:(UIViewController *)previousViewController transitionCompleted:(BOOL)completed
{
	if (completed)
	{
		self.previousIndex = self.tentativeIndex;
	}
}

- (MPFlipViewControllerOrientation)flipViewController:(MPFlipViewController *)flipViewController orientationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
		return UIInterfaceOrientationIsPortrait(orientation)? MPFlipViewControllerOrientationVertical : MPFlipViewControllerOrientationHorizontal;
	else
		return MPFlipViewControllerOrientationHorizontal;
}

#pragma mark - MPFlipViewControllerDataSource protocol

- (UIViewController *)flipViewController:(MPFlipViewController *)flipViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
	int index = self.previousIndex;
	index--;
	if (index < MOVIE_MIN)
		return nil; // reached beginning, don't wrap
	self.tentativeIndex = index;
	return [self contentViewWithIndex:index];
}

- (UIViewController *)flipViewController:(MPFlipViewController *)flipViewController viewControllerAfterViewController:(UIViewController *)viewController
{
	int index = self.previousIndex;
	index++;
	if (index > MOVIE_MAX)
		return nil; // reached end, don't wrap
	self.tentativeIndex = index;
	return [self contentViewWithIndex:index];
}

#pragma mark - Notifications

- (void)flipViewControllerDidFinishAnimatingNotification:(NSNotification *)notification
{
	NSLog(@"Notification received: %@", notification);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
