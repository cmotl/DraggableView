//
//  ViewController.m
//  DraggableView
//
//  Created by Christopher Motl on 1/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController {
    CGFloat startX;
    CGFloat startY;
    CGPoint originalLocation;
}

@synthesize dragView;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    
    if( [touch view] == dragView)
    {
        CGPoint location = [touch locationInView:self.view];
        originalLocation = dragView.center;
        startX = location.x - dragView.center.x;        
        startY = dragView.center.y;
    }
}


- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if( [touch view] == dragView)
    {
        CGPoint location = [touch locationInView:self.view];
        
        if(location.x - startX <= dragView.frame.size.width/2)
        {
            location.x = dragView.frame.size.width/2;
        }
        else if(location.x - startX >= self.view.frame.size.width - dragView.frame.size.width/2)
        {
            location.x = self.view.frame.size.width - dragView.frame.size.width/2;
        }
        else
        {
            location.x =location.x - startX;
        }
        
        location.y = startY;
        dragView.center = location;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if( [touch view] == dragView)
    {
        CGFloat max_length_from_center = self.view.frame.size.width/2 - dragView.frame.size.width/2;
        CGFloat actual_length_from_center = fabsf(self.view.frame.size.width/2 - dragView.center.x);
        
        CGFloat percent_off_center = actual_length_from_center/max_length_from_center;
        CGFloat animation_duration = 0.3 * percent_off_center;
        
        
        [UIView animateWithDuration:animation_duration
             animations:^{ 
                 dragView.center = originalLocation;
             } 
             completion:^(BOOL finished){
                 ;
             }];
    }
}

@end
