//
//  ChangeBackgroundViewController.h
//  chooseBackground
//
//  Created by Jesus Victorio on 20/11/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SecondViewController.h"

@interface ChangeBackgroundViewController : UIViewController<UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *background;
@property (strong, nonatomic) NSString *nombreImagen;
@property (strong, nonatomic) UIPanGestureRecognizer *dedo;
@property (strong, nonatomic) NSString *numero;


- (IBAction)saveBackground:(id)sender;
- (IBAction)next:(id)sender;
- (IBAction)back:(id)sender;
- (void)changeBackground:(NSString *)fondo num:(NSString *)num;
- (IBAction)openModal:(id)sender;
@end
