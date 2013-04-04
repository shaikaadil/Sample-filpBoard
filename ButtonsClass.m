//
//  ButtonsClass.m
//  SampleNews5
//
//  Created by Aadil Shaik on 19/03/13.
//  Copyright (c) 2013 Verve Infinite Developer Aadil Shaik. All rights reserved.
//

#import "ButtonsClass.h"

@implementation ButtonsClass

-(id)initWithFrame:(CGRect)frame loadNewsAtIndex:(int)index

{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor whiteColor]];
        int value=0;
        buttonArray=[[NSMutableArray alloc]init];
       NSArray *imageArray=[NSArray arrayWithObjects:@"cover.jpg",@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"13.jpg",@"14.jpg",@"6.jpg",@"7.jpg",@"8.jpg",@"9.jpg",@"10.jpg",@"G.jpg",@"s.jpg",@"12.jpg",nil];
        NSArray *storyArray=[NSArray arrayWithObjects:@"Breaking News",@"Stories",@"International",@"Sports",@"Finance",@"Culture",@"Technology",@"News",@"Design",@"Sports",@"Politice",@"Sports",@"Travel",@"Agriculture",@"IT",@"Photos", nil];
        if (index==1)
        {
        UIButton *b1=[UIButton buttonWithType:UIButtonTypeCustom];
        b1.frame=CGRectMake(5, 5, 310,295);
        [b1 setImage:[UIImage imageNamed:@"cover.jpg"] forState:UIControlStateNormal];
        [b1 setBackgroundColor:[UIColor clearColor]];
        [b1.layer setShadowOpacity:0.5];
        [b1.layer setShadowOffset:CGSizeMake(0, 1)];
            [b1 setHighlighted:NO];
            [b1 setShowsTouchWhenHighlighted:NO];
            
        [b1 addTarget:self action:@selector(newsSelectedAtTag:) forControlEvents:UIControlEventTouchUpInside];
        b1.tag=0;
        [buttonArray addObject:b1];
        [self addSubview:b1];
            UIImageView *icon=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 50, 50)];
            icon.image=[UIImage imageNamed:@"tv5.png"];
            [b1 addSubview:icon];
        UIButton *b2=[UIButton buttonWithType:UIButtonTypeCustom];
        b2.frame=CGRectMake(5,305,152.5,110);
        [b2 setImage:[UIImage imageNamed:@"1.jpg"] forState:UIControlStateNormal];
        [b2 setBackgroundColor:[UIColor clearColor]];
        [b2.layer setShadowOpacity:0.5];
        [b2.layer setShadowOffset:CGSizeMake(0, 1)];
        [b2 addTarget:self action:@selector(newsSelectedAtTag:) forControlEvents:UIControlEventTouchUpInside];
        b2.tag=1;
        [buttonArray addObject:b2];
        [self addSubview:b2];
        
        UIButton *b3=[UIButton buttonWithType:UIButtonTypeCustom];
        b3.frame=CGRectMake(162.5,305,152.5,110);
        [b3 setImage:[UIImage imageNamed:@"2.jpg"] forState:UIControlStateNormal];
        [b3 setBackgroundColor:[UIColor clearColor]];
        [b3.layer setShadowOpacity:0.5];
        [b3.layer setShadowOffset:CGSizeMake(0, 1)];
        [b3 addTarget:self action:@selector(newsSelectedAtTag:) forControlEvents:UIControlEventTouchUpInside];
        b3.tag=2;
        [buttonArray addObject:b3];
        [self addSubview:b3];
            
        }else if (index>1)
        {
            index=index-2;
            value=6*index;
            for (int i=0; i<6; i++) {
                
                UIButton *b=[UIButton buttonWithType:UIButtonTypeCustom];
                if(i==0)
                    b.frame=CGRectMake(5,5,150,110);
                if(i==1)
                    b.frame=CGRectMake(165,5,150,110);
                if(i==2)
                    b.frame=CGRectMake(5,125,150,110);
                if(i==3)
                    b.frame=CGRectMake(165,125,150,110);
                if(i==4)
                    b.frame=CGRectMake(5,245,150,110);
                if(i==5)
                    b.frame=CGRectMake(165,245,150,110);
                [b  setImage:[UIImage imageNamed:[imageArray objectAtIndex:value+i+3]] forState:UIControlStateNormal];
                [b setBackgroundColor:[UIColor clearColor]];
                [b.layer setShadowOpacity:0.5];
                [b.layer setShadowOffset:CGSizeMake(0, 1)];
                [b addTarget:self action:@selector(newsSelectedAtTag:) forControlEvents:UIControlEventTouchUpInside];
                b.tag=value+i+3;
                //[buttonArray addObject:b4];
                [self addSubview:b];
            }
        

        }
       
        
    }
    return self;
}
-(IBAction)newsSelectedAtTag:(id)sender
{
    UIButton *b=(UIButton *)sender;
    [self.delegate buttonSelectedAtTag:b.tag];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
