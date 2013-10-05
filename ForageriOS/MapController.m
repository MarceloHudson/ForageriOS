//
//  MapController.m
//  ForageriOS
//
//  Created by Joseph Milsom on 22/07/13.
//  Copyright (c) 2013 Joseph Milsom. All rights reserved.
//

#import "MapController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface MapController(){
    BOOL *isSplitViewOpen;
}
@property (nonatomic) IBOutlet UIView *mapViewContainer;
@property (weak, nonatomic) IBOutlet UIView *splitView;
- (IBAction)splitViewTrigger:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *navBar;

@end

@implementation MapController {
    GMSMapView *mapView;
}


- (void) viewDidLoad{
    [super viewDidLoad];
    isSplitViewOpen = NO;

}

//need this as you can only get the size of the table frame(used for map initialisation)
//after it has been put into the layout
- (void) viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-41.31 longitude:174.78 zoom:13];
    mapView = [GMSMapView mapWithFrame:self.mapViewContainer.bounds camera:camera];
    mapView.myLocationEnabled = YES;

    //just adding buttons for navigation on the map
    [self.mapViewContainer addSubview:mapView];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];

    int buttonPosY = self.mapViewContainer.frame.size.height - 50;
    int mapWidth = self.mapViewContainer.frame.size.width;
    button.frame = CGRectMake(0, buttonPosY, mapWidth/4, 50.0);
    button2.frame = CGRectMake(mapWidth/4, buttonPosY, mapWidth/4, 50.0);
    button3.frame = CGRectMake((mapWidth/4)*2, buttonPosY, mapWidth/4, 50.0);
    button4.frame = CGRectMake((mapWidth/4)*3, buttonPosY, mapWidth/4, 50.0);
    [self.mapViewContainer addSubview:button];
    [self.mapViewContainer addSubview:button2];
    [self.mapViewContainer addSubview:button3];
    [self.mapViewContainer addSubview:button4];
}

- (IBAction)splitViewTrigger:(id)sender {
    CGRect mapViewFrame = self.mapViewContainer.frame;
    CGRect navBarFrame = self.navBar.frame;

    if(isSplitViewOpen == NO){
        isSplitViewOpen = YES;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        mapViewFrame.origin.x = 200;
        navBarFrame.origin.x = 200;
        self.mapViewContainer.frame = mapViewFrame;
        self.navBar.frame = navBarFrame;
        [UIView commitAnimations];
    }
    else{
        isSplitViewOpen = NO;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        mapViewFrame.origin.x = 0;
        navBarFrame.origin.x = 0;
        self.mapViewContainer.frame = mapViewFrame;
        self.navBar.frame = navBarFrame;
        [UIView commitAnimations];
    }

}
@end
