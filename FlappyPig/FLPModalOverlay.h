//
//  FLPModalOverlay.h
//  FlappyPig
//
//  Created by Robert Baker on 2/8/14.
//  Copyright (c) 2014 Robert Baker. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef enum {
    OverlayAnimationStyleSlideFromTop
} OverlayAnimationStyle;

@interface FLPModalOverlay : SKNode

- (instancetype)initWithSize:(CGSize)size;

@property (nonatomic, strong) SKSpriteNode *overlayContainer;
@property (nonatomic, strong) SKSpriteNode *overlayShadow;
@property (nonatomic, strong) SKSpriteNode *overlay;

@end
