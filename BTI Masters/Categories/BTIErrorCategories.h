//
//  BTIErrorCategories.h
//
//  Created by Brian Slick in Sept 2012.
//  Copyright (c) 2012 BriTer Ideas LLC. All rights reserved.
//

/*
 
 OVERVIEW
 
 The intention of these categories is to provide error logging in cases where the error might not be otherwise interesting.  It is basically a "just in case" set of methods.  By using these methods, a log message will be generated in the event of an error.  For the vast majority of cases, this accomplishes in a single line of code what would otherwise require several.  If an error is discovered, then these methods should be replaced with the normal Apple method for further interrogation.  This code should only be used in situations where the developer would otherwise be lazy or negligent about handling errors (*cough*).
 
 Each method drops the "error:" parameter from the method name, then simply passes along the parameters to the normal Apple method while providing a log for any errors.
 
 As of this writing, this category is not even remotely a full list of every Apple method that includes an error: parameter.  As common situations are encountered, they will be added.
 
 */

// Libraries
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#pragma mark - NSFetchedResultsController Categories

@interface NSFetchedResultsController (BTIErrorAdditions)

- (BOOL)performFetchBTI;

@end

#pragma mark - NSFileManager Categories

@interface NSFileManager (BTIErrorAdditions)

- (NSArray *)contentsOfDirectoryAtPathBTI:(NSString *)path;
- (NSArray *)contentsOfDirectoryAtURLBTI:(NSURL *)url includingPropertiesForKeys:(NSArray *)keys options:(NSDirectoryEnumerationOptions)mask;
- (BOOL)createDirectoryAtPathBTI:(NSString *)path withIntermediateDirectories:(BOOL)createIntermediates attributes:(NSDictionary *)attributes;
- (BOOL)createDirectoryAtURLBTI:(NSURL *)url withIntermediateDirectories:(BOOL)createIntermediates attributes:(NSDictionary *)attributes;
- (BOOL)removeItemAtPathBTI:(NSString *)path;
- (BOOL)setAttributesBTI:(NSDictionary *)attributes ofItemAtPath:(NSString *)path;
- (BOOL)setUbiquitousBTI:(BOOL)flag itemAtURL:(NSURL *)url destinationURL:(NSURL *)destinationURL;
- (NSURL *)URLForDirectoryBTI:(NSSearchPathDirectory)directory inDomain:(NSSearchPathDomainMask)domain appropriateForURL:(NSURL *)url create:(BOOL)shouldCreate;

@end

#pragma mark - NSManagedObjectContext Categories

@interface NSManagedObjectContext (BTIErrorAdditions)

- (NSUInteger)countForFetchRequestBTI:(NSFetchRequest *)fetchRequest;
- (NSArray *)executeFetchRequestBTI:(NSFetchRequest *)fetchRequest;
- (BOOL)saveBTI;

@end

#pragma mark - NSPersistentStoreCoordinator Categories

@interface NSPersistentStoreCoordinator (BTIErrorAdditions)

- (NSPersistentStore *)addPersistentStoreWithTypeBTI:(NSString *)storeType configuration:(NSString *)configuration URL:(NSURL *)storeURL options:(NSDictionary *)options;
- (BOOL)removePersistentStoreBTI:(NSPersistentStore *)store;

@end

#pragma mark - NSString Categories

@interface NSString (BTIErrorAdditions)

- (BOOL)writeToURLBTI:(NSURL *)url atomically:(BOOL)useAuxiliaryFile encoding:(NSStringEncoding)enc;

@end
