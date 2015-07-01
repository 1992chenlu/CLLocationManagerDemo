//
//  SecondViewController.h
//  CLLocationManagerDemo
//
//  Created by 鲁辰 on 7/1/15.
//  Copyright (c) 2015 ChenLu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SecondViewController : UIViewController <CLLocationManagerDelegate>

@property (nonatomic, retain) IBOutlet MKMapView *mapview;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) MKPointAnnotation *pin;

@end

