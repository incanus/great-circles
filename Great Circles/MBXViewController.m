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
    self.mapView.zoom = 2;
    self.mapView.minZoom = self.mapView.zoom;
    self.mapView.maxZoom = self.mapView.zoom;

    [self.view addSubview:self.mapView];

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    pan.minimumNumberOfTouches = 2;
    pan.maximumNumberOfTouches = 2;
    [self.mapView addGestureRecognizer:pan];
}

- (void)pan:(UIPanGestureRecognizer *)pan
{
    if (pan.state == UIGestureRecognizerStateCancelled || pan.state == UIGestureRecognizerStateEnded)
    {
        [self.mapView removeAllAnnotations];
    }
    else if (pan.state == UIGestureRecognizerStateBegan)
    {
        CGPoint p1 = [pan locationOfTouch:0 inView:self.mapView];
        CGPoint p2 = [pan locationOfTouch:1 inView:self.mapView];

        if (p1.x > p2.x)
        {
            p1 = [pan locationOfTouch:1 inView:self.mapView];
            p2 = [pan locationOfTouch:0 inView:self.mapView];
        }

        [self.mapView addAnnotation:[[RMGreatCircleAnnotation alloc] initWithMapView:self.mapView
                                                                         coordinate1:[self.mapView pixelToCoordinate:p1]
                                                                         coordinate2:[self.mapView pixelToCoordinate:p2]]];
    }
    else if (pan.state == UIGestureRecognizerStateChanged)
    {
        [self.mapView removeAllAnnotations];

        if (pan.numberOfTouches == 2)
        {
            CGPoint p1 = [pan locationOfTouch:0 inView:self.mapView];
            CGPoint p2 = [pan locationOfTouch:1 inView:self.mapView];

            if (p1.x > p2.x)
            {
                p1 = [pan locationOfTouch:1 inView:self.mapView];
                p2 = [pan locationOfTouch:0 inView:self.mapView];
            }

            [self.mapView addAnnotation:[[RMGreatCircleAnnotation alloc] initWithMapView:self.mapView
                                                                             coordinate1:[self.mapView pixelToCoordinate:p1]
                                                                             coordinate2:[self.mapView pixelToCoordinate:p2]]];

            ((RMGreatCircleAnnotation *)self.mapView.annotations.firstObject).lineColor = [UIColor purpleColor];
            ((RMGreatCircleAnnotation *)self.mapView.annotations.firstObject).lineWidth = 10;
        }
    }
}

@end
