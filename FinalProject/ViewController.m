//
//  ViewController.m
//  FinalProject
//
//  Created by Benjamin Schoen on 11/27/17.
//  Copyright © 2017 Benjamin Schoen. All rights reserved.
//

#import "ViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "FriendsModel.h"
#import <GooglePlaces/GooglePlaces.h>

@interface ViewController ()

@property GMSMapView *mapView;
@property CLLocationManager *myLocationManager;
@property CLLocation *myLocation;
@property (strong, nonatomic) FriendsModel* model;


@end

@implementation ViewController
GMSPlacesClient *_placesClient;

- (void)viewDidLoad {
    //[super viewDidLoad];
   // CLLocationManager locationManager = [[CLLocationManager alloc] init];
   // [locationManager requestAlwaysAuthorization];
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    
    self.model = [FriendsModel sharedModel];
    _placesClient = [GMSPlacesClient sharedClient];

    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                 zoom:6];
    

    _mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    _mapView.myLocationEnabled = YES;
    self.view = _mapView;

    
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"Please enable location services");
        return;
    }
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        NSLog(@"Please authorize location services");
        return;
    }
    
    _myLocationManager = [[CLLocationManager alloc] init];
    if ([_myLocationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [_myLocationManager requestWhenInUseAuthorization];
    }
    _myLocationManager.delegate = self;
    [_myLocationManager requestAlwaysAuthorization];
    
    [_myLocationManager startUpdatingLocation];
    


    // Do any additional setup after loading the view, typically from a nib.
    
    //Need to change starting location to be my current location
    //ask permission, save current location in some global variable i have access to in other view controllers
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation* myLocation = [locations lastObject];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:myLocation.coordinate.latitude
                                                            longitude:myLocation.coordinate.longitude
                                                                 zoom:6];
    
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    //marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.position = [myLocation coordinate];
    _myLocation = myLocation;
    marker.title = @"My Location";
    marker.snippet = @"Me";
    marker.map = _mapView;
    
    
    [_placesClient currentPlaceWithCallback:^(GMSPlaceLikelihoodList *likelihoodList, NSError *error) {
        if (error != nil) {
            NSLog(@"Current Place error %@", [error localizedDescription]);
            return;
        }
        
        for (GMSPlaceLikelihood *likelihood in likelihoodList.likelihoods) {
            GMSPlace* place = likelihood.place;
            NSLog(@"Current Place name %@ at likelihood %g", place.name, likelihood.likelihood);
            NSLog(@"Current Place address %@", place.formattedAddress);
            NSLog(@"Current Place attributions %@", place.attributions);
            NSLog(@"Current PlaceID %@", place.placeID);
            
            if(place.name.length > 0)
            {
                self.model.myLocation = place.name;
                break;
            }
            
        }
        
    }];
    
    
    [_mapView animateToCameraPosition:camera];
    
}


@end
