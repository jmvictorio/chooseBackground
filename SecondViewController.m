//
//  SecondViewController.m
//  chooseBackground
//
//  Created by Jesus Victorio on 19/11/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import "SecondViewController.h"
#import "UIImage+ImageEffects.h"

@interface SecondViewController (){
    NSMutableArray *imagenes;
}


@end

@implementation SecondViewController
@synthesize collection, background, numberPicture;

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
    /*NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *imageData = [defaults dataForKey:@"imageTemp"];*/
    imagenes=[[NSMutableArray alloc]init];
    [imagenes addObject:@"fondo1.jpg"];
    [imagenes addObject:@"fondo2.jpg"];
    [imagenes addObject:@"fondo3.jpg"];
    [imagenes addObject:@"fondo4.jpg"];
    [imagenes addObject:@"fondo5.jpg"];
    [imagenes addObject:@"fondo6.jpg"];
    [imagenes addObject:@"fondo7.jpg"];
    [imagenes addObject:@"fondo8.jpg"];
    background.image = [[UIImage imageNamed:[imagenes objectAtIndex:[numberPicture intValue]]] applyLightEffect];
    self.collection.delegate = self;
    self.collection.dataSource = self;
    //collection.delegate=self;
	// Do any additional setup after loading the view.
    
}
#pragma mark - UICollectionViewDataSource & Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [imagenes count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    // cell customization
    UIImageView *imagen=[[UIImageView alloc]initWithImage:[self generatePhotoThumbnail:[UIImage imageNamed:[imagenes objectAtIndex:indexPath.row]] withSide:82]];
    
    [cell addSubview:imagen];
    
    return cell;
 
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [((ChangeBackgroundViewController *)self.presentingViewController) changeBackground:[imagenes objectAtIndex:indexPath.row] num:[[NSString alloc]initWithFormat:@"%d",indexPath.row]];
    //NSLog(@"%@ -> %d",[imagenes objectAtIndex:indexPath.row], indexPath.row );
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)generatePhotoThumbnail:(UIImage *)image withSide:(CGFloat)ratio
{
    // Create a thumbnail version of the image for the event object.
    CGSize size = image.size;
    CGSize croppedSize;
    
    CGFloat offsetX = 0.0;
    CGFloat offsetY = 0.0;
    
    // check the size of the image, we want to make it
    // a square with sides the size of the smallest dimension.
    // So clip the extra portion from x or y coordinate
    if (size.width > size.height) {
        offsetX = (size.height - size.width) / 2;
        croppedSize = CGSizeMake(size.height, size.height);
    } else {
        offsetY = (size.width - size.height) / 2;
        croppedSize = CGSizeMake(size.width, size.width);
    }
    
    // Crop the image before resize
    CGRect clippedRect = CGRectMake(offsetX * -1, offsetY * -1, croppedSize.width, croppedSize.height);
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], clippedRect);
    // Done cropping
    
    // Resize the image
    CGRect rect = CGRectMake(0.0, 0.0, ratio, ratio);
    
    UIGraphicsBeginImageContext(rect.size);
    [[UIImage imageWithCGImage:imageRef] drawInRect:rect];
    UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // Done Resizing
    
    return thumbnail;
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
