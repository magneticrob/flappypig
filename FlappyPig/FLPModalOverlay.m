//
//  FLPModalOverlay.m
//  FlappyPig
//
//  Created by Robert Baker on 2/8/14.
//  Copyright (c) 2014 Robert Baker. All rights reserved.
//

#import "FLPModalOverlay.h"

@implementation FLPModalOverlay

- (id)initWithSize:(CGSize)size
{
    if (self = [super init]) {
        self.overlayContainer = [SKSpriteNode node];
        self.overlayContainer.zPosition = 1000;
        
        self.overlay = [SKSpriteNode spriteNodeWithColor:[UIColor grayColor] size:size];

        self.overlayShadow = [SKSpriteNode spriteNodeWithColor:[UIColor darkGrayColor] size:size];
        self.overlayShadow.position = CGPointMake(self.overlay.position.x, self.overlay.position.y - 5);
        
        [self.overlayContainer addChild:self.overlayShadow];
        [self.overlayContainer addChild:self.overlay];
        [self addChild:self.overlayContainer];
    }
    return self;
}

@end
