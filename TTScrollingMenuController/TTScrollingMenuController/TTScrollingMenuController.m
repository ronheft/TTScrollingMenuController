//
//  TTScrollingMenuController.m
//  TTScrollingMenuController
//
//  Created by Ronald Heft on 7/17/12.
//  Copyright (c) 2012 Trifecta Technologies, Inc. All rights reserved.
//

#import "TTScrollingMenuController.h"
#import "TTStatusBarOverlay.h"

static const float TAB_BAR_HEIGHT = 44.0f;

@interface TTScrollingMenuController ()

@property (strong, nonatomic) TTStatusBarOverlay *statusBarOverlay;
@property (strong, nonatomic) SwipeView *menuButtonsContainerView;
@property (strong, nonatomic) SwipeView *contentContainerView;

@end

@implementation TTScrollingMenuController

@synthesize viewControllers;
@synthesize selectedViewController;
@synthesize selectedIndex;
@synthesize menuButtonsContainerView;
@synthesize contentContainerView;
@synthesize statusBarOverlay;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.statusBarOverlay = [[TTStatusBarOverlay alloc] initWithFrame:CGRectZero];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.menuButtonsContainerView = [[SwipeView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, TAB_BAR_HEIGHT)];
    self.menuButtonsContainerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.menuButtonsContainerView.backgroundColor = [UIColor purpleColor];
    self.menuButtonsContainerView.alignment = SwipeViewAlignmentCenter;
    self.menuButtonsContainerView.pagingEnabled = YES;
    self.menuButtonsContainerView.wrapEnabled = NO;
    self.menuButtonsContainerView.itemsPerPage = 1;
    self.menuButtonsContainerView.truncateFinalPage = YES;
    self.menuButtonsContainerView.delegate = self;
    self.menuButtonsContainerView.dataSource = self;
    [self.view addSubview:self.menuButtonsContainerView];
    
    self.contentContainerView = [[SwipeView alloc] initWithFrame:CGRectMake(0, TAB_BAR_HEIGHT, self.view.bounds.size.width, self.view.bounds.size.height-TAB_BAR_HEIGHT)];
    self.contentContainerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.contentContainerView.alignment = SwipeViewAlignmentCenter;
    self.contentContainerView.pagingEnabled = YES;
    self.contentContainerView.wrapEnabled = NO;
    self.contentContainerView.itemsPerPage = 1;
    self.contentContainerView.truncateFinalPage = YES;
    self.contentContainerView.delegate = self;
    self.contentContainerView.dataSource = self;
    self.contentContainerView.scrollEnabled = NO;
    [self.view addSubview:self.contentContainerView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Public Methods

- (UIViewController *)selectedViewController
{
    return [self.viewControllers objectAtIndex:self.contentContainerView.currentItemIndex];
}

#pragma mark - swipeView Data Source

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return [self.viewControllers count];
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (view == nil)
    {
        if ( [swipeView isEqual:self.menuButtonsContainerView] ) {
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
    if ( [swipeView isEqual:self.contentContainerView] ) {
        return self.view.bounds.size.width;
    } else {
        return 175.0;
    }
}

#pragma mark - swipeView Delegate

- (void)swipeView:(SwipeView *)swipeView didSelectItemAtIndex:(NSInteger)index
{
    if ( [swipeView isEqual:self.menuButtonsContainerView] && index < [self.viewControllers count] ) {
        [self.statusBarOverlay fadeIn];
        [swipeView scrollToItemAtIndex:index animated:YES];
        [self.statusBarOverlay fadeOut];
    }
}

- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView
{
/*    if ( [swipeView isEqual:menuButtonsContainerView] ) {
        [contentContainerView scrollToItemAtIndex:swipeView.currentItemIndex animated:YES];
    }*/
}

- (void)swipeViewDidScroll:(SwipeView *)swipeView
{
    if ( [swipeView isEqual:self.menuButtonsContainerView] ) {
        CGFloat scrollFactor = 320.0/175.0;
        self.contentContainerView.scrollView.contentOffset = CGPointMake(swipeView.scrollView.contentOffset.x*scrollFactor, self.contentContainerView.scrollView.contentOffset.y);
    }
}

- (void)swipeViewWillBeginDragging:(SwipeView *)swipeView
{
    if ( [swipeView isEqual:self.menuButtonsContainerView] ) {
        [self.statusBarOverlay fadeIn];
    }
}

- (void)swipeViewDidEndDragging:(SwipeView *)swipeView willDecelerate:(BOOL)decelerate
{
    if ( [swipeView isEqual:self.menuButtonsContainerView] ) {
        [self.statusBarOverlay fadeOut];
    }
}

@end
