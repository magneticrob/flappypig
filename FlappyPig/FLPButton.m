//
//  FLPButton.m
//  FlappyPig
//
//  Created by Robert Baker on 2/8/14.
//  Copyright (c) 2014 Robert Baker. All rights reserved.
//

#import "FLPButton.h"

@implementation FLPButton

- (instancetype)initWithLabel:(SKLabelNode *)label andBlock:(void (^)(void))buttonBlock
{
    if (self = [super init]) {
        self.buttonBlock = buttonBlock;
        
        self.buttonSprite = [SKSpriteNode spriteNodeWithColor:[UIColor grayColor] size:CGSizeMake(250, 50)];
        SKSpriteNode *shadowButton = [SKSpriteNode spriteNodeWithColor:[UIColor darkGrayColor] size:CGSizeMake(250, 50)];
        shadowButton.position = CGPointMake(self.buttonSprite.position.x, self.buttonSprite.position.y - 5);
        
        self.buttonRect = [self.buttonSprite frame];
        
        self.buttonLabel = [[FLPShadowLabelNode alloc] initWithSKLabelNode:label];
        self.buttonLabel.position = CGPointMake(self.buttonLabel.position.x, -self.buttonRect.size.height * 0.3);
        
        self.userInteractionEnabled = YES;

        [self addChild:shadowButton];
        [self addChild:self.buttonSprite];
        
        [self addChild:self.buttonLabel];
    }
    
    return self;
}

- (CGRect)buttonRect {
    
    CGPoint pos = [self position];
    CGFloat originX = pos.x - (self.buttonSprite.frame.size.width * 0.5);
    CGFloat originY = pos.y - (self.buttonSprite.frame.size.height * 0.5);
    CGFloat width = self.buttonSprite.frame.size.width;
    CGFloat height = self.buttonSprite.frame.size.height;
    
    _buttonRect = CGRectMake(originX, originY, width, height);
    
    return _buttonRect;
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.buttonBlock();
}

@end
