//
//  ChangeBackgroundViewController.m
//  chooseBackground
//
//  Created by Jesus Victorio on 20/11/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import "ChangeBackgroundViewController.h"
#import "ViewController.h"
#import "UIImage+ImageEffects.h"

@interface ChangeBackgroundViewController (){
    NSMutableArray *imagenes;
    
    int next;
    NSTimer *tiempo;
    int cont;
    CGFloat alpha;
    int vuelta;
}

@end

@implementation ChangeBackgroundViewController
@synthesize background, dedo, nombreImagen, numero;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    imagenes=[[NSMutableArray alloc]init];
    [imagenes addObject:@"fondo1.jpg"];
    [imagenes addObject:@"fondo2.jpg"];
    [imagenes addObject:@"fondo3.jpg"];
    [imagenes addObject:@"fondo4.jpg"];
    [imagenes addObject:@"fondo5.jpg"];
    [imagenes addObject:@"fondo6.jpg"];
    [imagenes addObject:@"fondo7.jpg"];
    [imagenes addObject:@"fondo8.jpg"];
    
    background.userInteractionEnabled = YES;
    dedo=[[UIPanGestureRecognizer alloc]init];
    [background addGestureRecognizer:dedo];
    [dedo addTarget:self action:@selector(handlePanGestureRecognizer:)];
    [self changeBackground:[imagenes objectAtIndex:[numero intValue]] num:numero];
    
    cont=10;
    alpha=1.0;
    next=[numero intValue];
    //NSLog(@"%@ -> %@",[imagenes objectAtIndex:next], numero);

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
    // Dispose of any resources that can be recreated.
/*- (void)modalPresentationMHWithoutScrollView{
    SecondViewController *modal = [self.storyboard instantiateViewControllerWithIdentifier:@"second"];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:modal];
    [nav setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:nav animated:YES completion:nil];
    
}*/
- (IBAction)openModal:(id)sender {
    //[self modalPresentationMHWithoutScrollView];
    SecondViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"second"];
    //[self savePictureTem];
    view.numberPicture=numero;
    [view setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:view animated:YES completion:nil];
}
- (IBAction)saveBackground:(id)sender {
    [((ViewController *)self.presentingViewController) changeBackground:nombreImagen num:[[NSString alloc]initWithFormat:@"%d",next]];
    [self save];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)next:(id)sender {
    next++;
    tiempo=[NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(gradient) userInfo:nil repeats:YES];
}
- (IBAction)back:(id)sender {
    next--;
    tiempo=[NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(gradient2) userInfo:nil repeats:YES];
}
- (void)gradient
{
    if(vuelta==1){
        alpha+=0.1;
        [background setAlpha:alpha];
        cont++;
    }else{
        alpha-=0.1;
        [background setAlpha:alpha];
        cont--;
    }
    
    if(cont==1){
        vuelta=1;
        //NSLog(@"%d", next);
        if(next==[imagenes count]){
            next=0;
        }
        [self changeBackground:[imagenes objectAtIndex:next] num:[[NSString alloc]initWithFormat:@"%d", next]];
    }if(cont==10){
        [tiempo invalidate];
        cont=10;
        vuelta=0;
        alpha=1.0;
    }
}
- (void)gradient2
{
    if(vuelta==1){
        alpha+=0.1;
        [background setAlpha:alpha];
        cont++;
    }else{
        alpha-=0.1;
        [background setAlpha:alpha];
        cont--;
    }
    
    if(cont==1){
        vuelta=1;
        //NSLog(@"%d", next);
        if(next==-1){
            next=[imagenes count]-1;
        }
        [self changeBackground:[imagenes objectAtIndex:next] num:[[NSString alloc]initWithFormat:@"%d", next]];
    }if(cont==10){
        [tiempo invalidate];
        cont=10;
        vuelta=0;
        alpha=1.0;
    }
}

- (void)changeBackground:(NSString *)fondo num:(NSString *)num{
    nombreImagen=fondo;
    numero=num;
    next=[numero intValue];
    if([nombreImagen length]==0){
        
    }else{
        [UIImageView beginAnimations:nil context:NULL];
        [UIImageView setAnimationDuration:0.6];
        background.alpha=1;
        background.image =[UIImage imageNamed:[imagenes objectAtIndex:[numero intValue]]];
        //background.image = [background.image applyLightEffect];
        [UIImageView commitAnimations];
        nombreImagen=fondo;
    }
    
}
- (void)handlePanGestureRecognizer:(UIPanGestureRecognizer *)gesture
{
    UIGestureRecognizerState states = [gesture state];
    CGPoint translation = [gesture translationInView:background];
    //NSLog(@"%f",translation.x);
    
    if (states == UIGestureRecognizerStateEnded || states == UIGestureRecognizerStateCancelled)
    {
        
        
        if(translation.x<-100){
            next++;
            tiempo=[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(gradient) userInfo:nil repeats:YES];
            
            
        }
        if(translation.x>100){
            next--;
            tiempo=[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(gradient2) userInfo:nil repeats:YES];
            
            
        }
        
        
    }
	
}
- (void)savePictureTem
{
    // Create instances of NSData
    UIImage *backgroundImage = background.image;
    NSData *imageData = UIImageJPEGRepresentation(backgroundImage, 100);
    // Store the data
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:imageData forKey:@"imageTemp"];
    [defaults synchronize];
    NSLog(@"Data saved");
}
- (void)save
{
    // Create strings and integer to store the text info
    NSString *backgroundName = nombreImagen;
    NSString *numberPicture  = numero;
    // Create instances of NSData
    UIImage *backgroundImage = background.image;
    NSData *imageData = UIImageJPEGRepresentation(backgroundImage, 100);
    // Store the data
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:backgroundName forKey:@"backgroundName"];
    [defaults setObject:numberPicture forKey:@"numberPicture"];
    [defaults setObject:imageData forKey:@"image"];
    [defaults synchronize];
    NSLog(@"Data saved");
}
@end
