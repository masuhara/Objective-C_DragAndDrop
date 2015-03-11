//
//  ViewController.m
//  DrugAndDrop
//
//  Created by Master on 2014/01/26.
//  Copyright (c) 2014年 jp.co.mappy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate>

@end

@implementation ViewController {
    IBOutlet UIView *redView, *yellowView, *blueView;
    IBOutlet UIView *blackView;
    IBOutlet UILabel *resultLabel;
}


#pragma mark - View Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
	// add drag gesture
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [blackView addGestureRecognizer:panGesture];
    
    // bring blackView to front
    [self.view bringSubviewToFront:blackView];
    
    //init resultLabel text
    resultLabel.text = @"";
}

#pragma mark - memory worning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UIGestureRecognizerDelegate

- (void)panAction:(UIPanGestureRecognizer *)sender {
    
    CGPoint p = [sender translationInView:self.view];
    CGPoint movedPoint = CGPointMake(blackView.center.x + p.x, blackView.center.y + p.y);
    blackView.center = movedPoint;
    
    NSLog(@"move at ... %@", NSStringFromCGPoint(movedPoint));
    
    // init the moved distance (Required)
    [sender setTranslation:CGPointZero inView:self.view];
    
    // finished moving gesture
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        NSLog(@"Finished moving");
        
        if (CGRectIntersectsRect(redView.frame, blackView.frame)) {
            if (CGRectContainsPoint(redView.frame, blackView.center)) {
                resultLabel.text = @"ON RED";
            }else if(CGRectContainsPoint(yellowView.frame, blackView.center)) {
                resultLabel.text = @"ON YELLOW";
            }else if(CGRectContainsPoint(blueView.frame, blackView.center)) {
                resultLabel.text = @"ON BLUE";
            }else {
                resultLabel.text = @"ON RED";
            }
            
        }else if(CGRectIntersectsRect(yellowView.frame, blackView.frame)) {
            if (CGRectContainsPoint(redView.frame, blackView.center)) {
                resultLabel.text = @"ON RED";
            }else if(CGRectContainsPoint(yellowView.frame, blackView.center)) {
                resultLabel.text = @"ON YELLOW";
            }else if(CGRectContainsPoint(blueView.frame, blackView.center)) {
                resultLabel.text = @"ON BLUE";
            }else {
                resultLabel.text = @"ON YELLOW";
            }
            
        }else if(CGRectIntersectsRect(blueView.frame, blackView.frame)) {
            if (CGRectContainsPoint(redView.frame, blackView.center)) {
                resultLabel.text = @"ON RED";
            }else if(CGRectContainsPoint(yellowView.frame, blackView.center)) {
                resultLabel.text = @"ON YELLOW";
            }else if(CGRectContainsPoint(blueView.frame, blackView.center)) {
                resultLabel.text = @"ON BLUE";
            }else {
                resultLabel.text = @"ON BLUE";
            }
            
        }else {
            // not overlapped
            resultLabel.text = @"";
        }
    }else {
        // start gesture
        resultLabel.text = @"moving...";
    }

}




@end
