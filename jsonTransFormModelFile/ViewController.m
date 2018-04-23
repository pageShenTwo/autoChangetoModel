//
//  ViewController.m
//  jsonTransFormModelFile
//
//  Created by JBT on 2018/4/23.
//  Copyright © 2018年 JBT. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+prototyWithModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *click = [UIButton buttonWithType:UIButtonTypeCustom];
    [click setTitle:@"click Me" forState:UIControlStateNormal];
    [click setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    click.center = self.view.center;
    click.frame = self.view.bounds;
    [click addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:click];
}

- (void)click{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"person" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    [NSObject prototyWithModel:dict modelName:@"person"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
