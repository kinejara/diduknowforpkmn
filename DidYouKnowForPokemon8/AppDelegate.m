//
//  AppDelegate.m
//  DidYouKnowForPokemon8
//
//  Created by Jorge Kinejara on 12/12/14.
//  Copyright (c) 2014 kine. All rights reserved.
//

#import "AppDelegate.h"
#import "Pharases.h"
#import "NSMutableArray+Shuffling.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
    [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    
    if ([self areNotificationsEnabled]) {
        [self setUpListOfNotifications];
    }
    
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

- (BOOL)areNotificationsEnabled {
    UIUserNotificationSettings *noticationSettings = [[UIApplication sharedApplication] currentUserNotificationSettings];
    
    if (!noticationSettings || (noticationSettings.types == UIUserNotificationTypeNone)) {
        return NO;
    }
    return YES;
}

- (void)setUpListOfNotifications {
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    for (int i=0; i<31; i++) {
     //   [self setNotificationWithDate:[[self nextNotificationDate] dateByAddingTimeInterval:30 *i]];
    }
}

- (NSString *)getRandomFactForPushNotification {
    
    Pharases *pokeFact = [Pharases new];
    NSArray *storeGenerations = [self getStoreGenerationFromSettings];
    NSArray *arrayOfFacts = [pokeFact createArrayOfPokePhrasesWithGenerations:storeGenerations];
    NSMutableArray *shuffleFacts = [NSMutableArray shuffleArray:arrayOfFacts];
    
    return shuffleFacts[0];
}

- (NSArray *)getStoreGenerationFromSettings {
    
    NSArray *storeGenerations = [NSArray array];
    
    if ([DNPStoreSettings arrayForKey:@"storeTeamsArray"]) {
        storeGenerations = [DNPStoreSettings arrayForKey:@"storeTeamsArray"];
    } else {
        storeGenerations = @[NSLocalizedString(@"all", @"")];
    }
    
    return storeGenerations;
}

- (void)setNotificationWithDate:(NSDate *)notificationFireDate {
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = notificationFireDate;
    localNotification.alertBody = [self getRandomFactForPushNotification];
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.repeatInterval = NSCalendarUnitDay;
    localNotification.applicationIconBadgeNumber = 0;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
}

- (NSDate *)nextNotificationDate {
    
    NSDate *now = [NSDate date];
   
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    //TODO: this is just for test
    [components setHour:0];
    [components setMinute:46];
    NSDate *next12pm = [calendar dateFromComponents:components];
    if ([next12pm timeIntervalSinceNow] < 0) {
        // If today's 12pm already occurred, add 24hours to get to tomorrow's
        next12pm = [next12pm dateByAddingTimeInterval:60*60*24];
    }
    
    return next12pm;
}

@end
