//
//  TOCViewController.m
//  Collisiontest
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included
// in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
// DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
// OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
// USE OR OTHER DEALINGS IN THE SOFTWARE.
//
//  Created by Tobias Conradi on 15.11.13.
//  Copyright (c) 2013 Tobias Conradi. All rights reserved.
//

#import "TOCViewController.h"

@interface TOCViewController () <UIDynamicAnimatorDelegate>

@property (weak, nonatomic) IBOutlet UIView *dynamicView;
@property (weak, nonatomic) IBOutlet UILabel *animatorLabel;
@property (strong, nonatomic) UIDynamicAnimator *animator;

@end

@implementation TOCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    animator.delegate = self;
    self.animator = animator;
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.dynamicView]];
    [animator addBehavior:gravity];
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.dynamicView]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [animator addBehavior:collision];
    
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc]initWithItems:@[self.dynamicView]];
    itemBehavior.elasticity = 0.5;
    [animator addBehavior:itemBehavior];
}

- (IBAction)reset:(id)sender {
    NSArray *behaviors = self.animator.behaviors;
    [self.animator removeAllBehaviors];
    self.dynamicView.center = self.view.center;
    [self.animator updateItemUsingCurrentState:self.dynamicView];
    for (UIDynamicBehavior *behavior in behaviors) {
        [self.animator addBehavior:behavior];
    }
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator {
    self.animatorLabel.text = @"Animator: off";
}
- (void)dynamicAnimatorWillResume:(UIDynamicAnimator *)animator {
    self.animatorLabel.text = @"Animator: on";
}

@end
