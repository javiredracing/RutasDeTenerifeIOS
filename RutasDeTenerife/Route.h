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
    float dist;
    int difficulty;
    int identifier;
    float durac;
    NSString *weatherJson;
    NSTimeInterval timeStamp;
    int region;
    int approved;
}

@property (readonly) BOOL isActive;

-(void)setMarker: (GMSMarker *)marker;
-(NSString *)getName;
-(NSString *)getXmlRoute;
-(float)getDist;
-(float)getDurac;
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

@end
