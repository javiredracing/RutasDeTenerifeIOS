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


-(id)init:(int)_id :(NSString *) name1 :(NSString*)_xml :(double)_dist :(int) _difficulty : (double)_durac :(int)_approved :(int)reg{
    self = [super init];
    if (self) {
        //self
        markerList = [[NSMutableArray alloc]init];
        name = name1;
        xmlRoute = _xml;
        dist = _dist;
        difficulty = _difficulty;
        identifier = _id;
        durac = _durac;
        timeStamp = 0;
        weatherJson = nil;
        region = reg;
        approved = _approved;
    }
    return self;
}

-(void)setMarker:(GMSMarker *)marker{
    [markerList addObject:marker];
}

-(NSString *)getName{
    return name;
}

-(NSString *)getXmlRoute{
    return xmlRoute;
}

-(double)getDist{
    return dist;
}

-(double)getDurac{
    return durac;
}

-(int)getDifficulty{
    return difficulty;
}

-(int)getId{
    return identifier;
}

-(CLLocationCoordinate2D)getFirstPoint{
    GMSMarker *marker = [markerList objectAtIndex:0];
    CLLocationCoordinate2D pos = [marker position];
    return pos;
}

-(void)setMarkersVisibility:(BOOL)visibility{
    NSUInteger size = [markerList count];
    for (NSUInteger i = 0; i < size; i++){
        GMSMarker *marker = [markerList objectAtIndex:i];
        if (visibility)
            marker.opacity = 1;
        else
            marker.opacity = 0;
    }
}

-(void)setWeatherJson:(NSString *)json{
    weatherJson = json;
    timeStamp =[[NSDate date] timeIntervalSince1970];
}

-(NSString *)getWeatherJson{
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    if (weatherJson != nil){
        if (now - timeStamp <= 3600)
            return weatherJson;
        else
            [self clearWeather];
    }
    return nil;
}

-(void)clearWeather{
    weatherJson = nil;
    timeStamp = 0.0;
}

-(int)getRegion{
    return region;
}

-(int)approved{
    return approved;
}

-(NSMutableArray *)getMarkersList{
    return markerList;
}

@end
