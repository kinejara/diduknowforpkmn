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

//#define NSUserDefaults *DNPStoreSettings = [[NSUserDefaults alloc] initWithSuiteName:DNPGroupID]; \

@interface DNPCommon : NSObject

@end
