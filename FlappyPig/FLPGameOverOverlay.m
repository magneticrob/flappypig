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

+ (instancetype)gameOverWithAnimationStyle:(OverlayAnimationStyle)animationStyle size:(CGSize)size buttonBlock:(void (^)(void))buttonBlock
{
    return [[self alloc] initWithAnimationStyle:animationStyle size:size buttonBlock:buttonBlock];
}

- (instancetype)initWithAnimationStyle:(OverlayAnimationStyle)animationStyle size:(CGSize)size buttonBlock:(void (^)(void))buttonBlock
{
    if(self = [super initWithSize:size])
    {
        FLPShadowLabelNode *gameOverLabel = [FLPShadowLabelNode shadowLabelWithSKLabel:[SKLabelNode labelNodeWithFontNamed:@"MineCrafter-2.0"]];
        gameOverLabel.text = @"GAME OVER";
        gameOverLabel.position = CGPointMake(0, self.overlay.size.height * 0.35);
        [self.overlayContainer addChild:gameOverLabel];
        
        SKLabelNode *restartLabel = [SKLabelNode labelNodeWithFontNamed:@"MineCrafter-2.0"];
        restartLabel.text = @"RESTART";
        
        self.restartButton = [FLPButton buttonWithLabel:restartLabel
                                               andBlock:buttonBlock];
        self.restartButton.position = CGPointMake(0, -self.overlay.size.height * 0.4);
        [self.overlayContainer addChild:self.restartButton];
    }
    
    return self;
}

- (void)animateToEndPoint:(CGPoint)endPoint
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
