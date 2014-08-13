//
//  AppDelegate.m
//  SiliconprimeTest
//
//  Created by VinhPhuc on 7/31/14.
//  Copyright (c) 2014 Happy. All rights reserved.
//

#import "AppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>
#import "Place.h"

@implementation AppDelegate
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [FBLoginView class];
    [FBProfilePictureView class];
    //--------------core data------------
    // insert data
    NSDictionary *placeDict;
   
        placeDict=[[NSDictionary alloc] initWithObjectsAndKeys:@"Miller & Willits Accountants Inc.",@"name",@"1012 2nd St # 200, Encinitas, CA 92024, United States",@"address",[NSNumber numberWithFloat:4.5 ],@"rating",@"cell1",@"image",@"Miller & Willits Accountants, Inc. Serving Encinitas and North County 1012 Second St. ",@"desc", nil];
    
    [[CoreDataManager sharedManager] createEntityWithClassName:@"Place" attributesDictionary:placeDict];
    
    placeDict=[[NSDictionary alloc] initWithObjectsAndKeys:@"Van Riper & Messina CPA's Inc. - Carlsbad",@"name",@"2888 Loker Ave E, Carlsbad, CA 92010, United States",@"address",[NSNumber numberWithFloat:5.0 ],@"rating",@"cell2",@"image",@"Miller & Willits Accountants, Inc. Serving Encinitas and North County 1012 Second St. ",@"desc", nil];
    
    [[CoreDataManager sharedManager] createEntityWithClassName:@"Place" attributesDictionary:placeDict];
    
    return YES;
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
@end
