//
//  PHNYScreenViewController.m
//  Pods
//
//  Created by Fabian Canas on 10/25/14.
//  Copyright (c) 2014 Fabian Canas. All rights reserved.
//

#import "PHNYScreenViewController.h"

@interface PHNYScreenViewController ()
@property (strong, nonatomic) NSArray *internalConstraints;

@property (strong, nonatomic) NSArray *sizeConstraints;
@end

@implementation PHNYScreenViewController

- (IBAction)setToFour:(id)sender
{
    [self constrainToSize:CGSizeMake(320, 480)
                     view:self.containerView];
}

- (IBAction)setToFive:(id)sender
{
    [self constrainToSize:CGSizeMake(320, 568)
                     view:self.containerView];
}

- (IBAction)setToSix:(id)sender
{
    [self constrainToSize:CGSizeMake(375, 667)
                     view:self.containerView];
}

- (IBAction)setToSixPlus:(id)sender
{
    [self constrainToSize:CGSizeMake(414, 736)
                     view:self.containerView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self constrainToSize:CGSizeMake(320, 480)
                     view:self.containerView];
}

- (void)constrainToSize:(CGSize)size view:(UIView *)view
{
    if (self.sizeConstraints) {
        [self.view removeConstraints:self.sizeConstraints];
        self.sizeConstraints = nil;
    }
    
    NSLayoutConstraint *widthConstraint;
    widthConstraint = [NSLayoutConstraint constraintWithItem:view
                                                   attribute:NSLayoutAttributeWidth
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:nil
                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                  multiplier:1.0
                                                    constant:size.width];
    NSLayoutConstraint *heightConstraint;
    heightConstraint = [NSLayoutConstraint constraintWithItem:view
                                                    attribute:NSLayoutAttributeHeight
                                                    relatedBy:NSLayoutRelationEqual
                                                       toItem:nil
                                                    attribute:NSLayoutAttributeNotAnAttribute
                                                   multiplier:1.0
                                                     constant:size.height];
    
    self.sizeConstraints = @[widthConstraint, heightConstraint];
    [self.view addConstraints:self.sizeConstraints];
    [UIView animateWithDuration:0.3
                     animations:^{
                         [self.view layoutIfNeeded];
                     }];
}

- (void)setRootViewController:(UIViewController *)rootViewController
{
    [_rootViewController willMoveToParentViewController:nil];
    [_rootViewController.view removeFromSuperview];
    [_rootViewController removeFromParentViewController];
    
    _rootViewController = rootViewController;
    
    [self addChildViewController:_rootViewController];
    [self.containerView addSubview:_rootViewController.view];
    
    static const NSArray *constraintAttributes;
    constraintAttributes = @[@(NSLayoutAttributeTop),
                             @(NSLayoutAttributeRight),
                             @(NSLayoutAttributeBottom),
                             @(NSLayoutAttributeLeft)];
    
    [self.containerView removeConstraints:self.internalConstraints];
    
    NSMutableArray *constraints = [NSMutableArray array];
    [constraintAttributes enumerateObjectsUsingBlock:^(NSNumber *number, NSUInteger idx, BOOL *stop) {
        NSLayoutConstraint *c;
        c = [NSLayoutConstraint constraintWithItem:rootViewController.view
                                         attribute:number.integerValue
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:self.containerView
                                         attribute:number.integerValue
                                        multiplier:1.0
                                          constant:0];
        [constraints addObject:c];
    }];
    
    [self.containerView addConstraints:constraints];
    self.internalConstraints = constraints;
    
    [_rootViewController didMoveToParentViewController:self];
}

@end
