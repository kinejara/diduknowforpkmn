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
    
    [self askForPushNotifications];
    [self setUpListOfNotifications];
    
    if ([self areNotificationsEnabled]) {
        
    }
    //Display error is there is no URL
    if (![launchOptions objectForKey:UIApplicationLaunchOptionsURLKey]) {
        NSLog(@"NO URL SCHEME");
    }
    
    //[self configureDefaultSettings];
    
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

- (void)configureDefaultSettings {
    if(![DNPStoreSettings objectForKey:@"storeTeamsArray"]) {
        NSArray *pokeFactsOptions = [[NSArray alloc] initWithObjects:
                                     NSLocalizedString(@"all", @""),nil];
        [DNPStoreSettings  setObject:pokeFactsOptions forKey:@"storeTeamsArray"];
        [DNPStoreSettings synchronize];
    }
}

- (void)askForPushNotifications {

    //[[UIApplication sharedApplication] unregisterForRemoteNotifications];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:
                                                                         UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
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
        [self setNotificationWithDate:[[self nextNotificationDate] dateByAddingTimeInterval:60*60*24*i]];
    }
}

- (void)printNextNotification:(NSDate *)currentTime {
    
    //NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy hh-mm"];
    NSString *resultString = [dateFormatter stringFromDate: currentTime];
    
    NSLog(@"----> next daily notification %@",resultString);
}

- (NSString *)getRandomFactForPushNotification {
    //[DNPStoreSettings setObject:nil forKey:@"storeTeamsArray"];
    Pharases *pokeFact = [Pharases new];
    NSArray *storeGenerations = DNPStoreGenerations;
    NSArray *arrayOfFacts = [pokeFact createArrayOfPokePhrasesWithGenerations:storeGenerations];
    NSMutableArray *shuffleFacts = [NSMutableArray shuffleArray:arrayOfFacts];
    
    return shuffleFacts[0];
}

- (void)setNotificationWithDate:(NSDate *)notificationFireDate {
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = notificationFireDate;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.alertBody = [self getRandomFactForPushNotification];
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.repeatInterval = NSCalendarUnitDay;
    localNotification.applicationIconBadgeNumber = 0;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
}

- (NSDate *)nextNotificationDate {
    
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSDate *now = [NSDate date];
  
    NSDateComponents *dateComponents = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:now];
    
    NSDateComponents *dateComps = [[NSDateComponents alloc] init];
    
    [dateComps setDay:[dateComponents day]];
    [dateComps setMonth:[dateComponents month]];
    [dateComps setYear:[dateComponents year]];
    
    [dateComps setHour:13];
    //[dateComps setMinute:[timeComponents minute]];
    //[dateComps setSecond:[timeComponents second]];
    NSDate *next12pm = [calendar dateFromComponents:dateComps];
    
    if ([next12pm timeIntervalSinceNow] < 0) {
        next12pm = [next12pm dateByAddingTimeInterval:60*60*24];
    }
    
    return next12pm;
}

@end
