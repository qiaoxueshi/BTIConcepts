//
//  BTIManagerTableViewController.h
//
//  Created by Brian Slick in Feb 2013.
//  Copyright (c) 2013 BriTer Ideas LLC. All rights reserved.
//

/*
 
 OVERVIEW
 
 This is a specific implementation of BTITableViewController that provides data storage via BTITableContentsManager(s), one for the main contents and one for the search contents.  itemInTableView:atIndexPath: has been overridden accordingly.
 
 */

// Libraries

// Forward Declarations and Classes
#import "BTITableViewController.h"
@class BTITableContentsManager;

// Public Constants

// Protocols

@interface BTIManagerTableViewController : BTITableViewController
{
}

#pragma mark - IBOutlet Properties


#pragma mark - Other Public Properties
@property (nonatomic, strong, readonly) BTITableContentsManager *mainContentsManager;
@property (nonatomic, strong, readonly) BTITableContentsManager *searchContentsManager;

#pragma mark - IBActions


#pragma mark - Other Public Methods

@end
