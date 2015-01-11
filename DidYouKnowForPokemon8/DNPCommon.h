//
//  DNPCommon.h
//  DidYouKnowForPokemon8
//
//  Created by Jorge Villa on 1/3/15.
//  Copyright (c) 2015 kine. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DNPGroupID @"group.com.didyouknowforpokemon.kine"
#define DNPStoreSettings [[NSUserDefaults alloc] initWithSuiteName:DNPGroupID]

#define IS_IPHONE (!IS_IPAD)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone)

#define DNPStoreGenerations [DNPStoreSettings arrayForKey:@"storeTeamsArray"]?([DNPStoreSettings arrayForKey:@"storeTeamsArray"]):(@[[NSNumber numberWithInteger:0]])

@interface DNPCommon : NSObject

@end
