//
//  BTIErrorCategories.m
//
//  Created by Brian Slick in Sept 2012.
//  Copyright (c) 2012 BriTer Ideas LLC. All rights reserved.
//

#import "BTIErrorCategories.h"

#import "BTIImport.h"

#pragma mark - NSFetchedResultsController Categories

@implementation NSFetchedResultsController (BTIErrorAdditions)

- (BOOL)performFetchBTI
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

	NSError *error = nil;
	BOOL isFetchSuccessful = [self performFetch:&error];
	if (!isFetchSuccessful)
	{
		NSLog(@"ERROR: Perform Fetch: %@", [error localizedDescription]);
	}

	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return isFetchSuccessful;
}

@end

#pragma mark - NSFileManager Categories

@implementation NSFileManager (BTIErrorAdditions)

- (NSArray *)contentsOfDirectoryAtPathBTI:(NSString *)path
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

	NSError *error = nil;
	NSArray *contents = [self contentsOfDirectoryAtPath:path error:&error];
	if (contents == nil)
	{
		NSLog(@"ERROR: Contents of directory: %@", [error localizedDescription]);
	}
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return contents;
}

- (NSArray *)contentsOfDirectoryAtURLBTI:(NSURL *)url
			  includingPropertiesForKeys:(NSArray *)keys
								 options:(NSDirectoryEnumerationOptions)mask
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	NSError *error = nil;
	NSArray *contents = [self contentsOfDirectoryAtURL:url
							includingPropertiesForKeys:keys
											   options:mask
												 error:&error];
	if (contents == nil)
	{
		NSLog(@"ERROR: Contents of directory: %@", [error localizedDescription]);
	}
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return contents;
}

- (BOOL)createDirectoryAtPathBTI:(NSString *)path
	 withIntermediateDirectories:(BOOL)createIntermediates
					  attributes:(NSDictionary *)attributes
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	NSError *error = nil;
	BOOL isCreateSuccessful = [self createDirectoryAtPath:path
							  withIntermediateDirectories:YES
											   attributes:nil
													error:&error];
	if (!isCreateSuccessful)
	{
		NSLog(@"ERROR: Create directory: %@", [error localizedDescription]);
	}
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return isCreateSuccessful;
}

- (BOOL)createDirectoryAtURLBTI:(NSURL *)url
	withIntermediateDirectories:(BOOL)createIntermediates
					 attributes:(NSDictionary *)attributes
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	NSError *error = nil;
	BOOL isCreateSuccessful = [self createDirectoryAtURL:url
							 withIntermediateDirectories:createIntermediates
											  attributes:attributes
												   error:&error];
	if (!isCreateSuccessful)
	{
		NSLog(@"ERROR: Create directory: %@", [error localizedDescription]);
	}
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return isCreateSuccessful;
}

- (BOOL)removeItemAtPathBTI:(NSString *)path
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

	NSError *error = nil;
	BOOL isRemoveSuccessful = [self removeItemAtPath:path error:&error];
	if (!isRemoveSuccessful)
	{
		NSLog(@"ERROR: Remove Item: %@", [error localizedDescription]);
	}

	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return isRemoveSuccessful;
}

- (BOOL)setAttributesBTI:(NSDictionary *)attributes
			ofItemAtPath:(NSString *)path
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	NSError *error = nil;
	BOOL isAttributeSuccessful = [self setAttributes:attributes
										ofItemAtPath:path
											   error:&error];
	if (!isAttributeSuccessful)
	{
		NSLog(@"ERROR: Add file attributes: %@", [error localizedDescription]);
	}
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return isAttributeSuccessful;
}

- (BOOL)setUbiquitousBTI:(BOOL)flag
			   itemAtURL:(NSURL *)url
		  destinationURL:(NSURL *)destinationURL
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

	NSError *error = nil;
	BOOL isUbiquitousSuccessful = [self setUbiquitous:flag
											itemAtURL:url
									   destinationURL:destinationURL
												error:&error];
	if (!isUbiquitousSuccessful)
	{
		NSLog(@"ERROR: Set Ubiquitous: %@", [error localizedDescription]);
	}

	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return isUbiquitousSuccessful;
}

