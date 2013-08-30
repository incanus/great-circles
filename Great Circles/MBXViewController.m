//
//  MBXViewController.m
//  Great Circles
//
//  Created by Justin R. Miller on 8/30/13.
//  Copyright (c) 2013 MapBox. All rights reserved.
//

#import "MBXViewController.h"

#import <MapBox/MapBox.h>

@interface MBXViewController ()

@property (nonatomic, strong) RMMapView *mapView;

@end

#pragma mark -

@implementation MBXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.mapView = [[RMMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.mapView];
}

@end
