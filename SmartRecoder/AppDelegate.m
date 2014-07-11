//
//  AppDelegate.m
//  SmartRecoder
//
//  Created by 양동길 on 2014. 6. 28..
//  Copyright (c) 2014년 양동길. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize pRootViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
    
//    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
//        // iOS 7
//        [self prefersStatusBarHidden];
//        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
//    } else {
//        // iOS 6
//        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
//    }
    
    [self CopyOfDataBaseIfNeeded];
    [self.window addSubview:[pRootViewController view]];
    [self.window makeKeyAndVisible];
    return YES;
}

//번들 데이터베이스 복사
- (BOOL) CopyOfDataBaseIfNeeded
{
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	NSString *documentDirectory = [paths objectAtIndex:0];
	
	NSString *myPath = [documentDirectory stringByAppendingPathComponent:@"RecordDB.sqlite"];
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	BOOL exist = [fileManager fileExistsAtPath:myPath];
	
	if (exist) {
		NSLog(@"DB가 존재합니다.");
		return TRUE;
	}
	
    //파일이 없다면 리소스에서 파일 복사
	NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"RecordDB.sqlite"];
	
	return [fileManager copyItemAtPath:defaultDBPath toPath:myPath error:nil];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
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
