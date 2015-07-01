//
//  FirstViewController.m
//  CLLocationManagerDemo
//
//  Created by 鲁辰 on 7/1/15.
//  Copyright (c) 2015 ChenLu. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Get current time
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *time = [dateFormatter stringFromDate: currentTime];
    
    //Get all available sensors
    NSString *sensors = [self getAvailableSensors];
    
    _textview1.text = [NSString stringWithFormat:@"My Andrew ID: %s\nCurrent Time: %@\nAvailable Sensors:\n %@", "hahaha", time, sensors];
    NSLog(@"Current Time: %@\nAvailable Sensors:\n%@", time, sensors);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (NSString *)getAvailableSensors {
    NSMutableString *result = [[NSMutableString alloc] init];
    _motionManager = [[CMMotionManager alloc] init];
    
    if(self.motionManager.accelerometerAvailable){
        [result appendString:@"Accelerometer\n"];
    }
    
    if(self.motionManager.deviceMotionAvailable){
        [result appendString:@"DeviceMotion\n"];
    }
    
    if(self.motionManager.gyroAvailable){
        [result appendString:@"Gyroscope\n"];
    }
    
    if(self.motionManager.magnetometerAvailable){
        [result appendString:@"Magnetometer\n"];
    }
    
    return (NSString *) result;
}

@end