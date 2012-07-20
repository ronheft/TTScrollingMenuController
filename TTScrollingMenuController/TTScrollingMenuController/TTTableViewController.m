//
//  TTTableViewController.m
//  TTScrollingMenuController
//
//  Created by Ronald Heft on 7/19/12.
//  Copyright (c) 2012 Trifecta Technologies, Inc. All rights reserved.
//

#import "TTTableViewController.h"

@interface TTTableViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TTTableViewController

@synthesize tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 22.0f, self.view.bounds.size.width, self.view.bounds.size.height-44.0f) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
