//
//  SecondViewController.m
//  CLLocationManagerDemo
//
//  Created by 鲁辰 on 7/1/15.
//  Copyright (c) 2015 ChenLu. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize mapview = _mapview;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //initialize locationManager
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.activityType = CLActivityTypeAutomotiveNavigation;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [_locationManager requestWhenInUseAuthorization];
    
    [_mapview setShowsUserLocation:YES];
    [_mapview setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    
    _pin = [[MKPointAnnotation alloc] init];
    _pin.title = @"No available address found.";
    [_mapview addAnnotation:_pin];
    
    [_locationManager startUpdatingLocation];
}

-(void)viewDidAppear:(BOOL)animated {
    [_locationManager startUpdatingLocation];
    
    //reset region
    MKCoordinateRegion region = { { 0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = self.locationManager.location.coordinate.latitude;
    region.center.longitude = self.locationManager.location.coordinate.longitude;
    region.span.latitudeDelta = 0.0187f;
    region.span.longitudeDelta = 0.0137f;
    [self.mapview setRegion:region animated:YES];
    
    
    //setup timer for location updates
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    [_locationManager stopUpdatingLocation];
    [_timer invalidate];
    _timer = nil;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *curLocation = [locations lastObject];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:curLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (error)
         {
             NSLog(@"failed with error: %@", error);
             NSLog(@"%@", curLocation);
             _pin.title = @"No available address found.";
             return;
         }
         if(placemarks.count > 0)
         {
             CLPlacemark * placemark=placemarks[0];
             NSString *address = [NSString stringWithFormat:@"%@ %@, %@, %@, %@", placemark.subThoroughfare == nil ? @"" : placemark.subThoroughfare, placemark.thoroughfare, placemark.locality, placemark.administrativeArea, placemark.postalCode];
             _pin.title = address;
             NSLog(@"%@", _pin.title);
         }
     }];
    _pin.coordinate = curLocation.coordinate;
    
}

- (void)timerFireMethod:(NSTimer*)theTimer {
    //remove a second from the display
    NSLog(@"Latitude:%f Longitude:%f", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude);
}

@end

