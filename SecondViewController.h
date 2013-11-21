//
//  SecondViewController.h
//  chooseBackground
//
//  Created by Jesus Victorio on 19/11/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChangeBackgroundViewController.h"

@interface SecondViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UIImageView *background;
@property (strong, nonatomic) NSString *numberPicture;
- (IBAction)dismiss:(id)sender;
@property (strong, nonatomic) IBOutlet UICollectionView *collection;
@end
