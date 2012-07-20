//
//  TTStatusBarOverlay.m
//  TTScrollingMenuController
//
//  Created by Ronald Heft on 7/20/12.
//  Copyright (c) 2012 Trifecta Technologies, Inc. All rights reserved.
//

#import "TTStatusBarOverlay.h"

@interface TTStatusBarOverlay ()
    
@property (strong, nonatomic) UIPageControl *pageControl;

@end

@implementation TTStatusBarOverlay

@synthesize pageControl;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.windowLevel = UIWindowLevelStatusBar+1.0f;
        self.frame = [[UIApplication sharedApplication] statusBarFrame];
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:self.frame];
        self.pageControl.backgroundColor = [UIColor blackColor];
        self.pageControl.alpha = 0.0f;
        self.pageControl.numberOfPages = 1;
        self.pageControl.hidesForSinglePage = NO;
        self.pageControl.enabled = NO;
        [self addSubview:self.pageControl];
        
        self.hidden = NO;
    }
    return self;
}

- (void)fadeIn
{
    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.pageControl.alpha = 1.0f;
    } completion:nil];
}

- (void)fadeOut
{
    [UIView animateWithDuration:0.5f delay:1.5f options:UIViewAnimationOptionTransitionNone animations:^{
        self.pageControl.alpha = 0.0f;
    } completion:nil];
}

- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    self.pageControl.numberOfPages = numberOfPages;
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    self.pageControl.currentPage = currentPage;
}

@end
