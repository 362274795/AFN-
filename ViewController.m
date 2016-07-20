//
//  ViewController.m
//  AFN二次封装
//
//  Created by lc on 16/7/19.
//  Copyright © 2016年 lcnicky. All rights reserved.
//

#import "ViewController.h"
#import "LCNetwork.h"
#define url @"http://api.breadtrip.com/place/pois/nearby/?category=11&start=0&count=20&latitude=0.000000&longitude=0.000000"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.拼接URL地址
    
    //百分号编码
 //   NSString *percentURL = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  //  NSLog(@"%@",percentURL);

    
    [LCNetwork GET:url params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"!!!!!!%@",error.localizedDescription);
    }];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
