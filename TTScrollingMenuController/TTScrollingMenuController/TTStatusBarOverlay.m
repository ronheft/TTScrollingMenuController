//
//  TTStatusBarOverlay.m
//  TTScrollingMenuController
//
//  Created by Ronald Heft on 7/20/12.
//  Copyright (c) 2012 Trifecta Technologies, Inc. All rights reserved.
//

#import "TTStatusBarOverlay.h"

@interface TTStatusBarOverlay ()
    
@property (strong, nonatomic) UIView *view;
@property (assign, nonatomic) BOOL animating;

@end

@implementation TTStatusBarOverlay

@synthesize view;
@synthesize animating;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.windowLevel = UIWindowLevelStatusBar+1.0f;
        self.frame = [[UIApplication sharedApplication] statusBarFrame];
        
        self.view = [[UIView alloc] initWithFrame:self.frame];
        self.view.backgroundColor = [UIColor yellowColor];
        self.view.alpha = 0.0f;
        [self addSubview:view];
        
        self.hidden = NO;
    }
    return self;
}

- (void)fadeIn
{
    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.view.alpha = 1.0f;
    } completion:^(BOOL finished) {
        self.animating = NO;
    }];
}

- (void)fadeOut
{
    [UIView animateWithDuration:0.5f delay:1.0f options:UIViewAnimationOptionTransitionNone animations:^{
        self.view.alpha = 0.0f;
    } completion:^(BOOL finished) {
        self.animating = NO;
    }];
}

@end
