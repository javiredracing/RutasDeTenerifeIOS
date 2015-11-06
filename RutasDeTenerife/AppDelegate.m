//
//  AppDelegate.m
//  RutasDeTenerife
//
//  Created by javi on 29/10/15.
//  Copyright © 2015 JAVI. All rights reserved.
//

#import "AppDelegate.h"
@import GoogleMaps;
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [GMSServices provideAPIKey:@"AIzaSyAbS8ztZsK2R1TU-RQ-8Sx8opgNnJXtu48"];
     [self createCopyOfDatabaseIfNeeded];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ViewController *map = [[ViewController alloc] init];
    self.window.rootViewController = map;
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)createCopyOfDatabaseIfNeeded{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appDBPath = [documentsDirectory stringByAppendingString:@"/BDRutas"];
    success = [fileManager fileExistsAtPath:appDBPath];
    if (!success){
        //database doesn`t exist
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"BDRutas"];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:appDBPath error:&error];
        if (!success)
            NSAssert1(0, @"Failed to create database file: %@", [error localizedDescription]);
        else
            NSLog(@"Database created %@", defaultDBPath);
    }else
        NSLog(@"Database %@ does exist",appDBPath);
}

@end
