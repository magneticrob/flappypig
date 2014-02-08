//
//  FLPGameOverOverlay.h
//  FlappyPig
//
//  Created by Robert Baker on 2/8/14.
//  Copyright (c) 2014 Robert Baker. All rights reserved.
//

#import "FLPModalOverlay.h"

@interface FLPGameOverOverlay : FLPModalOverlay

- (instancetype)initWithAnimationStyle:(OverlayAnimationStyle)animationStyle  andSize:(CGSize)size;
- (void)animate;

@property (nonatomic) CGPoint endPoint;

@end
