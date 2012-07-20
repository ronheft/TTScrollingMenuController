//
//  TTScrollingMenuController.h
//  TTScrollingMenuController
//
//  Created by Ronald Heft on 7/17/12.
//  Copyright (c) 2012 Trifecta Technologies, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeView.h"

@interface TTScrollingMenuController : UIViewController <SwipeViewDelegate, SwipeViewDataSource>

@property (nonatomic, copy) NSArray *viewControllers;
@property (nonatomic, readonly) UIViewController *selectedViewController;
@property (nonatomic, assign) NSUInteger selectedIndex;

@end