- (NSURL *)URLForDirectoryBTI:(NSSearchPathDirectory)directory
					 inDomain:(NSSearchPathDomainMask)domain
			appropriateForURL:(NSURL *)url
					   create:(BOOL)shouldCreate
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	NSError *error = nil;
	NSURL *returnUrl = [self URLForDirectory:directory
									inDomain:domain
						   appropriateForURL:url
									  create:shouldCreate
									   error:&error];
	if (returnUrl == nil)
	{
		NSLog(@"ERROR: URL for Directory: %@", [error localizedDescription]);
	}
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return returnUrl;
}

@end

#pragma mark - NSManagedObjectContext Categories

@implementation NSManagedObjectContext (BTIErrorAdditions)

- (NSUInteger)countForFetchRequestBTI:(NSFetchRequest *)fetchRequest
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

	NSError *error = nil;
	NSUInteger count = [self countForFetchRequest:fetchRequest error:&error];
	if (count == NSNotFound)
	{
		NSLog(@"ERROR: Fetch Request Count: %@", [error localizedDescription]);
	}

	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return count;
}

- (NSArray *)executeFetchRequestBTI:(NSFetchRequest *)fetchRequest
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	NSError *error = nil;
	NSArray *objects = [self executeFetchRequest:fetchRequest error:&error];
	if (objects == nil)
	{
		NSLog(@"ERROR: Fetch Request: %@", [error localizedDescription]);
	}
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return objects;
}

- (BOOL)saveBTI
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

	// http://stackoverflow.com/questions/1283960/iphone-core-data-unresolved-error-while-saving
	
	NSError *error = nil;
	BOOL isSaveSuccessful = [self save:&error];
	if (!isSaveSuccessful)
	{
		NSLog(@"Failed to save to data store: %@", [error localizedDescription]);
		NSArray *detailedErrors = [[error userInfo] objectForKey:NSDetailedErrorsKey];
		if (detailedErrors != nil && [detailedErrors count] > 0)
		{
			for (NSError *detailedError in detailedErrors)
			{
				NSLog(@"  DetailedError: %@", [detailedError userInfo]);
			}
		}
		else
		{
			NSLog(@"  %@", [error userInfo]);
		}
	}
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return isSaveSuccessful;
}

@end

#pragma mark - NSPersistentStoreCoordinator Categories

@implementation NSPersistentStoreCoordinator (BTIErrorAdditions)

- (NSPersistentStore *)addPersistentStoreWithTypeBTI:(NSString *)storeType
									   configuration:(NSString *)configuration
												 URL:(NSURL *)storeURL
											 options:(NSDictionary *)options
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

	NSError *error = nil;
	NSPersistentStore *store = [self addPersistentStoreWithType:storeType
												  configuration:configuration
															URL:storeURL
														options:options
														  error:&error];
	if (store == nil)
	{
		NSLog(@"ERROR: Add persistent store: %@", [error localizedDescription]);
	}

	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return store;
}

- (BOOL)removePersistentStoreBTI:(NSPersistentStore *)store
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

	NSError *error = nil;
	BOOL isRemoveSuccessful = [self removePersistentStore:store error:&error];
	if (!isRemoveSuccessful)
	{
		NSLog(@"ERROR: Remove persistent store: %@", [error localizedDescription]);
	}
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return isRemoveSuccessful;
}

@end

#pragma mark - NSString Categories

@implementation NSString (BTIErrorAdditions)

- (BOOL)writeToURLBTI:(NSURL *)url
		   atomically:(BOOL)useAuxiliaryFile
			 encoding:(NSStringEncoding)enc
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

	NSError *error = nil;
	BOOL isWriteSuccessful = [self writeToURL:url
								   atomically:useAuxiliaryFile
									 encoding:enc
										error:&error];
	if (!isWriteSuccessful)
	{
		NSLog(@"ERROR: Write to URL: %@", [error localizedDescription]);
	}

	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return isWriteSuccessful;
}

@end
