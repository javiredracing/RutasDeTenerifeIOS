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
        [route setMarker:marker];
        if ((finLat != 0) && (finLong != 0)){
            CLLocationCoordinate2D position2 = CLLocationCoordinate2DMake(finLat, finLong);
            GMSMarker *marker2 = [GMSMarker markerWithPosition:position2];
            marker2.title = nombre;
            marker2.icon = [self setIcon:approved];
            marker2.map = mapView_;
            [route setMarker:marker2];
        }
        [self.routes addObject:route];
        
        
        //NSLog(nombre);
    }
    //Route *r =[self.routes objectAtIndex:1];
    //NSLog( [r getName]);
    [results close];
}
-(BOOL)didTapMyLocationButtonForMapView:(GMSMapView *)mapView{
    NSLog(@"MyLocation");
    NSString *path = [[NSBundle mainBundle] pathForResource:@"example" ofType:@"kml"];
    NSURL *url = [NSURL fileURLWithPath:path];
    self.kmlParser = [[KMLParser alloc] initWithURL:url];
    [self.kmlParser parseKML];
    NSArray *overlays = [self.kmlParser overlays];
    NSUInteger size = [overlays count];
    NSString *cad = [NSString stringWithFormat:@"count :%lu",(unsigned long)size];
    NSLog(cad);
    return YES;
}
-(BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker{
    
    [mapView_ animateToLocation:CLLocationCoordinate2DMake(marker.position.latitude, marker.position.longitude)];
    NSLog(marker.title);

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
@end
