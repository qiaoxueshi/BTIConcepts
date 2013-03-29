//
//  SampleCoreDataTableViewController.h
//  DemoProject
//
//  Created by Brian Slick on 3/28/13.
//  Copyright (c) 2013 BriTer Ideas LLC. All rights reserved.
//

/*
 
 NOTE
 
 This is not intended to be an example of how to set up Core Data stuff.  Normally there would probably be a singleton, and then this class would have at most a managed object context property.  What is here is just quick-n-dirty to show off how BTICoreDataTableViewController works, as well as the NSManagedObject+BTIAdditions category.
 
 */


// Libraries

// Forward Declarations and Classes
#import "BTICoreDataTableViewController.h"

// Public Constants

// Protocols


@interface SampleCoreDataTableViewController : BTICoreDataTableViewController
{
}

#pragma mark - IBOutlet Properties


#pragma mark - Other Public Properties


#pragma mark - IBActions
- (IBAction)visibleButtonPressed:(UIButton *)button;
- (IBAction)lifetimeButtonPressed:(UIButton *)button;

#pragma mark - Other Public Methods

@end
