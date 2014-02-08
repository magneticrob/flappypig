//
//  FLPShadowLabelNode.m
//  FlappyPig
//
//  Created by Robert Baker on 2/8/14.
//  Copyright (c) 2014 Robert Baker. All rights reserved.
//

#import "FLPShadowLabelNode.h"

@implementation FLPShadowLabelNode

+ (instancetype)shadowLabelWithSKLabel:(SKLabelNode *)label
{
    return [[self alloc] initWithSKLabelNode:label];
}

-(instancetype)initWithSKLabelNode:(SKLabelNode *)label
{
    if (self = [super init]) {
        self.label = label;
        self.shadowLabel = [SKLabelNode labelNodeWithFontNamed:label.fontName];
        self.shadowLabel.text = self.label.text;
        self.shadowLabel.fontColor = [UIColor darkGrayColor];
        self.shadowLabel.position = CGPointMake(self.label.position.x, self.label.position.y - 5);
        [self addChild:self.shadowLabel];
        [self addChild:self.label];
    }
    return self;
}

-(void)setText:(NSString *)text
{
    self.label.text = text;
    self.shadowLabel.text = text;
}

-(void)setFontSize:(CGFloat)fontSize
{
    self.label.fontSize = fontSize;
    self.shadowLabel.fontSize = fontSize;
}

@end
