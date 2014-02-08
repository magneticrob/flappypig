//
//  FLPButton.h
//  FlappyPig
//
//  Created by Robert Baker on 2/8/14.
//  Copyright (c) 2014 Robert Baker. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "FLPShadowLabelNode.h"

@interface FLPButton : SKNode

@property (nonatomic, copy) void (^buttonBlock)(void);
@property (nonatomic, strong) SKSpriteNode *buttonSprite;
@property (nonatomic, strong) FLPShadowLabelNode *buttonLabel;
@property (nonatomic) CGRect buttonRect;

- (instancetype)initWithLabel:(SKLabelNode *)label andBlock:(void (^)(void))buttonBlock;

@end
