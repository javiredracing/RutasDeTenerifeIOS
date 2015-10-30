//
//  ViewController.m
//  RutasDeTenerife
//
//  Created by javi on 29/10/15.
//  Copyright © 2015 JAVI. All rights reserved.
//

#import "ViewController.h"
@import GoogleMaps;

@interface ViewController ()


@end

@implementation ViewController{
    GMSMapView *mapView_;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86 longitude:151.20 zoom:6];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    mapView_.mapType = kGMSTypeTerrain;
    mapView_.indoorEnabled = NO;
    mapView_.accessibilityElementsHidden = NO;
    mapView_.settings.rotateGestures = NO;
    mapView_.settings.tiltGestures = NO;
    mapView_.settings.compassButton = NO;
    mapView_.settings.myLocationButton = YES;
    self.view = mapView_;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
