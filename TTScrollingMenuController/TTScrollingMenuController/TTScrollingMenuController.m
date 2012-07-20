//
//  TTScrollingMenuController.m
//  TTScrollingMenuController
//
//  Created by Ronald Heft on 7/17/12.
//  Copyright (c) 2012 Trifecta Technologies, Inc. All rights reserved.
//

#import "TTScrollingMenuController.h"

static const float TAB_BAR_HEIGHT = 44.0f;

@interface TTScrollingMenuController ()

@end

@implementation TTScrollingMenuController {
    SwipeView *menuButtonsContainerView;
	SwipeView *contentContainerView;
}

@synthesize viewControllers;
@synthesize selectedViewController;
@synthesize selectedIndex;

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
	
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    menuButtonsContainerView = [[SwipeView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, TAB_BAR_HEIGHT)];
    menuButtonsContainerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    menuButtonsContainerView.backgroundColor = [UIColor purpleColor];
    menuButtonsContainerView.alignment = SwipeViewAlignmentCenter;
    menuButtonsContainerView.pagingEnabled = YES;
    menuButtonsContainerView.wrapEnabled = NO;
    menuButtonsContainerView.itemsPerPage = 1;
    menuButtonsContainerView.truncateFinalPage = YES;
    menuButtonsContainerView.delegate = self;
    menuButtonsContainerView.dataSource = self;
    [self.view addSubview:menuButtonsContainerView];
    
    contentContainerView = [[SwipeView alloc] initWithFrame:CGRectMake(0, TAB_BAR_HEIGHT, self.view.bounds.size.width, self.view.bounds.size.height-TAB_BAR_HEIGHT)];
    contentContainerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    contentContainerView.alignment = SwipeViewAlignmentCenter;
    contentContainerView.pagingEnabled = YES;
    contentContainerView.wrapEnabled = NO;
    contentContainerView.itemsPerPage = 1;
    contentContainerView.truncateFinalPage = YES;
    contentContainerView.delegate = self;
    contentContainerView.dataSource = self;
    contentContainerView.scrollEnabled = NO;
    [self.view addSubview:contentContainerView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return [self.viewControllers count];
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (view == nil)
    {
        if ( [swipeView isEqual:menuButtonsContainerView] ) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 175, TAB_BAR_HEIGHT)];
            label.text = [[self.viewControllers objectAtIndex:index] title];
            label.textAlignment = UITextAlignmentCenter;
            label.font = [UIFont boldSystemFontOfSize:18];
            label.textColor = [UIColor whiteColor];
            label.shadowOffset = CGSizeMake(0, 1);
            label.shadowColor = [UIColor blackColor];
            label.backgroundColor = [UIColor clearColor];
            
            view = label;
        } else {
            view = [[self.viewControllers objectAtIndex:index] view];
        }
    }
    
    return view;
}

- (CGFloat)swipeViewItemWidth:(SwipeView *)swipeView
{
    if ( [swipeView isEqual:contentContainerView] ) {
        return self.view.bounds.size.width;
    } else {
        return 175.0;
    }
}

- (void)swipeView:(SwipeView *)swipeView didSelectItemAtIndex:(NSInteger)index
{
    if ( [swipeView isEqual:menuButtonsContainerView] && index < [self.viewControllers count] ) {
        [swipeView scrollToItemAtIndex:index animated:YES];
    }
}

- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView
{
    if ( [swipeView isEqual:menuButtonsContainerView] ) {
        [contentContainerView scrollToItemAtIndex:swipeView.currentItemIndex animated:YES];
    }
}

- (UIViewController *)selectedViewController
{
    return [self.viewControllers objectAtIndex:contentContainerView.currentItemIndex];
}

@end
