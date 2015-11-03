//
//  ViewController.m
//  MapKit
//
//  Created by 章芝源 on 15/11/3.
//  Copyright © 2015年 ZZY. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
@interface ViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
///用户定位
@property(strong, nonatomic)CLLocationManager *manager;
@end

@implementation ViewController

#pragma mark - lazy
- (CLLocationManager *)manager
{
    if(!_manager){
        _manager = [[CLLocationManager alloc]init];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.请求定位
    [self.manager requestAlwaysAuthorization];
    [self.manager startUpdatingLocation];
    //2. 设置定位模式   跟踪并显示用户当前位置, 地图会跟着用户前进方向旋转
    self.mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    //3. 设置地图的类型
    [self.mapView setMapType:MKMapTypeStandard];
    
    //设置代理
    self.mapView.delegate = self;
    
}

#pragma mark - MKMapViewDelegate
/**
 *  更新到当前用户的位置就会调用   在更新了location的数据,  但是屏幕上面还没有更新的时候调用
 每次调用都会把用户最新的位置, 传进来userLocation
 *
 *  @param mapView      mapView
 *  @param userLocation 用户位置
 */
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    //MKUserLocation  系统默认大头
    userLocation.title = @"东莞";
    userLocation.subtitle = @"沉痛几年东莞扫黄3周年";
}

///当屏幕显示mapView的范围发生改变的时候, 调用,
////用于加载当前屏幕范围,的数据
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    NSLog(@"%f       %f", mapView.region.span.latitudeDelta, mapView.region.span.longitudeDelta);
}

///设置跨度
- (IBAction)changeLocation:(id)sender {
    //跨度
    MKCoordinateSpan span = MKCoordinateSpanMake(10, 10);
    //区域结构体
    MKCoordinateRegion region = MKCoordinateRegionMake(self.mapView.userLocation.location.coordinate, span);
    //设置区域
    self.mapView.region = region;
}

@end
