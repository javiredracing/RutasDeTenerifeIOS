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

-(void)setMarker:(GMSMarker *)marker{

}

-(NSString *)getName{
    return nil;
}

-(NSString *)getXmlRoute{
    return nil;
}

-(NSString *)getDist{
    return nil;
}

-(float)getDurac{
    return 0;
}

-(int)getDifficulty{
    return 0;
}

-(int)getId{
    return 0;
}

-(CLLocationCoordinate2D *)getFirstPoint{
    return nil;
}

-(void)setMarkersVisibility:(BOOL)visibility{

}

-(void)setWeatherJson:(NSString *)json{

}

-(NSString *)getWeatherJson{
    return nil;
}

-(void)clearWeather{

}

-(int)getRegion{
    return 0;
}

-(int)approved{
    return 0;
}

-(NSMutableArray *)getMarkersList{
    return nil;
}

@end
