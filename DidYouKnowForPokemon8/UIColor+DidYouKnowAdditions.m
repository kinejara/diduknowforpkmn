//
//  UIColor+DidYouKnow.m
//  DidYouKnowForPokemon8
//
//  Created by Jorge Kinejara on 12/22/14.
//  Copyright (c) 2014 kine. All rights reserved.
//

#import "UIColor+DidYouKnowAdditions.h"

#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define RGB(r, g, b) RGBA(r,g,b,1)

@implementation UIColor (DidYouKnowAdditions)


+ (UIColor *)pkmn_systemRedColor {
    return RGB(170, 38, 42);
}

+ (UIColor *)pkmn_systemBlueColor {
    return RGB(217, 235, 237);
}


@end
