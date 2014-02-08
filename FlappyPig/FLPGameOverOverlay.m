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

+ (instancetype)gameOverWithAnimationStyle:(OverlayAnimationStyle)animationStyle size:(CGSize)size buttonBlock:(void (^)(void))buttonBlock score:(int)score
{
    return [[self alloc] initWithAnimationStyle:animationStyle size:size buttonBlock:buttonBlock score:score];
}

- (instancetype)initWithAnimationStyle:(OverlayAnimationStyle)animationStyle size:(CGSize)size buttonBlock:(void (^)(void))buttonBlock score:(int)score
{
    if(self = [super initWithSize:size])
    {
        self.score = score;
        [self addLabels];
        [self addButtonsWithButtonBlock:buttonBlock];
    }
    
    return self;
}

- (void)addButtonsWithButtonBlock:(void (^)(void))buttonBlock
{
    SKLabelNode *restartLabel = [SKLabelNode labelNodeWithFontNamed:@"MineCrafter-2.0"];
    restartLabel.text = @"RESTART";
    
    self.restartButton = [FLPButton buttonWithLabel:restartLabel
                                           andBlock:buttonBlock];
    self.restartButton.position = CGPointMake(0, -self.overlay.size.height * 0.4);
    [self.overlayContainer addChild:self.restartButton];
}

- (void)addLabels
{
    FLPShadowLabelNode *gameOverLabel = [FLPShadowLabelNode shadowLabelWithSKLabel:[SKLabelNode labelNodeWithFontNamed:@"MineCrafter-2.0"]];
    gameOverLabel.text = @"GAME OVER";
    gameOverLabel.position = CGPointMake(0, self.overlay.size.height * 0.35);
    [self.overlayContainer addChild:gameOverLabel];
    
    FLPShadowLabelNode *youScoredLabel = [FLPShadowLabelNode shadowLabelWithSKLabel:[SKLabelNode labelNodeWithFontNamed:@"Minecraft"]];
    youScoredLabel.text = @"YOU SCORED:";
    youScoredLabel.position = CGPointMake(0, self.overlay.size.height * 0.2);
    [self.overlayContainer addChild:youScoredLabel];
    
    FLPShadowLabelNode *scoreLabel = [FLPShadowLabelNode shadowLabelWithSKLabel:[SKLabelNode labelNodeWithFontNamed:@"MineCrafter-2.0"]];
    scoreLabel.text = [NSString stringWithFormat:@"%i", self.score];
    scoreLabel.fontSize = 128;
    scoreLabel.position = CGPointMake(0, -self.overlay.size.height * 0.225);
    [self.overlayContainer addChild:scoreLabel];
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
