//
//  FLPGameOverOverlay.m
//  FlappyPig
//
//  Created by Robert Baker on 2/8/14.
//  Copyright (c) 2014 Robert Baker. All rights reserved.
//

#import "FLPGameOverOverlay.h"
#import "FLPShadowLabelNode.h"

@implementation FLPGameOverOverlay
{
    OverlayAnimationStyle _animationStyle;
}

- (instancetype)initWithAnimationStyle:(OverlayAnimationStyle)animationStyle andSize:(CGSize)size
{
    if(self = [super initWithSize:size])
    {
        FLPShadowLabelNode *gameOverLabel = [[FLPShadowLabelNode alloc] initWithSKLabelNode:[SKLabelNode labelNodeWithFontNamed:@"MineCrafter-2.0"]];
        gameOverLabel.text = @"GAME OVER";
        gameOverLabel.position = CGPointMake(0, self.overlay.size.height * 0.35);
        [self.overlayContainer addChild:gameOverLabel];
    }
    
    return self;
}

- (void)animate
{
    switch (_animationStyle) {
        case OverlayAnimationStyleSlideFromTop:
        {
            SKAction *moveAction = [SKAction moveTo:self.endPoint duration:0.6];
            moveAction.timingMode = SKActionTimingEaseInEaseOut;
            [self.overlayContainer runAction:moveAction];
            break;
        }
            
        default:
        {
            break;
        }
    }
}

@end
