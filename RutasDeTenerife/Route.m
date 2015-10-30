//
//  Route.m
//  RutasDeTenerife
//
//  Created by javi on 30/10/15.
//  Copyright © 2015 JAVI. All rights reserved.
//

#import "Route.h"

@implementation Route

@synthesize isActive = _isActive;


-(id)init:(int)_id :(NSString *) name1 :(NSString*)_xml :(float)_dist :(int) _difficulty : (float)_durac :(int)approved :(int)reg{
    self = [super init];
    if (self) {
        //self
    }
    return self;
}

@end
