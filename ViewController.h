//
//  ViewController.h
//  chooseBackground
//
//  Created by Jesus Victorio on 19/11/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChangeBackgroundViewController.h"

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *background;
@property (strong, nonatomic) NSString *nombreImagen;
@property (strong, nonatomic) NSString *numero;

- (void)changeBackground:(NSString *)fondo num:(NSString *)num;
- (IBAction)openModal:(id)sender;

@end
