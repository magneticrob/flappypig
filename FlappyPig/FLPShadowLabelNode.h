//
//  FLPShadowLabelNode.h
//  FlappyPig
//
//  Created by Robert Baker on 2/8/14.
//  Copyright (c) 2014 Robert Baker. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface FLPShadowLabelNode : SKNode

@property (nonatomic) CGFloat fontSize;

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) SKLabelNode *label;
@property (nonatomic, strong) SKLabelNode *shadowLabel;

-(instancetype)initWithSKLabelNode:(SKLabelNode *)label;

@end
