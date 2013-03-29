//
//  BTITableViewController.h
//
//  Created by Brian Slick in Sept 2012
//  Copyright (c) 2012 BriTer Ideas LLC. All rights reserved.
//

/*
 
 OVERVIEW
 
 This is a specific implementation of BTITableViewController that provides a basic array data store, one for the main contents and one for the search contents.  itemInTableView:atIndexPath: has been overridden accordingly.
 
 */

// Libraries

// Forward Declarations and Classes
#import "BTITableViewController.h"

// Public Constants

// Protocols

@interface BTIArrayTableViewController : BTITableViewController
{
}

#pragma mark - IBOutlet Properties


#pragma mark - Other Public Properties
@property (nonatomic, strong, readonly) NSMutableArray *mainContents;
@property (nonatomic, strong, readonly) NSMutableArray *searchContents;

#pragma mark - IBActions


#pragma mark - Other Public Methods

@end
