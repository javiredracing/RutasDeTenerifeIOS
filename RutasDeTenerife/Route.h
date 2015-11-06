//
//  Route.h
//  RutasDeTenerife
//
//  Created by javi on 30/10/15.
//  Copyright © 2015 JAVI. All rights reserved.
//

#import <Foundation/Foundation.h>
@import GoogleMaps;

@interface Route : NSObject{

    NSMutableArray *markerList;
    NSString *name;
    NSString *xmlRoute;
    BOOL isActive;
    double dist;
    int difficulty;
    int identifier;
    double durac;
    NSString *weatherJson;
    NSTimeInterval timeStamp;
    int region;
    int approved;
}

@property (readonly) BOOL isActive;

-(void)setMarker: (GMSMarker *)marker;
-(NSString *)getName;
-(NSString *)getXmlRoute;
-(double)getDist;
-(double)getDurac;
-(int)getDifficulty;
-(int)getId;
-(CLLocationCoordinate2D)getFirstPoint;
-(void)setMarkersVisibility: (BOOL)visibility;
-(void)setWeatherJson:(NSString *)json;
-(NSString *)getWeatherJson;
-(void)clearWeather;
-(int)getRegion;
-(int)approved;
-(NSMutableArray *)getMarkersList;
-(id)init:(int)_id :(NSString *) name1 :(NSString*)_xml :(double)_dist :(int) _difficulty : (double)_durac :(int)_approved :(int)reg;

@end
