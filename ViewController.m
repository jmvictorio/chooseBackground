//
//  ViewController.m
//  chooseBackground
//
//  Created by Jesus Victorio on 19/11/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    UIView *secondView;
    int next;
    NSMutableArray *imagenes;
    NSTimer *tiempo;
    int cont;
    CGFloat alpha;
    int vuelta;
}

@end

@implementation ViewController
@synthesize nombreImagen, background, numero;

- (void)viewDidLoad
{
    // Get the stored data before the view loads
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    nombreImagen = [defaults objectForKey:@"backgroundName"];
    numero = [defaults objectForKey:@"numberPicture"];
    NSData *imageData = [defaults dataForKey:@"image"];
    background.image = [UIImage imageWithData:imageData];
    // Update the UI elements with the saved data
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setupPictures];
    //background.image=[UIImage imageNamed:@"fondo1.jpg"];
    background.userInteractionEnabled = YES;
    [self changeBackground:nombreImagen num:numero];
    
    cont=10;
    alpha=1.0;
    next=1;
}

- (void)setupPictures
{
    imagenes=[[NSMutableArray alloc]init];
    [imagenes addObject:@"fondo1.jpg"];
    [imagenes addObject:@"fondo2.jpg"];
    [imagenes addObject:@"fondo3.jpg"];
    [imagenes addObject:@"fondo4.jpg"];
    [imagenes addObject:@"fondo5.jpg"];
    [imagenes addObject:@"fondo6.jpg"];
    [imagenes addObject:@"fondo7.jpg"];
    [imagenes addObject:@"fondo8.jpg"];
}
- (void)changeBackground:(NSString *)fondo num:(NSString *) num{
    nombreImagen=fondo;
    numero=num;
    if([nombreImagen length]==0){
        numero=@"0";
        nombreImagen=@"fondo1.jpg";
        [UIImageView beginAnimations:nil context:NULL];
        [UIImageView setAnimationDuration:0.6];
        background.alpha=1;
        background.image =[UIImage imageNamed:nombreImagen];
        [UIImageView commitAnimations];
    }else{
        [UIImageView beginAnimations:nil context:NULL];
        [UIImageView setAnimationDuration:0.6];
        background.alpha=1;
        background.image =[UIImage imageNamed:nombreImagen];
        [UIImageView commitAnimations];
    }
    
}
- (IBAction)openModal:(id)sender {
    ChangeBackgroundViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"choose"];
    view.numero=numero;
    view.nombreImagen=nombreImagen;
    [view setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:view animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
