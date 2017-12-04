//
//  ViewController.h
//  FinalProject
//
//  Created by Benjamin Schoen on 11/27/17.
//  Copyright © 2017 Benjamin Schoen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface ViewController : UIViewController <CLLocationManagerDelegate>

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations;

@end

