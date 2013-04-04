//
//  ButtonsClass.h
//  SampleNews5
//
//  Created by Aadil Shaik on 19/03/13.
//  Copyright (c) 2013 Verve Infinite Developer Aadil Shaik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@protocol buttonSelectedDelegate;

@interface ButtonsClass : UIView
{
    NSMutableArray *buttonArray;
}
@property(nonatomic,retain)id<buttonSelectedDelegate>delegate;

-(id)initWithFrame:(CGRect)frame loadNewsAtIndex:(int)index;
@end
@protocol buttonSelectedDelegate<NSObject>
-(void)buttonSelectedAtTag:(int)tag;

@end
