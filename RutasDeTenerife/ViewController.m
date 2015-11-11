//
//  ViewController.m
//  RutasDeTenerife
//
//  Created by javi on 29/10/15.
//  Copyright © 2015 JAVI. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()


@end

@implementation ViewController{
    GMSMapView *mapView_;
    GMSPolyline *currentPath;
    Route *lastRouteShowed;
    
    BOOL isTapped;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.db = [[Database alloc ]init];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:28.299221 longitude: -16.525690 zoom:6];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    mapView_.mapType = kGMSTypeTerrain;
    mapView_.indoorEnabled = NO;
    mapView_.accessibilityElementsHidden = NO;
    mapView_.settings.rotateGestures = NO;
    mapView_.settings.tiltGestures = NO;
    mapView_.settings.compassButton = NO;
    mapView_.settings.myLocationButton = YES;

    mapView_.delegate = self;
    self.view = mapView_;
    [self loadRoutes];
    
    isTapped = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] init];
    [mapView_ animateWithCameraUpdate: [GMSCameraUpdate fitBounds:bounds withPadding:30.0f]];
    
    //bounds = [bounds includingCoordinate:marker2.position];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadRoutes{
    self.routes = [[NSMutableArray alloc]init];
    FMResultSet * results = [self.db getInfoMap];
    
   
    
    while ([results next]) {
        NSString *nombre = [results stringForColumnIndex:0];
        double inicLat = [results doubleForColumnIndex:1];
        double inicLong = [results doubleForColumnIndex:2];
        double finLat = [results doubleForColumnIndex:3];
        double finLong = [results doubleForColumnIndex:4];
        double durac = [results doubleForColumnIndex:5];
        double dist = [results doubleForColumnIndex:6];
        int dific = [results intForColumnIndex:7];
        NSString *xml = [results stringForColumnIndex:8];
        int identifier = [results intForColumnIndex:9];
        int approved = [results intForColumnIndex:10];
        int region = [results intForColumnIndex:11];
        //(int)_id :(NSString *) name1 :(NSString*)_xml :(float)_dist :(int) _difficulty : (float)_durac :(int)_approved :(int)reg;
        Route *route = [[Route alloc]init:identifier :nombre :xml :dist :dific :durac :approved :region];
        CLLocationCoordinate2D position = CLLocationCoordinate2DMake(inicLat, inicLong);
        GMSMarker *marker = [GMSMarker markerWithPosition:position];
        marker.title = nombre;
        marker.icon = [self setIcon:approved];
        marker.map = mapView_;
        marker.userData = [NSNumber numberWithInt:identifier];
        
        [route setMarker:marker];
        if ((finLat != 0) && (finLong != 0)){
            CLLocationCoordinate2D position2 = CLLocationCoordinate2DMake(finLat, finLong);
            GMSMarker *marker2 = [GMSMarker markerWithPosition:position2];
            marker2.title = nombre;
            marker2.icon = [self setIcon:approved];
            marker2.map = mapView_;
            marker2.userData = [NSNumber numberWithInt:identifier];
            [route setMarker:marker2];
            
        }
        [self.routes addObject:route];
    }
    
    
    [results close];
}

-(BOOL)didTapMyLocationButtonForMapView:(GMSMapView *)mapView{
    NSLog(@"MyLocation");
    /*NSString *path = [[NSBundle mainBundle] pathForResource:@"example" ofType:@"kml"];
    NSURL *url = [NSURL fileURLWithPath:path];
    self.kmlParser = [[CustomKMLParser alloc] initWithURL:url];
    [self.kmlParser parseKML];
    CLLocationCoordinate2D c = [[self.kmlParser.path objectAtIndex:3] MKCoordinateValue];
    NSLog([NSString stringWithFormat:@"Latitud parseo 3: %f", c.latitude ]);
    NSArray *overlays = [self.kmlParser overlays];
    NSUInteger size = [overlays count];
    NSString *cad = [NSString stringWithFormat:@"count :%lu",(unsigned long)size];
    NSLog(cad);*/
    return NO;
}

-(BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker{
    
   
    NSNumber *number = marker.userData;
    NSUInteger identifer = [number unsignedIntegerValue];
    Route *route = [self findRouteById:identifer];
    if (route != nil)
        [self clickAction:route :marker.position];
    return YES;
}

-(UIImage *)setIcon: (int)approved{

    UIImage *icon = nil;
    switch (approved) {
        case 0:
            icon = [UIImage imageNamed:@"marker_sign_16_normal"];
            break;
        case 1:
            icon = [UIImage imageNamed:@"marker_sign_16_green"];
            break;
        case 2:
            icon = [UIImage imageNamed:@"marker_sign_16_yellow"];
            break;
        case 3:
            icon = [UIImage imageNamed:@"marker_sign_16_red"];
            break;
        default:
            icon = [UIImage imageNamed:@"marker_sign_16_normal"];
            break;
    }
    return icon;
}

-(Route *)findRouteById:(NSUInteger)identifier{
    Route *r = nil;
    NSUInteger size = [self.routes count];
    for (NSUInteger i = 0; i < size; i++){
        r = [self.routes objectAtIndex:i];
        if ([r getId] == identifier)
            return r;
    }
    return r;
}

-(void)clickAction: (Route *)myroute: (CLLocationCoordinate2D)pos{
    
    if (!isTapped) {
        isTapped = YES;
        if (lastRouteShowed != nil){
            if ([lastRouteShowed getId] == [myroute getId]){
                lastRouteShowed = nil;
            }
        }
        
        myroute.isActive = !myroute.isActive;
        if (lastRouteShowed != nil) {
            lastRouteShowed.isActive = NO;
        }
        lastRouteShowed = myroute;
        if (currentPath != nil){
            currentPath.map = nil;
        }
        
        
        if (myroute.isActive){
            
            [mapView_ animateToLocation:pos];
            NSString *kmlName = [myroute getXmlRoute];
            kmlName =[kmlName substringToIndex:[kmlName length] - 4];
            NSLog(kmlName);
            
            NSString *path = [[NSBundle mainBundle] pathForResource:kmlName ofType:@"kml"];
            NSURL *url = [NSURL fileURLWithPath:path];
            
            //Async task
            dispatch_queue_t queue = dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0);
            dispatch_async(queue, ^{
                //code to be executed in the background
                self.kmlParser = [[CustomKMLParser alloc] initWithURL:url];
                [self.kmlParser parseKML];
                NSMutableArray *coordinates = self.kmlParser.path;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    //code to be executed on the main thread when background task is finished
                    GMSMutablePath *points = [GMSMutablePath path];
                    NSUInteger size = [coordinates count];
                    for (NSUInteger i = 0; i < size; i++){
                        NSValue *value = [coordinates objectAtIndex:i];
                        CLLocationCoordinate2D c = [value MKCoordinateValue];
                        [points addCoordinate:c];
                    }
                    currentPath = [GMSPolyline polylineWithPath:points];
                    currentPath.map = mapView_;
                    isTapped = NO;
                });
            });
        }
    }
}
@end
