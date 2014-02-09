//
//  FLPMainMenu.m
//  FlappyPig
//
//  Created by Robert Baker on 2/7/14.
//  Copyright (c) 2014 Robert Baker. All rights reserved.
//

#import "FLPMainMenu.h"
#import "FLPMyScene.h"
#import "FLPButton.h"
#import "FLPShadowLabelNode.h"

@implementation FLPMainMenu

-(instancetype)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor lightGrayColor];
        
        [self addLabels];
        [self addButtons];
    }
    
    return self;
}

- (void)addLabels
{
    FLPShadowLabelNode *mainHeader = [FLPShadowLabelNode shadowLabelWithSKLabel:[SKLabelNode labelNodeWithFontNamed:@"MineCrafter-2.0"]];
    mainHeader.text = @"FLAPPY PIG";
    mainHeader.fontSize = 72;
    mainHeader.position = CGPointMake(self.size.width * 0.5, self.size.height);
    
    mainHeader.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:[@"FLAPPY PIG" sizeWithAttributes:@{ NSFontAttributeName : [UIFont fontWithName:@"MineCrafter-2.0" size:40.0] }]];
    mainHeader.zRotation = mainHeader.zRotation + 0.1;
    mainHeader.physicsBody.restitution = 0.4;
    
    [self addChild:mainHeader];
    
    // create a transparent barrier for the main header label to smash into
    SKSpriteNode *transparentBarrier = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(self.size.width, 1)];
    transparentBarrier.position = CGPointMake(self.size.width * 0.5, self.size.height * 0.7);
    transparentBarrier.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:transparentBarrier.size];
    transparentBarrier.physicsBody.dynamic = NO;
    [self addChild:transparentBarrier];
}

- (void)addButtons
{
    SKLabelNode *startLabel = [SKLabelNode labelNodeWithFontNamed:@"Minecraft"];
    startLabel.text = @"START GAME";
    
    FLPButton *startButton = [FLPButton buttonWithLabel:startLabel
                                               andBlock:^{
                                                   SKScene *scene = [[FLPMyScene alloc] initWithSize:self.size];
                                                   SKTransition *transition = [SKTransition fadeWithDuration:0.5];
                                                   [self.view presentScene:scene transition:transition];
                                               }];
    
    startButton.position = CGPointMake(self.size.width * 0.5, self.size.height * 0.3);
    
    [self addChild:startButton];
    
}

-(void)dealloc
{
    NSLog(@"Killed %@", self);
}

@end
