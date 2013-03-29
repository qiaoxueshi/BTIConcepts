//
//  SampleCoreDataTableViewController.m
//  DemoProject
//
//  Created by Brian Slick on 3/28/13.
//  Copyright (c) 2013 BriTer Ideas LLC. All rights reserved.
//

#import "SampleCoreDataTableViewController.h"

// Models and other global
#import "BTIGenericItem.h"

// Sub-controllers

// Views

// Private Constants

@interface SampleCoreDataTableViewController ()

// Private Properties
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

// Notification Handlers
- (void)doSomethingForVisibleNotification:(NSNotification *)notification;
- (void)doSomethingForLifetimeNotification:(NSNotification *)notification;

// UI Response Methods

// Misc Methods

@end

@implementation SampleCoreDataTableViewController

#pragma mark - Synthesized Properties


#pragma mark - Dealloc and Memory Methods


#pragma mark - Initialization and UI Creation Methods

- (id)initWithNibName:(NSString *)nibNameOrNil
			   bundle:(NSBundle *)nibBundleOrNil
{
	NSLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
    self = [super initWithNibName:nibNameOrNil
						   bundle:nibBundleOrNil];
    if (self)
	{
		[self setTitle:@"Core Data Table"];
		[[self tabBarItem] setImage:[UIImage imageNamed:@"second"]];
    }
	
	NSLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return self;
}

#pragma mark - Custom Getters and Setters

- (NSManagedObjectModel *)managedObjectModel
{
	NSLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	if (_managedObjectModel == nil)
	{
		NSString *path = [[NSBundle mainBundle] pathForResource:@"Sample" ofType:@"momd"];
		NSURL *url = [NSURL fileURLWithPath:path];
		
		_managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
	}
	
	NSLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
	NSLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	if (_persistentStoreCoordinator == nil)
	{
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDirectory = [paths firstObjectBTI];
		
		NSURL *storeURL = [NSURL fileURLWithPath:[documentsDirectory stringByAppendingPathComponent:@"Sample.sqlite"]];
		
		_persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
		
		NSDictionary *options = @{ NSMigratePersistentStoresAutomaticallyOption : @YES, NSInferMappingModelAutomaticallyOption : @YES };
		
		[_persistentStoreCoordinator addPersistentStoreWithTypeBTI:NSSQLiteStoreType
													  configuration:nil
																URL:storeURL
															options:options];
	}
	
	NSLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return _persistentStoreCoordinator;
}

#pragma mark - UIViewController Overrides

- (void)viewWillAppear:(BOOL)animated
{
	NSLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	if ([self managedObjectContext] == nil)
	{
		NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
		[context setPersistentStoreCoordinator:[self persistentStoreCoordinator]];
		[self setManagedObjectContext:context];
	}

	[super viewWillAppear:animated];
	
	
	[self populateContents];
	
	NSLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - BTIViewController Overrides

- (void)populateContents
{
	NSLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	NSManagedObjectContext *context = [self managedObjectContext];
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	
	[fetchRequest setEntity:[BTIGenericItem entityDescriptionInContextBTI:context]];
	
	NSInteger numberOfItems = [context countForFetchRequestBTI:fetchRequest];
	
	if (numberOfItems == 0)
	{
		BTIGenericItem *item = [BTIGenericItem newManagedObjectInContextBTI:context];
		[item setPrimary:@"Batman"];
		[item setSecondary:@"Robin"];
		
		item = [BTIGenericItem newManagedObjectInContextBTI:context];
		[item setPrimary:@"Ace"];
		[item setSecondary:@"Gary"];
		
		item = [BTIGenericItem newManagedObjectInContextBTI:context];
		[item setPrimary:@"Picard"];
		[item setSecondary:@"Riker"];

		item = [BTIGenericItem newManagedObjectInContextBTI:context];
		[item setPrimary:@"Holmes"];
		[item setSecondary:@"Watson"];

		[context saveBTI];
	}
	
	[[self tableView] reloadData];
	
	NSLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)populateNotificationHelpers
{
	NSLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	BTINotificationHelper *helper = nil;
	
	// Lifetime Notifications
	
	helper = [BTINotificationHelper notificationHelperWithObserver:self
														  selector:@selector(doSomethingForLifetimeNotification:)
															  name:kLifetimeNotification
															object:nil
														  lifeSpan:BTINotificationRegistrationLifetime];
	[self addNotificationHelper:helper];
	
	// Visible Notifications
	
	helper = [BTINotificationHelper notificationHelperWithObserver:self
														  selector:@selector(doSomethingForVisibleNotification:)
															  name:kVisibleNotification
															object:nil
														  lifeSpan:BTINotificationRegistrationVisible];
	[self addNotificationHelper:helper];
	
	NSLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - BTITableViewController Overrides


#pragma mark - BTICoreDataTableViewController Overrides

- (void)loadMainFetchedResultsController
{
	NSLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

	NSManagedObjectContext *context = [self managedObjectContext];
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	
	[fetchRequest setEntity:[BTIGenericItem entityDescriptionInContextBTI:context]];
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"primary" ascending:YES];
	
	[fetchRequest setSortDescriptors:@[ sortDescriptor ]];
	
	NSFetchedResultsController *controller = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
																				 managedObjectContext:context
																				   sectionNameKeyPath:nil
																							cacheName:nil];
	[controller setDelegate:self];
	
	[self setMainFetchedResultsController:controller];
	
	[controller performFetchBTI];

	NSLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - Notification Handlers

- (void)doSomethingForVisibleNotification:(NSNotification *)notification
{
	NSLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	NSArray *viewControllers = [[self tabBarController] viewControllers];
	NSInteger index = [viewControllers indexOfObject:self];
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Tab at index %d\n", index]
													message:@"Received *visible* notification"
												   delegate:nil
										  cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
	[alert show];
	
	NSLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)doSomethingForLifetimeNotification:(NSNotification *)notification
{
	NSLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	NSArray *viewControllers = [[self tabBarController] viewControllers];
	NSInteger index = [viewControllers indexOfObject:self];
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Tab at index %d\n", index]
													message:@"Received *lifetime* notification"
												   delegate:nil
										  cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
	[alert show];
	
	NSLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - UI Response Methods

- (IBAction)visibleButtonPressed:(UIButton *)button
{
	NSLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	// It would be on the main thread anyway, but I need a reason to use this...
	[[NSNotificationCenter defaultCenter] postNotificationNameOnMainThreadBTI:kVisibleNotification];
	
	NSLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (IBAction)lifetimeButtonPressed:(UIButton *)button
{
	NSLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	// It would be on the main thread anyway, but I need a reason to use this...
	[[NSNotificationCenter defaultCenter] postNotificationNameOnMainThreadBTI:kLifetimeNotification];
	
	NSLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - Misc Methods


#pragma mark - UITableViewDataSource Methods

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	// Build Cell
	
	static NSString *blankCellIdentifier = @"blankCellIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:blankCellIdentifier];
	if (cell == nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:blankCellIdentifier];
	}
	
	// Acquire Data
	
	BTIGenericItem *item = [[self mainFetchedResultsController] objectAtIndexPath:indexPath];
	
	// Populate Cell
	
	[[cell textLabel] setText:[item primary]];
	[[cell detailTextLabel] setText:[item secondary]];
	
	NSLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return cell;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
		
	NSLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

@end
