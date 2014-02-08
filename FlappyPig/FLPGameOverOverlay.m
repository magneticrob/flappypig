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
        FLPShadowLabelNode *gameOverLabel = [FLPShadowLabelNode shadowLabelWithSKLabel:[SKLabelNode labelNodeWithFontNamed:@"MineCrafter-2.0"]];
        gameOverLabel.text = @"GAME OVER";
        gameOverLabel.position = CGPointMake(0, self.overlay.size.height * 0.35);
        [self.overlayContainer addChild:gameOverLabel];
        
        self.restartButton = [FLPButton
    }
    
    return self;
}

- (void)animateToEndPoint:(CGFloat)endPoint
{
    switch (_animationStyle) {
        case OverlayAnimationStyleSlideFromTop:
        {
            SKAction *moveAction = [SKAction moveTo:endPoint duration:0.6];
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
