//
//  FLPViewController.m
//  FlappyPig
//
//  Created by Robert Baker on 2/7/14.
//  Copyright (c) 2014 Robert Baker. All rights reserved.
//

#import "FLPViewController.h"
#import "FLPMyScene.h"
#import "FLPMainMenu.h"

@implementation FLPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];


}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    if (!skView.scene) {
        skView.showsFPS = YES;
        skView.showsNodeCount = YES;
        
        // Create and configure the scene.
        SKScene * scene = [FLPMainMenu sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        // Present the scene.
        [skView presentScene:scene];
    }
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
