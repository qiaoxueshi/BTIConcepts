//
//  BTIViewController.h
//
//  Created by Brian Slick in Sept 2012
//  Copyright (c) 2012 BriTer Ideas LLC. All rights reserved.
//

/*
 
 OVERVIEW
 
 This is a view controller class intended to demonstrate a variety of concepts, including:
 
 - Just in case there are features that all view controllers in the project should have, it can be helpful to have an interim VC rather than always inheriting from UIViewController directly.  Even if this VC did nothing by itself, its presence can be handy later if it becomes necessary.
 
 - init is overriden to call the UIViewController initializer.  This allows parent VC's to simply alloc/init, and not have to know or care about details like a) is it a plain view controller or a table view controller, b) does it even use a xib, and probably several other decisions that a parent VC has no business making.  View controllers should be self-sufficient, and providing a single initializer goes a long way towards acheiving that.  The scheme chosen assumes that ViewController.h and ViewController.m will always be accompanied by ViewController.xib.  If you like naming your VC xibs as View.xib, seriously, stop that.
 
 - A generic method - populateContents - is defined to provide a consistent place for updating the view contents.

 - iOS 6 handling of view unloading in response to a memory warning.
 
 - The use of BTINotificationHelpers.  A generic method - populateNotificationHelpers - is defined for creating the helpers in one place.  This method should be overridden in subclasses, with a call to super happening first.  After that, simply create any helpers, and add them using the provided method.  Ex:
 
 BTINotificationHelper *helper = [BTINotificationHelper notificationHelperWithObserver:self selector:@selector(dontCare) name:IREALLYDONTCARE object:nil lifeSpan:BTINotificationRegistrationVisible];
 [self addNotificationHelper:helper];
 
 This class has been set up to automatically register 'lifetime' notifications in init, and handles 'visible' notifications in viewWill(Dis)Appear.
 
 - dealloc unregisters from all notifications

 */


// Libraries
#import <UIKit/UIKit.h>

// Forward Declarations and Classes
#import "BTINotificationHelper.h"

// Public Constants

// Protocols

@interface BTIViewController : UIViewController
{
}

#pragma mark - IBOutlet Properties


#pragma mark - Other Public Properties


#pragma mark - IBActions


#pragma mark - Other Public Methods

/*
 Designated method for refreshing the UI.  Default implementation does nothing.  Subclasses should override and call super.
 */
- (void)populateContents;

/*
 Designated method for defining notification helpers.  Subclasses should override and call super FIRST. Not last, not in the middle, FIRST.
 */
- (void)populateNotificationHelpers;

#pragma mark BTINotificationHelper Support

/*
 Adds a notification helper to the pool that is managed by the VC.  Subclasses should not override this method.
 */
- (void)addNotificationHelper:(BTINotificationHelper *)helper;

/*
 Registers all notifications with the specified lifespan.  Note that this class is already handling 'lifetime' and 'visible' notifications, so this method should probably only be used with custom lifespans.  Subclasses should not override this method.
 */
- (void)registerNotificationsWithLifeSpan:(BTINotificationRegistrationLifeSpan)lifeSpan;

/*
 Unregisters all notifications with the specified lifespan.  Note that this class is already handling 'lifetime' and 'visible' notifications, so this method should probably only be used with custom lifespans.  Subclasses should not override this method.
 */
- (void)unregisterNotificationsWithLifeSpan:(BTINotificationRegistrationLifeSpan)lifeSpan;

@end
