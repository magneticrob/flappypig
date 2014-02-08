//
//  FLPGameOverOverlay.h
//  FlappyPig
//
//  Created by Robert Baker on 2/8/14.
//  Copyright (c) 2014 Robert Baker. All rights reserved.
//

#import "FLPModalOverlay.h"
#import "FLPButton.h"

@interface FLPGameOverOverlay : FLPModalOverlay

- (instancetype)initWithAnimationStyle:(OverlayAnimationStyle)animationStyle  andSize:(CGSize)size;
- (void)animateToEndPoint:(CGFloat)endPoint;

@property (nonatomic, strong) FLPButton *restartButton;

@end
