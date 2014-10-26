//
//  PHNYScreenViewController.h
//  Pods
//
//  Created by Fabian Canas on 10/25/14.
//  Copyright (c) 2014 Fabian Canas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PHNYScreenViewController : UIViewController
@property (nonatomic, strong) IBOutlet UIViewController *rootViewController;
@property (weak, nonatomic) IBOutlet UIView *containerView;

- (IBAction)setToFour:(id)sender;
- (IBAction)setToFive:(id)sender;
- (IBAction)setToSix:(id)sender;
- (IBAction)setToSixPlus:(id)sender;

@end
