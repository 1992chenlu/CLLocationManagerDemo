//
//  FirstViewController.h
//  CLLocationManagerDemo
//
//  Created by 鲁辰 on 7/1/15.
//  Copyright (c) 2015 ChenLu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreMotion/CoreMotion.h>



@interface FirstViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *textview1;
@property (strong, nonatomic) CMMotionManager *motionManager;

@end
